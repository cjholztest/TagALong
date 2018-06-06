//
//  UILabel+PickerView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UILabel+PickerView.h"
#import "UIFont+HelveticaNeue.h"
#import "UIColor+AppColors.h"

@implementation UILabel (PickerView)

+ (UILabel*)pickerLabelWithSize:(CGSize)size {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];

    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = UIColor.textColor;
    label.font = [UIFont pickerFont];
    label.minimumScaleFactor = 0.1;
    
    return label;
}

@end
