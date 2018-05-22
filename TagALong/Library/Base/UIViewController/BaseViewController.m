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
    
    UITableView *tableView = [self foundTableView];
    
    if (tableView) {
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets inset = tableView.contentInset;
            inset.bottom  = keyboardHeight;
            tableView.contentInset = inset;
        }];
    }
}

- (void)keyboardDidHide:(NSNotification*)notification {
    
    self.isEdidtingEnabled = NO;
    
    UITableView *tableView = [self foundTableView];
    
    if (tableView) {
        [UIView animateWithDuration:0.2 animations:^{
            tableView.contentInset = UIEdgeInsetsZero;
        }];
    }
}

- (void)keyboardDidChange:(NSNotification*)notification {
    
    UITableView *tableView = [self foundTableView];
    
    if (tableView) {
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets inset = tableView.contentInset;
            inset.bottom  = keyboardHeight;
            tableView.contentInset = inset;
        }];
    }
}

#pragma mark - Help Methods

- (UITableView*)foundTableView {
    
    UIView *view = [self valueForKey:@"contentView"];
    
    if (view) {
        
        UITableView *tableView = [view valueForKey:@"tableView"];
        
        if (tableView) {
            return tableView;
        }
    }
    
    return nil;
}

@end
