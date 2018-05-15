//
//  UIColor+AppColors.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AppColors)

+ (UIColor*)appColor;
+ (UIColor*)warningColor;

+ (UIColor*)textColor;
+ (UIColor*)titleColor;

+ (UIColor*)regularBackgroundColor;

+ (NSArray*)backgroundGradientColors;

+ (NSArray*)regularUserBackgroundGradientColors;
+ (NSArray*)expertUserBackgroundGradientColors;

@end
