//
//  GBWeekChartView.h
//  GrowingBaby
//
//  Created by yuan yunlong on 16/8/5.
//  Copyright © 2016年 yuan yunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBWeekChartView : UIView

@property (nonatomic, strong) NSArray *itemArray;

- (void)setXtitle:(NSArray *)data;

@end
