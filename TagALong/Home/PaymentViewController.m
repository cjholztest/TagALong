//
//  PaymentViewController.m
//  TagALong
//
//  Created by PJH on 9/12/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController (){


}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - user defined functions


#pragma mark - click events
- (IBAction)onClickCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)onClickPayment:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
}


@end
