//
//  PickerViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PickerViewController.h"
#import "PickerModel.h"
#import "PickerView.h"
#import "UIViewController+Storyboard.h"
#import "UIFont+HelveticaNeue.h"
#import "UIColor+AppColors.h"
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
    
    self.contentView.titleLabel.text = self.pickerType == MilesPickerType ? @"Miles" : nil;
    
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
    
    NSString *title = [self.model selectedComponent];
    
    if (title) {
        switch (self.pickerType) {
            case DuratoinPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithDuration:)]) {
                    [self.moduleOutput pickerDoneButtonDidTapWithDuration:title];
                }
                break;
            case SportsPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithSelectedIndex:andItemTitle:)]) {
                    NSInteger index = [self.model selectedComponentIndex];
                    [self.moduleOutput pickerDoneButtonDidTapWithSelectedIndex:index andItemTitle:title];
                }
                break;
            case TotalPeoplePickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithTotalOfPeople:)]) {
                    [self.moduleOutput pickerDoneButtonDidTapWithTotalOfPeople:title];
                }
                break;
            case MilesPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithMiles:)]) {
                    NSInteger mileIndex = [self.model selectedComponentIndex];
                    NSString *milesValue = mileIndex != 0 ? title : @"100000000";
                    [self.moduleOutput pickerDoneButtonDidTapWithMiles:milesValue];
                }
                break;
            case StartTimePickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithStartTime:)]) {
                    [self.moduleOutput pickerDoneButtonDidTapWithStartTime:title];
                }
                break;
            case GenderPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithGender:atIndex:)]) {
                    NSInteger genderIndex = [self.model selectedComponentIndex] + 1;
                    [self.moduleOutput pickerDoneButtonDidTapWithGender:title atIndex:genderIndex];
                }
                break;
            case MonthPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithMonth:atIndex:)]) {
                    NSInteger monthIndex = [self.model selectedComponentIndex] + 1;
                    [self.moduleOutput pickerDoneButtonDidTapWithMonth:title atIndex:monthIndex];
                }
                break;
            case YearPickerType:
                if ([self.moduleOutput respondsToSelector:@selector(pickerDoneButtonDidTapWithYear:)]) {
                    [self.moduleOutput pickerDoneButtonDidTapWithYear:title];
                }
                break;
            default:
                break;
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
    
//    label.text = [self.model titleForComponentAtIndex:row];
    label.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.model updateSelectedComponentWithIndex:row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = [self.model titleForComponentAtIndex:row];
    NSDictionary *attriputes = @{NSForegroundColorAttributeName : UIColor.textColor,
                                 NSFontAttributeName : UIFont.pickerFont};
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:attriputes];
    return attString;
}

@end
