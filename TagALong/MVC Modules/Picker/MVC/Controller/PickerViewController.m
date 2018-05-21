//
//  PickerViewController.m
//  TagALong
//
//  Created by User on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerModel.h"
#import "PickerView.h"
#import "UIViewController+Storyboard.h"
#import "UIFont+HelveticaNeue.h"
#import "UILabel+PickerView.h"

@interface PickerViewController () <PickerModelOutput, PickerViewOutput, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) PickerType pickerType;

@property (nonatomic, weak) IBOutlet PickerView *contentView;
@property (nonatomic, strong) id <PickerModelInput> model;


@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showPickerView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setup {
    
    self.model = [[PickerModel alloc] initWithOutput:self andPickerType:self.pickerType];    
    self.contentView.output = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentDidTap)];
    [self.contentView addGestureRecognizer:tap];
    
    self.contentView.pickerView.dataSource = self;
    self.contentView.pickerView.delegate = self;
}


- (void)showPickerView {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.contentViewBottomConstraint.constant = 0.0f;
        [self.view layoutIfNeeded];
    }];
}

- (void)hidePickerView {
    
    __weak typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.contentViewBottomConstraint.constant = -self.contentView.contentViewHightConstraint.constant;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf pickerViewDidHide];
        }
    }];
}

#pragma mark - PickerViewOutput

- (void)doneButtonDidTap {
    if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithSelectedIndex:andItemTitle:)]) {
        NSString *title = [self.model selectedComponent];
        if (title) {
            NSInteger index = [self.model selectedComponentIndex];
            [self.moduleOutput pickerDoneButtonDidTapWithSelectedIndex:index andItemTitle:title];
        }
    }
    [self hidePickerView];
}

- (void)pickerViewDidHide {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerModelOutput

#pragma mark - PickerModuleInput

- (void)setupWithType:(PickerType)type {
    self.pickerType = type;
}

#pragma mark - Actions

- (void)contentDidTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerViewDataSource and Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.model componentsCount];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (UILabel*)view;
    
    if (!label) {
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        label = [UILabel pickerLabelWithSize:rowSize];
    }
    
    label.text = [self.model titleForComponentAtIndex:row];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.model updateSelectedComponentWithIndex:row];
}

@end
