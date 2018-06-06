//
//  UIViewController+Presentation.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIViewController+Presentation.h"

@implementation UIViewController (Presentation)

- (void)presentCrossDissolveVC:(UIViewController*)vc {
    
    vc.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.25f];
    
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
