//
//  GBChartView.m
//  LineChart
//
//  Created by 袁云龙 on 16/8/7.
//  Copyright © 2016年 袁云龙. All rights reserved.
//

#import "GBChartView.h"
#import "GBLine.h"

@interface GBChartView()
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIBezierPath *horizonPath;
@property (nonatomic, strong) UIBezierPath *verticalPath;

@property (nonatomic, strong) CAShapeLayer *verticalLayer;
@property (nonatomic, strong) CAShapeLayer *horizionLayer;

@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleArray;
@end

@implementation GBChartView

float LineSpaceHorizion = 20.0;
float LineSpaceVeritical = 30.0;

float startSpaceX = 30.0;
float endSpaceX = 50;

float startSpaceY = 30;
float endSpaceY = 30;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self addTitleBackView];
        _lineArray = [NSMutableArray new];
        _titleArray = [NSMutableArray new];
    }
    return self;
}

- (void)addTitleBackView
{
    [self addSubview:self.XtitleBackView];
    [self.XtitleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(30);
    }];
}

- (void)initView
{
    [self drawCoordinateVertical];
   // [self drawCoordinateHorizion];
   // [self addLine];
}

- (void)computeCoordinate
{
    [self cleanTitleAndCoordinate];
    
    [self initView];
    [self drawTitleLabel];
}

- (void)cleanTitleAndCoordinate
{
    [_verticalLayer removeFromSuperlayer];
    [_horizionLayer removeFromSuperlayer];
    _verticalLayer = nil;
    _horizionLayer = nil;
    for (UILabel *label in _titleArray) {
        [label removeFromSuperview];
    }
    [_titleArray removeAllObjects];
}


- (void)cleanLine
{
    for (GBLine *line in _lineArray) {
        [line removeFromSuperview];
    }
    [_lineArray removeAllObjects];
}

- (void)drawCoordinateVertical
{
    
    _verticalLayer = [[CAShapeLayer alloc]init];
    _verticalLayer.backgroundColor = [UIColor clearColor].CGColor;
    _verticalLayer.strokeColor = [UIColor colorWithHexString:@"e9e9eb"].CGColor;
    _verticalLayer.frame = self.bounds;
    _verticalLayer.lineWidth  = 1;
    
    [self.layer addSublayer:_verticalLayer];
    _verticalPath = [[UIBezierPath alloc]init];
    
    CGRect rect =  self.bounds;
    
    float startX = 0 + startSpaceX;
    float startY = 0 + startSpaceY;

    while (startX <= rect.size.width - endSpaceX) {
        
        CGPoint startPoint = CGPointMake(startX, startY);
        CGPoint endPoint = CGPointMake(startX, rect.size.height - endSpaceY);
        
        [_verticalPath moveToPoint:startPoint];
        [_verticalPath addLineToPoint:endPoint];
        
        startX += LineSpaceVeritical;
    }

    _verticalLayer.path = _verticalPath.CGPath;
}

- (void)drawCoordinateHorizion
{
    _horizionLayer = [[CAShapeLayer alloc]init];
    _horizionLayer.backgroundColor = [UIColor clearColor].CGColor;
    _horizionLayer.strokeColor = [UIColor colorWithHexString:@"e9e9eb"].CGColor;
    _horizionLayer.frame = self.bounds;
    _horizionLayer.lineWidth  = 1;
    
    [self.layer addSublayer:_horizionLayer];
    _horizonPath = [[UIBezierPath alloc]init];
    
    CGRect rect =  self.bounds;
    
    float startX = 0 + startSpaceX;
    float startY = rect.size.height - endSpaceY;
    
    while (startY >= endSpaceY) {
        
        CGPoint startPoint = CGPointMake(startX, startY);
        CGPoint endPoint = CGPointMake(rect.size.width - endSpaceX, startY);
        
        [_horizonPath moveToPoint:startPoint];
        [_horizonPath addLineToPoint:endPoint];
        
        startY -= LineSpaceHorizion;
    }
    
    _horizionLayer.path = _horizonPath.CGPath;
}

- (void)drawTitleLabel
{
    if (self.XtitleArray == nil ) {
        return;
    }

    for (int i = 0; i < self.XtitleArray.count; i++) {
        NSString *Xtitle = self.XtitleArray[i];
        UILabel *label = [self createTitleLabel];
        label.text = Xtitle;
        label.frame = CGRectMake(i*LineSpaceVeritical + startSpaceX - LineSpaceVeritical/2, 0, LineSpaceVeritical, 30);
        [_titleArray addObject:label];
        [self.XtitleBackView addSubview:label];
    }
}


#pragma mark setter
- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    
    //每一次重设ItemArray 重绘图
    
    [self cleanLine];
    for (GBChartLineItem *item in itemArray) {
        GBLine *line = [self createLineWithItem:item];
        [_lineArray addObject:line];
        [self addSubview:line];
    }
}


- (void)setXspace:(float)Xspace
{
    _Xspace = Xspace;
    LineSpaceVeritical = Xspace;
 
}

- (void)setXtitleArray:(NSArray *)XtitleArray
{
    _XtitleArray = XtitleArray;

}


#pragma mark getter
- (UIView *)XtitleBackView
{
    if (_XtitleBackView == nil) {
        _XtitleBackView = [UIView new];
        _XtitleBackView.backgroundColor = [UIColor colorWithHexString:@"f1f1f2"];
    }
    return _XtitleBackView;
}

- (UILabel *)createTitleLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithHexString:@"a5a5a5"];
    label.textAlignment = NSTextAlignmentCenter;
    label.size = CGSizeMake(50, 30);
    return label;
}

- (GBLine *)createLineWithItem:(GBChartLineItem *)item
{
    NSAssert(item, @"请配置item");
    GBLine *line =  [[GBLine alloc]initWithFrame:self.bounds data:item.dataArr andLineColor:item.lineColor startColor:[UIColor clearColor] endColor:[UIColor clearColor] pointColor:item.pointColor     chartType:1 maxValue:item.maxValue minValue:item.minValue yTitles:item.yTitles leftXspace:startSpaceX topYspace:startSpaceY rightXspace:endSpaceX bottomYspace:endSpaceY lineSpace:LineSpaceVeritical];
    line.layer.shouldRasterize = true;
    
    return line;
}

@end
