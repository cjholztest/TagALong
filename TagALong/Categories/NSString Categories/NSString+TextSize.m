//
//  NSString+TextSize.m
//  TagALong
//
//  Created by User on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)

- (CGSize)sizeByWidth:(CGFloat)width withFont:(UIFont*)font {
    
    CGRect textRect = [self boundingRectWithSize : CGSizeMake(width, MAXFLOAT)
                                         options : NSStringDrawingUsesLineFragmentOrigin
                                      attributes : @{ NSFontAttributeName : font }
                                         context : nil];
    return textRect.size;
}

@end
