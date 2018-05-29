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
+ (UIColor*)placeholderColor;

+ (UIColor*)regularBackgroundColor;

+ (NSArray*)backgroundGradientColors;
+ (NSArray*)topGradientColors;
+ (NSArray*)bottomGradientColors;

+ (NSArray*)regularUserBackgroundGradientColors;
+ (NSArray*)expertUserBackgroundGradientColors;

#pragma mark - User Type Color

+ (UIColor*)individualTextColor;
+ (UIColor*)individualBackgroundColor;

+ (UIColor*)gymTextColor;
+ (UIColor*)gymBackgroundColor;

+ (UIColor*)proTextColor;
+ (UIColor*)proBackgroundColor;

+ (UIColor*)trainerTextColor;
+ (UIColor*)trainerBackgroundColor;

@end
