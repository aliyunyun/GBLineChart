//
//  GBChartView.h
//  LineChart
//
//  Created by 袁云龙 on 16/8/7.
//  Copyright © 2016年 袁云龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBChartLineItem.h"
@interface GBChartView : UIView

@property (nonatomic, assign) float Xspace;
@property (nonatomic, strong) UIView  *XtitleBackView;  //水平title的背景UIView
@property (nonatomic, strong) NSArray *XtitleArray;     //水平title,内容是NSString
@property (nonatomic, strong) NSArray<GBChartLineItem *> *itemArray;      //line Item Array

//重要
- (void)computeCoordinate;                    //设置完属性后，计算一下坐标，然后************
- (instancetype)initWithFrame:(CGRect)frame;

@end
