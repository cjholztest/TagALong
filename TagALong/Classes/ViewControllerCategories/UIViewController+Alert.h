//
//  UIViewController+Alert.h
//  TagALong
//
//  Created by User on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showAlert:(NSString*)message;
- (void)showAlert:(NSString*)message withOkCompletion:(void(^)(void))completion;

@end
