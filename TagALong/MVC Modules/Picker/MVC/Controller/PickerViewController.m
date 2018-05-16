//
//  PickerViewController.m
//  TagALong
//
//  Created by User on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PickerViewController.h"
#import "UIViewController+Storyboard.h"
#import "UIFont+HelveticaNeue.h"

@interface PickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;

@property (nonatomic, strong) NSArray *pickerComponents;

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        self.contentViewBottomConstraint.constant = -self.contentViewHightConstraint.constant;
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Public

- (void)setupAsSports {
    self.pickerComponents = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    self.pickerView.dataSource = self;
    [self.pickerView reloadAllComponents];
}

#pragma mark - Actions

- (IBAction)doneButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)contentDidTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerComponents.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rowSize.width, rowSize.height)];
    }
    
    label.text = self.pickerComponents[row];
    
    UIFont *font = [UIFont textFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.1;
    
    label.textColor = [UIColor colorWithRed:(0 / 255.f) green:(0/ 255.f) blue:(0/ 255.f) alpha:1.0];
    
    return label;
}

@end
