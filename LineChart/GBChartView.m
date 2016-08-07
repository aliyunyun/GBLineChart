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
@end

@implementation GBChartView

float LineSpaceHorizion = 20.0;
float LineSpaceVeritical = 30.0;

float startSpaceX = 30.0;
float endSpaceX = 30;

float startSpaceY = 30;
float endSpaceY = 30;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self drawCoordinateVertical];
    [self drawCoordinateHorizion];
    
    [self addLine];
}

- (void)drawCoordinateVertical
{
    
    _verticalLayer = [[CAShapeLayer alloc]init];
    _verticalLayer.backgroundColor = [UIColor clearColor].CGColor;
    _verticalLayer.fillColor = [UIColor orangeColor].CGColor;
    _verticalLayer.strokeColor = [UIColor grayColor].CGColor;
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
    _horizionLayer.fillColor = [UIColor orangeColor].CGColor;
    _horizionLayer.strokeColor = [UIColor grayColor].CGColor;
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


- (void)addLine
{
    NSArray *dataAray = @[@11 , @20 , @39 , @45,@11 , @20 , @39 , @45, @23 ];
    NSArray *title    = @[@"11kg", @"20kg", @"23kg", @"24kg", @"11kg", @"20kg", @"23kg", @"24kg", @"23kg"];
    
    GBLine *line =  [[GBLine alloc]initWithFrame:self.bounds data:dataAray andLineColor:[UIColor grayColor] startColor:[UIColor clearColor] endColor:[UIColor clearColor] pointColor:[UIColor orangeColor] chartType:1 maxValue:@60 minValue:@10 yTitles:title leftXspace:startSpaceX topYspace:startSpaceY rightXspace:endSpaceX bottomYspace:endSpaceY];
    line.layer.shouldRasterize = true;
    [self addSubview:line];
}
@end
