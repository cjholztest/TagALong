//
//  AddCreditCardViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "EditDialogViewController.h"
#import "UIViewController+Alert.h"
#import "AddCreditCardModel.h"
#import "AddCreditCardView.h"
#import <Stripe/Stripe.h>

@interface AddCreditCardViewController () <AddCreditCardModelOutput, AddCreditCardUserInterfaceInput, STPPaymentCardTextFieldDelegate, EditDialogViewControllerDelegate>

@property (nonatomic, strong) AddCreditCardModel *model;
@property (nonatomic, weak) IBOutlet AddCreditCardView *contentView;

@end

@implementation AddCreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDependencies];
    [self.contentView updateInterfaceByModeType:self.modeType];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.contentView.paymentCardTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.contentView.paymentCardTextField resignFirstResponder];
}

#pragma mark - EditDialogViewControllerDelegate

- (void)setContent:(NSString*)type msg:(NSString*)content {
    if ([type isEqualToString:@"password"]) {
        [self.model passwordDidEnter:content];
        if (self.model.isUserPasswordEntered) {
            [self addCreditCard];
        }
    }
}

- (void)showEnterPasswordDialog {
    
    EditDialogViewController *dlgDialog = [[EditDialogViewController alloc] initWithNibName:@"EditDialogViewController" bundle:nil];
    dlgDialog.providesPresentationContextTransitionStyle = YES;
    dlgDialog.definesPresentationContext = YES;
    [dlgDialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDialog.delegate = self;
    
    dlgDialog.type = @"password";
    dlgDialog.content = @"";
    [self presentViewController:dlgDialog animated:NO completion:nil];
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

- (void)creditCardDidCreateWithError:(NSError*)error {
    [SharedAppDelegate closeLoading];
    if (error) {
        [self showAlert:error.localizedDescription];
    } else {
        __weak typeof(self)weakSelf = self;
        [self showAlert:@"Credit Card was successfully added" withOkCompletion:^{
            if ([weakSelf.moduleDelegate respondsToSelector:@selector(creditCardDidAdd)]) {
                [weakSelf.moduleDelegate creditCardDidAdd];
            }
        }];
    }
}

#pragma mark - AddCreditCardUserInterfaceInput

- (void)addCreditCardDidTap {
    [self.contentView.paymentCardTextField resignFirstResponder];
    [self showEnterPasswordDialog];
}

- (void)skipDidTap {
    if ([self.moduleDelegate respondsToSelector:@selector(skipAddCreditCard)]) {
        [self.contentView.paymentCardTextField resignFirstResponder];
        [self.moduleDelegate skipAddCreditCard];
    }
}

#pragma mark - Private

- (void)addCreditCard {
    [SharedAppDelegate showLoading];
    [self.model createCreditCardWithCardParams:self.contentView.paymentCardTextField.cardParams];
}

@end
