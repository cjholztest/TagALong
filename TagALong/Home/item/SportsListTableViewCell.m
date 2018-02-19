//
//  SportsListTableViewCell.m
//  TagALong
//
//  Created by PJH on 9/13/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "SportsListTableViewCell.h"

@implementation SportsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ivProfile.layer.cornerRadius = _ivProfile.frame.size.width / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
