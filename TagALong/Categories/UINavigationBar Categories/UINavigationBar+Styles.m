//
//  UINavigationBar+Styles.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UINavigationBar+Styles.h"

@implementation UINavigationBar (Styles)

- (void)applyDefaultStyle {
    
    [self setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self setTranslucent: YES];
    [self setShadowImage:  [UIImage new]];
    [self setBarTintColor: UIColor.blackColor];
    
    [self setTintColor: UIColor.whiteColor];
    
    [self setBackgroundColor: UIColor.clearColor];
    self.barStyle = UIBarStyleBlack;
}

@end
