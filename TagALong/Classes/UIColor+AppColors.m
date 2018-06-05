//
//  UIColor+AppColors.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIColor+AppColors.h"

@implementation UIColor (AppColors)

+ (UIColor*)appColor {
    return [UIColor colorWithRed:(37.0f/255.0f) green:(135.0f/255.0f) blue:(233.0f/255.0f) alpha:1.0];
}

+ (UIColor*)warningColor {
    return [UIColor colorWithRed:(1.0/198.0) green:(1.0/27.0) blue:(1.0/27.0) alpha:1.0];
}

+ (UIColor*)textColor {
    return [UIColor.whiteColor colorWithAlphaComponent:0.8f];
}

+ (UIColor*)titleColor {
    return [UIColor.whiteColor colorWithAlphaComponent:0.5f];
}

+ (UIColor*)placeholderColor {
    return [UIColor.whiteColor colorWithAlphaComponent:0.2f];
}

+ (UIColor*)regularBackgroundColor {
    return [UIColor colorWithRed:(36.0 / 255.0) green:(37.0 / 255.0) blue:(54.0 / 255.0) alpha:1.0];
}

+ (NSArray*)backgroundGradientColors {
    
    UIColor *upColor = [UIColor colorWithRed:(51.0f / 255.0f)
                                       green:(52.0f / 255.0f)
                                        blue:(67.0f / 255.0f)
                                       alpha:1.0f];
    
    UIColor *downColor = [UIColor colorWithRed:(36.0f / 255.0f)
                                         green:(37.0f / 255.0f)
                                          blue:(53.0f / 255.0f)
                                         alpha:1.0f];
    
    return @[(id)upColor.CGColor, (id)downColor.CGColor];
}

+ (NSArray*)topGradientColors {
    
    UIColor *upColor = [[UIColor regularBackgroundColor] colorWithAlphaComponent:1.0f];
    UIColor *downColor = [[UIColor regularBackgroundColor] colorWithAlphaComponent:0.0f];
    
    return @[(id)upColor.CGColor, (id)downColor.CGColor];
}

+ (NSArray*)bottomGradientColors {
    
    UIColor *upColor = [[UIColor regularBackgroundColor] colorWithAlphaComponent:0.0f];
    UIColor *downColor = [[UIColor regularBackgroundColor] colorWithAlphaComponent:1.0f];
    
    return @[(id)upColor.CGColor, (id)downColor.CGColor];
}

+ (NSArray*)regularUserBackgroundGradientColors {
    
    UIColor *upColor = [UIColor colorWithRed:(36.0f / 255.0f)
                                       green:(36.0f / 255.0f)
                                        blue:(54.0f / 255.0f)
                                       alpha:1.0f];
    
    UIColor *downColor = [UIColor colorWithRed:(35.0f / 255.0f)
                                         green:(23.0f / 255.0f)
                                          blue:(29.0f / 255.0f)
                                         alpha:1.0f];
    
    return @[(id)upColor.CGColor, (id)downColor.CGColor];
}

+ (NSArray*)expertUserBackgroundGradientColors {
    
    UIColor *downColor = [UIColor colorWithRed:(51.0f / 255.0f)
                                       green:(52.0f / 255.0f)
                                        blue:(67.0f / 255.0f)
                                       alpha:1.0f];
    
    UIColor *upColor = [UIColor colorWithRed:(32.0f / 255.0f)
                                         green:(102.0f / 255.0f)
                                          blue:(147.0f / 255.0f)
                                         alpha:1.0f];
    
    return @[(id)upColor.CGColor, (id)downColor.CGColor];
}

#pragma mark - User Type Color

+ (UIColor*)individualTextColor {
    return [UIColor blackColor];
}

+ (UIColor*)individualBackgroundColor {
    return [UIColor whiteColor];
}

+ (UIColor*)gymTextColor {
    return [UIColor whiteColor];
}

+ (UIColor*)gymBackgroundColor {
    return [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
}

+ (UIColor*)proTextColor {
    return [UIColor blackColor];
}

+ (UIColor*)proBackgroundColor {
    return [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
}

+ (UIColor*)trainerTextColor {
    return [UIColor whiteColor];
}

+ (UIColor*)trainerBackgroundColor {
    return [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
}

@end
