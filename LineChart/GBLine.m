//
//  GBLine.m
//  LineChart
//
//  Created by 袁云龙 on 16/8/7.
//  Copyright © 2016年 袁云龙. All rights reserved.
//

#import "GBLine.h"

@interface GBLine ()
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,strong) UIColor *startColor;
@property (nonatomic,strong) UIColor *endColor;
@property (nonatomic,strong) UIColor *pointColor;

@property (nonatomic,strong) NSMutableArray *coordinatePointsArr;//画图的坐标点
@property (nonatomic,strong) NSMutableArray *yAxisValue;//y轴值

@property (nonatomic,strong) NSArray *originalDataArr;//原始数据
@property (nonatomic,copy)   NSArray *yTitles;  // 每一个点的titile
@property (nonatomic,strong) NSNumber *maxValue;  //用于计算
@property (nonatomic,strong) NSNumber *minValue;
@property (nonatomic,assign) GBLineType chartType;//图表类型（标识是什么图表）


@property (nonatomic,assign) CGPoint maxPointY;

//修改绘图的绘图区域
@property (nonatomic, assign) float startXspace;
@property (nonatomic, assign) float startYspace;
@property (nonatomic, assign) float endXspace;
@property (nonatomic, assign) float endYspace;

@property (nonatomic, assign) float lineSpace;
@end

@implementation GBLine

- (instancetype)initWithFrame:(CGRect)frame
                         data:(NSArray *)dataArr             //point Value
                 andLineColor:(UIColor *)lineColor
                   startColor:(UIColor *)startColor
                     endColor:(UIColor *)endColor
                   pointColor:(UIColor *)pointColor
                    chartType:(GBLineType)chartType           // now is lineChart
                     maxValue:(NSNumber *)maxValue           //maxValue
                     minValue:(NSNumber *)minValue           //minValue
                      yTitles:(NSArray *)yTitles
                   leftXspace:(float)leftXspace
                    topYspace:(float)topYspace
                  rightXspace:(float)rightXspace
                 bottomYspace:(float)bottomYspace
                    lineSpace:(float)LineSpace
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        

        
        _lineColor = lineColor;
        _startColor = startColor;
        _endColor = endColor;
        _pointColor = pointColor;
        
        _chartType = chartType;      // 折线
        
        
        _originalDataArr = dataArr;    //每一个点Y的值
        _maxValue = maxValue;          //最大的Y值
        _minValue = minValue;          //最小的Y值
        _yTitles = yTitles;
        
        _startXspace = leftXspace;
        _startYspace = topYspace;
        _endXspace   = rightXspace;
        _endYspace   = bottomYspace;
        

        _lineSpace = LineSpace;
        _coordinatePointsArr = [[NSMutableArray alloc] init];
        
        [self calculateValue];
        
    }
    return self;
}


- (void)calculateValue
{
  
    NSAssert(_yTitles.count == _originalDataArr.count, @"title and point must equal");
    CGRect frame = self.frame;
    NSUInteger count = _yTitles.count;
    float Xspace = _lineSpace;
    
    float DrawYHeight = frame.size.height - _startYspace - _endYspace;
    
    
    for (int i = 0; i < count; i++) {
        NSNumber *YValue = _originalDataArr[i];
        float Ypoint = 0;
        if (YValue.floatValue <= _maxValue.floatValue && YValue.floatValue >= _minValue.floatValue) {
            Ypoint = (YValue.floatValue - _minValue.floatValue)/(_maxValue.floatValue - _minValue.floatValue)*DrawYHeight;
           
        }else if(YValue.floatValue > _maxValue.floatValue){
            continue;
            //Ypoint = DrawYHeight;
        }else if(YValue.floatValue < _minValue.floatValue){
            continue;
            //Ypoint = 0;
        }
        
        CGPoint drawPoint = CGPointMake(_startYspace + Xspace*i, frame.size.height - Ypoint - _startYspace);
        
        CATextLayer *textLayer = [[CATextLayer alloc]init];
        textLayer.bounds = CGRectMake(0, 0, 50, 20);
        float xOffset = 3;
        float yOffset = 8;
        float yPosition = frame.size.height - Ypoint - _startYspace - yOffset;
        if (yPosition) {
            NSLog(@"xxx %f",yPosition);
        }
        textLayer.position = CGPointMake(_startYspace + Xspace*i + xOffset, yPosition);
        textLayer.anchorPoint = CGPointMake(0, 1);
        textLayer.string = _yTitles[i];
        textLayer.fontSize = 13.0f;
        textLayer.foregroundColor = _pointColor.CGColor;
        textLayer.rasterizationScale = [UIScreen mainScreen].scale;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:textLayer];
        
        
        [_coordinatePointsArr addObject:[NSValue valueWithCGPoint:drawPoint]];
    }

}



- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    
    UIBezierPath *path1 = [[UIBezierPath alloc]init];
    path1.lineWidth = 1.0;
    
    UIBezierPath *cirlePath = [[UIBezierPath alloc]init];
    cirlePath.lineWidth = 4;
    [_lineColor setStroke];
    
    if (_coordinatePointsArr.count < 1) {
        return ;
    }
    
    NSValue *pointValue = _coordinatePointsArr[0];
    CGPoint point = pointValue.CGPointValue;
    [path moveToPoint:point];
    
    [path1 moveToPoint:CGPointMake(_startYspace, rect.size.height - _startYspace)];
    
    CGPoint prePoint = point;
    if (_chartType == GBLine_Broken_Type) {
        for (int i = 0; i < _coordinatePointsArr.count; i++) {
            NSValue *pointValue = _coordinatePointsArr[i];
            CGPoint point = pointValue.CGPointValue;
            [path addLineToPoint:point];
            [path1 addLineToPoint:point];
            
            [cirlePath moveToPoint:point];
            [cirlePath addArcWithCenter:point radius:5 startAngle:0 endAngle:M_PI*2 clockwise:true];
        }
    }else if(_chartType == GBLine_Curve_Type){
        for (int i = 0; i < _coordinatePointsArr.count; i++) {
            NSValue *pointValue = _coordinatePointsArr[i];
            CGPoint point = pointValue.CGPointValue;
            
            float midX = (point.x + prePoint.x)/2;
            [path addCurveToPoint:point controlPoint1:CGPointMake(midX, prePoint.y) controlPoint2:CGPointMake(midX, point.y)];
            [path1 addCurveToPoint:point controlPoint1:CGPointMake(midX, prePoint.y) controlPoint2:CGPointMake(midX, point.y)];

            [cirlePath moveToPoint:point];
            [cirlePath addArcWithCenter:point radius:5 startAngle:0 endAngle:M_PI*2 clockwise:true];
            
            prePoint = point;
        }
    }
    
    [path1 addLineToPoint:CGPointMake(rect.size.width - _endXspace, rect.size.height - _startYspace)];
    [path stroke];
    
    [_pointColor setStroke];
    [_pointColor setFill];
    [cirlePath fill];
    
 
    
    CGPoint maxPoint = CGPointMake(0, 0);
    
    //绘制填充渐变色
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    CGContextSaveGState(ctx);//上下文推入堆栈
    [path1 addClip];//裁剪出闭包区域（要填充颜色的区域）
    
    CGFloat locations[2] = {0.0,1.0};//渐变颜色位置数组
    CGFloat components[8];//颜色分量数组（包含RGB和alpha值） = {0xff/255.,0xd7/255.,0x6a/255.,0.8,1,1,1.,0.0};
    [_startColor getRed:(&components[0]) green:(&components[1]) blue:(&components[2]) alpha:(&components[3])];//渐变起始颜色
    [_endColor getRed:(&components[4]) green:(&components[5]) blue:(&components[6]) alpha:(&components[7])];//渐变结束颜色
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();//创建RGB色彩空间，你可以简单的理解为创建这个之后context里面用的全是RGB表示的颜色就可以了。
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);//创建渐变对象（第4个参数是渐变的颜色个数）
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(rect.size.width/2.0, maxPoint.y<0?0:maxPoint.y),
                                CGPointMake(rect.size.width/2.0, rect.size.height), 0);//绘制渐变（第3个参数是渐变起点、第4个参数是渐变终点、第5个参数是当你的起点或者终点不在图形上下文的边缘内时，指定该如何处理，0表示不扩展渐变）
    CGGradientRelease(gradient);//释放渐变对象
    CGColorSpaceRelease(colorspace);//释放色彩空间
    CGContextRestoreGState(ctx);//修改完成后，通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态

}

@end
