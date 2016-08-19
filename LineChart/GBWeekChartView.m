//
//  GBWeekChartView.m
//  GrowingBaby
//
//  Created by yuan yunlong on 16/8/5.
//  Copyright © 2016年 yuan yunlong. All rights reserved.
//

#import "GBWeekChartView.h"
#import "GBChartView.h"
@interface GBWeekChartView()
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) GBChartView *chartView;
@property (nonatomic, assign) int numberOfLine;

@end
@implementation GBWeekChartView
@synthesize chartView;
const static float LineSpace = 60;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


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
    [self addSubview:self.scrollview];
    
    self.numberOfLine = 30;
    chartView = [[GBChartView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    chartView.backgroundColor = [UIColor whiteColor];
    chartView.Xspace = LineSpace;
    [self.scrollview addSubview:chartView];
}

- (void)vreateChartView
{

}

- (void)setXtitle:(NSArray *)data
{
    chartView.XtitleArray = data;
    self.numberOfLine = (NSInteger)data.count;
    [chartView computeCoordinate];
}

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    [chartView setItemArray:itemArray];
}

#pragma mark setter

- (void)setNumberOfLine:(int)numberOfLine
{
    _numberOfLine = numberOfLine;
    float space = 40;
    self.scrollview.contentSize = CGSizeMake(LineSpace*_numberOfLine + space , 0);
    chartView.frame = CGRectMake(0, 0, LineSpace*_numberOfLine + space, self.frame.size.height);
   
    _scrollview.contentOffset = CGPointMake(LineSpace*_numberOfLine + space -  [UIScreen mainScreen].bounds.size.width - LineSpace, 0);
}

#pragma mark getter

- (UIScrollView *)scrollview
{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollview.contentOffset =  CGPointZero;
        _scrollview.bounces = false;
        _scrollview.backgroundColor = [UIColor whiteColor];
        _scrollview.showsHorizontalScrollIndicator = false;
    }
    return _scrollview;
}

@end
