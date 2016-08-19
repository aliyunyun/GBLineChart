//
//  ViewController.m
//  LineChart
//
//  Created by 袁云龙 on 16/8/7.
//  Copyright © 2016年 袁云龙. All rights reserved.
//

#import "ViewController.h"
#import "GBWeekChartView.h"
#import "GBChartLineItem.m"
#import "YYKit.h"
@interface ViewController ()
@property (nonatomic, strong) GBWeekChartView *chartView;
@property (strong, nonatomic)  UIView *scrollviewBack;
@property (nonatomic, strong) NSMutableArray *monthXtitleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    float heihtRdio = 210.0/375.0 ;
    
    float screenWidth =  [UIScreen mainScreen].bounds.size.width;
    
    self.scrollviewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  screenWidth , heihtRdio*screenWidth)];
    self.chartView = [[GBWeekChartView alloc]initWithFrame:CGRectMake(0, 0,  screenWidth , heihtRdio*screenWidth)];
    [self.scrollviewBack addSubview:self.chartView];
    [self.view addSubview:self.scrollviewBack];
    
    [self createTitle];
    [self.chartView setXtitle:self.monthXtitleArray];
    
    [self createLineData];
}

- (void)createLineData
{
    NSArray *valueArray = @[@1,@20,@22,@23,@43,@60,@54,@50,@60,@53,@12,@35];
    NSArray *titleArray = @[@"10kg",@"20kg",@"22kg",@"23kg",@"43kg",@"60kg",@"54kg",@"50kg",@"60kg",@"53kg",@"23kg",@"35kg"];
    
    NSArray *valueArray1 = @[@31,@58,@46,@78,@43,@90,@195,@102,@129,@132,@154,@210];
    NSArray *titleArray1 = @[@"30cm",@"58cm",@"46cm",@"78cm",@"43cm",@"90cm",@"165cm",@"102cm",@"129cm",@"132cm",@"154cm",@"210cm"];
    
    [self createLineViewWithWeightDataArray:valueArray WeightyTitleArray:titleArray heightDataArray:valueArray1 heightyTitleArray:titleArray1];
}

- (void)createLineViewWithWeightDataArray:(NSArray *)WeightDataArray WeightyTitleArray:(NSArray *)WeightYtitleArray heightDataArray:(NSArray *)heightDataArray heightyTitleArray:(NSArray *)heightYtitleArray
{
    
    GBChartLineItem *item1 = [GBChartLineItem new];
    UIColor *lineColor = [UIColor colorWithHexString:@"ffd74e"];
    UIColor *pointColor = [UIColor colorWithHexString:@"ffd74e"];
    item1.dataArr = WeightDataArray;
    item1.yTitles = WeightYtitleArray;
    item1.lineColor = lineColor;
    item1.pointColor = pointColor;
    item1.maxValue = @100;
    item1.minValue = @1;
    item1.lineType = GBLine_Broken_Type;
    
    GBChartLineItem *heightItem = [GBChartLineItem new];
    UIColor *lineColor1 = [UIColor colorWithHexString:@"5ee1e2"];
    UIColor *pointColor1 = [UIColor colorWithHexString:@"5ee1e2"];
    heightItem.dataArr = heightDataArray;
    heightItem.yTitles = heightYtitleArray;
    heightItem.lineColor = lineColor1;
    heightItem.pointColor = pointColor1;
    heightItem.maxValue = @210;
    heightItem.minValue = @30;
    heightItem.lineType = GBLine_Curve_Type;
    
    [self.chartView setItemArray:@[item1, heightItem]];
}


- (void)createTitle
{
    _monthXtitleArray = [NSMutableArray new];
    int year = 2016 ;
    //今年的月份
    for (int i = 1; i <= 12; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%4d-%02d",year, i];
        [_monthXtitleArray addObject:yearStr];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
