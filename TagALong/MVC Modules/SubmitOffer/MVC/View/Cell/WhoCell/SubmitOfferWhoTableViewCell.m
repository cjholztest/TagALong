//
//  SubmitOfferWhoTableViewCell.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhoTableViewCell.h"

@implementation SubmitOfferWhoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.whoTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Actions

- (void)textDidChange:(UITextField*)textField {
    if ([self.output respondsToSelector:@selector(enteredTexDidChange:)]) {
        [self.output enteredTexDidChange:textField.text];
    }
}

@end
