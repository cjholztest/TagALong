//
//  CreditCardTableViewCell.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CreditCardTableViewCell.h"
#import "CreditCardTableViewCellViewModel.h"

@interface CreditCardTableViewCell ()

@property (nonatomic, strong) CreditCardTableViewCellViewModel *model;

@end

@implementation CreditCardTableViewCell

- (void)updateWithModel:(id)model {
    self.model = model;
    self.cardNumberLabel.text = self.model.lastNumbers;
    self.accessoryType = self.model.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
