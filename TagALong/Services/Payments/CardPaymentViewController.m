//
//  CardPaymentViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CardPaymentViewController.h"
#import <Stripe/Stripe.h>
#import <Stripe/STPCard.h>
#import "PaymentClient.h"

@interface CardPaymentViewController () <STPPaymentCardTextFieldDelegate>

@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;

@end

@implementation CardPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] initWithFrame:CGRectMake(0, 80, 320, 100)];
    paymentTextField.delegate = self;
    paymentTextField.cursorColor = [UIColor purpleColor];
    paymentTextField.backgroundColor = [UIColor lightGrayColor];
    paymentTextField.postalCodeEntryEnabled = YES;
    self.paymentTextField = paymentTextField;
    [self.view addSubview:paymentTextField];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(0, 200, 320, 50);
    [payButton setTitle:@"Pay" forState:UIControlStateNormal];
    [payButton setTitle:@"Pay" forState:UIControlStateHighlighted];
    [payButton setTitle:@"Pay" forState:UIControlStateSelected];
    [payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    payButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pay {
    
    STPCardParams *cardParams = [STPCardParams new];
    cardParams.number = @"4242424242424242";
    cardParams.expYear = 2019;
    cardParams.expMonth = 7;
    cardParams.cvc = @"222";

    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"Token: %@", token);
            [[PaymentClient shared] sendCardToken:token.tokenId completion:^(id object) {
                NSLog(@"%@", object);
            }];
        }
    }];
    // http://192.168.10.206:8080/api/payments/credit_card
}

- (void)sendCardToken:(STPToken*)token {
    
}

#pragma mark - STPPaymentCardTextFieldDelegate



@end
