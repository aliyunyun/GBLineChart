//
//  GBLine.h
//  LineChart
//
//  Created by 袁云龙 on 16/8/7.
//  Copyright © 2016年 袁云龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBLine : UIView

- (instancetype)initWithFrame:(CGRect)frame
                         data:(NSArray *)dataArr             //point Value
                 andLineColor:(UIColor *)lineColor
                   startColor:(UIColor *)startColor
                     endColor:(UIColor *)endColor
                   pointColor:(UIColor *)pointColor
                    chartType:(NSInteger)chartType           // now is lineChart
                     maxValue:(NSNumber *)maxValue           //maxValue
                     minValue:(NSNumber *)minValue           //minValue
                      yTitles:(NSArray *)yTitles
                   leftXspace:(float)leftXspace
                    topYspace:(float)topYspace
                  rightXspace:(float)rightXspace
                 bottomYspace:(float)bottomYspace
                    lineSpace:(float)LineSpace
;            //point title




@end
