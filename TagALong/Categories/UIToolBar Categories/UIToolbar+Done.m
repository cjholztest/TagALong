//
//  UIToolbar+Done.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIToolbar+Done.h"
#import "UIColor+AppColors.h"

@implementation UIToolbar (Done)

+ (UIToolbar*)toolBarDone {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 44.0f)];
    toolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil],
                      [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 4.0f, 0.0f)]]];
    
    toolbar.tintColor = [UIColor appColor];
    
    return toolbar;
}

@end
