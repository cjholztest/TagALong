//
//  UIFont+HelveticaNeue.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIFont+HelveticaNeue.h"

@implementation UIFont (HelveticaNeue)

+ (UIFont*)textFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
}

+ (UIFont*)titleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
}

+ (UIFont*)pickerFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
}

+ (UIFont*)levelTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0f];
}

@end
