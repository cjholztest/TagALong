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


@interface SimpleUserEditProfileViewController () <SimpleUserEditProfileModelOutput, SimpleUserEditProfileViewOutput, AddCreditCardModuleDelegate, CreditCardListModuleDelegate>

@property (nonatomic, weak) IBOutlet SimpleUserEditProfileView *contentView;

@property (nonatomic, strong) id <SimpleUserEditProfileModelInput> model;

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
}

#pragma mark - SimpleUserEditProfileModelOutput

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo {
    self.contentView.creditCardLabel.text = cardInfo;
}

#pragma mark - SimpleUserEditProfileViewOutput

- (void)limitSwitcherDidChange:(BOOL)isOn {
    [self.contentView.limitSlider setEnabled:isOn];
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

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self.model loadCrediCards];
}

#pragma mark - CreditCardListViewController

@end
