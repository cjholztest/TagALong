//
//  NSString+TextSize.h
//  TagALong
//
//  Created by User on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)

- (CGSize)sizeByWidth:(CGFloat)width withFont:(UIFont*)font;

@end
