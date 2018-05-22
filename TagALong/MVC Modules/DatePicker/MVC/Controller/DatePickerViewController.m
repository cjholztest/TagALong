//
//  DatePickerViewController.m
//  TagALong
//
//  Created by User on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "DatePickerViewController.h"
#import "DatePickerModel.h"
#import "DatePickerView.h"

@interface DatePickerViewController () <DatePickerModelOutput, DatePickerViewOutput>

@property (weak, nonatomic) IBOutlet DatePickerView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;

@property (nonatomic, assign) DatePickerType datePickerType;

@property (nonatomic, strong) id <DatePickerModelInput> model;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[DatePickerModel alloc] initWithOutput:self andType:self.datePickerType];
    self.contentView.output = self;
    
    if (self.datePickerType == DateDatePickerType) {
        [self.contentView.datePickerView setDatePickerMode:UIDatePickerModeDate];
    } else {
        [self.contentView.datePickerView setDatePickerMode:UIDatePickerModeTime];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentDidTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3f animations:^{
        self.contentViewBottomConstraint.constant = 0.0f;
        [self.view layoutIfNeeded];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.2f animations:^{
        self.contentViewBottomConstraint.constant = -self.contentViewHeightConstraint.constant;
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - DatePickerViewOutput

- (void)doneButtonDidTap {
    
    switch (self.datePickerType) {
            
        case DateDatePickerType:
            if ([self.moduleOutput respondsToSelector:@selector(dateDidChange:)]) {
                [self.moduleOutput dateDidChange:[self.contentView.datePickerView date]];
            }
            break;
        case TimeDatePickerType:
            if ([self.moduleOutput respondsToSelector:@selector(timeDidChange:)]) {
                [self.moduleOutput timeDidChange:[self.contentView.datePickerView date]];
            }
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DatePickerModuleInput

- (void)setupWithType:(DatePickerType)type {
    self.datePickerType = type;
}

- (void)contentDidTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
