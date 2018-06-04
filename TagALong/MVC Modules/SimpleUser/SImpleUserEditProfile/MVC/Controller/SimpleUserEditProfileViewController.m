//
//  SImpleUserEditProfileViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileViewController.h"
#import "SimpleUserEditProfileModel.h"
#import "SimpleUserEditProfileView.h"
#import "UIViewController+AlertController.h"
#import "AddCreditCardViewController.h"
#import "CreditCardListViewController.h"
#import "PickerViewController.h"
#import "UIViewController+Storyboard.h"
#import "UIViewController+Presentation.h"

@interface SimpleUserEditProfileViewController () <SimpleUserEditProfileModelOutput, SimpleUserEditProfileViewOutput, AddCreditCardModuleDelegate, CreditCardListModuleDelegate, PickerModuleOutput>

@property (nonatomic, weak) IBOutlet SimpleUserEditProfileView *contentView;

@property (nonatomic, strong) id <SimpleUserEditProfileModelInput> model;

@property (nonatomic, assign) NSInteger miles;
@property (nonatomic, strong) NSString *iconURL;

@end

@implementation SimpleUserEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    
    self.model = [[SimpleUserEditProfileModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    [self.model loadCrediCards];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonDidTap)];
    
    NSInteger radius = self.miles;
    BOOL isLimitEnabled = radius != -1;
    
    NSString *value = isLimitEnabled ? [NSString stringWithFormat:@"%lu", radius] : @"Infinity";
    
    [self.contentView.limitSwithch setOn:isLimitEnabled];
    self.contentView.areaRadiusLabel.text = value;
    
    [self limitSwitcherDidChange:isLimitEnabled];
    
    if (self.iconURL) {
        [self.contentView.profileIconImageView sd_setImageWithURL:[NSURL URLWithString:self.iconURL] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
        [self.contentView layoutIfNeeded];
        self.contentView.profileIconImageView.layer.cornerRadius = self.contentView.profileIconImageView.bounds.size.width / 2.0f;
        self.contentView.profileIconImageView.clipsToBounds = YES;
    }
}

#pragma mark - SimpleUserEditProfileModelOutput

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo {
    self.contentView.creditCardLabel.text = cardInfo;
}

- (void)areaRadiusDidUpdateSuccess:(BOOL)isSuccess message:(NSString*)message {
    
    if (isSuccess) {
        [self showAllertWithTitle:@"TagALong" message:message okCompletion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

#pragma mark - SimpleUserEditProfileViewOutput

- (void)limitSwitcherDidChange:(BOOL)isOn {
    self.contentView.areaContentView.alpha = isOn ? 1.0f : 0.2f;
    [self.contentView.areaContentView setUserInteractionEnabled:isOn];
}

- (void)editCreditButtonDidTap {
    
    __weak typeof(self)weakSelf = self;
    
    [self.model loadCrediCardsWithCompletion:^(NSArray *cards) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
        
        if (cards.count == 0) {
            AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
            addCreditCardVC.moduleDelegate = self;
            addCreditCardVC.modeType = AddCreditCardtModeTypeProfile;
            [weakSelf.navigationController pushViewController:addCreditCardVC animated:YES];
        } else {
            CreditCardListViewController *creditCardListVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(CreditCardListViewController.class)];
            creditCardListVC.moduleDelegate = self;
            [self.navigationController pushViewController:creditCardListVC animated:YES];
        }
    }];
}

- (void)areaRadiusDidTap {
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [pickerVC setupWithType:MilesPickerType];
    pickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:pickerVC];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self.model loadCrediCards];
}

#pragma mark - CreditCardListViewController

#pragma mark - SimpleUserEditProfileModuleInput

- (void)setupMiles:(NSInteger)miles {
    self.miles = miles;
}

- (void)setupProfileIcon:(NSString*)iconUrl {
    self.iconURL = iconUrl;
}

#pragma mark - PickerModuleOutput

- (void)pickerDoneButtonDidTapWithMiles:(NSString *)miles {
    self.contentView.areaRadiusLabel.text = miles;
}

#pragma mark - Private

- (void)saveButtonDidTap {
    [self.model updateAreaRadius:self.contentView.limitSwithch.isOn
                           miles:self.contentView.areaRadiusLabel.text];
}

@end
