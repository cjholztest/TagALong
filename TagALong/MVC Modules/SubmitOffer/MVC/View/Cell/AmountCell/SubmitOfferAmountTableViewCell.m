//
//  SubmitOfferAmountTableViewCell.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAmountTableViewCell.h"

@implementation SubmitOfferAmountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.amountTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Actions

- (void)textDidChange:(UITextField*)textField {
    if ([self.output respondsToSelector:@selector(amountValueDidChange:)]) {
        [self.output amountValueDidChange:textField.text];
    }
}

@end
