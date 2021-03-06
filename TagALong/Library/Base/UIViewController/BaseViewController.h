//
//  BaseViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, readonly, assign) BOOL isEdidtingEnabled;

- (void)subscribeForKeyboardNotification;
- (void)unsubscribeForKeyboardNotification;

- (void)keyboardDidAppear:(NSNotification*)notification;
- (void)keyboardDidHide:(NSNotification*)notification;
- (void)keyboardDidChange:(NSNotification*)notification;

@end
