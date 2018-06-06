//
//  UIViewController+Storyboard.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

+ (UIViewController*)fromStoryboard {
    NSString *className = NSStringFromClass(self.class);
    return [[UIStoryboard storyboardWithName:className bundle:nil] instantiateViewControllerWithIdentifier:className];
}

@end
