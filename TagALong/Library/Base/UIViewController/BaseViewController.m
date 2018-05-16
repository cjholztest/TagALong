//
//  BaseViewController.m
//  TagALong
//
//  Created by User on 5/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, readwrite, assign) BOOL isEdidtingEnabled;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppear:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChange:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notifications

- (void)keyboardDidAppear:(NSNotification*)notification {
    self.isEdidtingEnabled = YES;
}

- (void)keyboardDidHide:(NSNotification*)notification {
    self.isEdidtingEnabled = NO;
}

- (void)keyboardDidChange:(NSNotification*)notification {

}

@end
