//
//  CreditCardListView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CreditCardListView.h"

@implementation CreditCardListView

#pragma mark - Actions

- (IBAction)addCreditCardButtonAction:(UIButton *)sender {
    [self.eventHandler addCreditCardDidTap];
}

@end
