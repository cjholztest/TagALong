//
//  ProUserEditProfileLogoInfoTableViewCell.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileLogoInfoTableViewCell.h"
#import "UITableViewCell+Styles.h"

@implementation ProUserEditProfileLogoInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyClearStyle];
    
    self.userIconImageView.layer.cornerRadius = self.userIconImageView.bounds.size.width / 2.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userPhotoAction)];
    [self.userIconImageView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Actions

- (void)userPhotoAction {
    if ([self.output respondsToSelector:@selector(userIconDidTap)]) {
        [self.output userIconDidTap];
    }
}

@end
