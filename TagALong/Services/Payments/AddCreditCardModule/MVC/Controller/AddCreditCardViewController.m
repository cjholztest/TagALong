//
//  AddCreditCardViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "AddCreditCardModel.h"
#import "AddCreditCardView.h"
#import <Stripe/Stripe.h>

@interface AddCreditCardViewController () <AddCreditCardModelOutput, AddCreditCardUserInterfaceInput, STPPaymentCardTextFieldDelegate>

@property (nonatomic, strong) AddCreditCardModel *model;
@property (nonatomic, weak) IBOutlet AddCreditCardView *contentView;

@end

@implementation AddCreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDependencies];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.contentView.paymentCardTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.contentView.paymentCardTextField resignFirstResponder];
}

#pragma mark - Private

- (void)setupDependencies {
    self.model = [AddCreditCardModel new];
    self.model.output = self;
    self.contentView.eventHandler = self;
    self.contentView.paymentCardTextField.delegate = self;
}

#pragma mark - STPPaymentCardTextFieldDelegate

- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField {
    [self.contentView updateAppearanceWithState:[textField isValid]];
}

#pragma mark - AddCreditCardModelOutput

#pragma mark - AddCreditCardUserInterfaceInput

@end
