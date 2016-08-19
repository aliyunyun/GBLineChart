//
//  GBChartLineItem.h
//  GrowingBaby
//
//  Created by yuan yunlong on 16/8/13.
//  Copyright © 2016年 yuan yunlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, GBLineType)
{
    GBLine_Broken_Type,
    GBLine_Curve_Type
};


@interface GBChartLineItem : NSObject


@property (nonatomic, strong) NSArray *dataArr   ;          //point Value
@property (nonatomic, strong) NSNumber *maxValue ;
@property (nonatomic, strong) NSNumber *minValue ;
@property (nonatomic, strong) NSArray  *yTitles  ;

@property (nonatomic, strong) UIColor *lineColor ;
@property (nonatomic, strong) UIColor *pointColor;

@property (nonatomic, assign) GBLineType  lineType;


@end
