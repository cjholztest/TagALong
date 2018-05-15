//
//  UITextView+TextSize.m
//  TagALong
//
//  Created by User on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UITextView+TextSize.h"
#import "NSString+TextSize.h"

@implementation UITextView (TextSize)

- (CGFloat)textHeight {
    
    CGSize textSize = [self.text sizeByWidth:self.bounds.size.width withFont:self.font];
    return textSize.height;
}

@end
