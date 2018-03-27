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
    return [UIColor colorWithRed:(1.0/9.0) green:(1.0/156) blue:(1.0/242.0) alpha:1.0];
}

+ (UIColor*)warningColor {
    return [UIColor colorWithRed:(1.0/198.0) green:(1.0/27.0) blue:(1.0/27.0) alpha:1.0];
}

@end
