//
//  AthleteInfoView.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteInfoView.h"
#import "AthleteDataModel.h"

@interface AthleteInfoView()

@end

@implementation AthleteInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.centerButton.layer.cornerRadius = 25.0f;
    self.centerButton.clipsToBounds = YES;
}

#pragma mark - Actions

- (IBAction)tagALongAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(tagALongButtonDidTap)]) {
        [self.output tagALongButtonDidTap];
    }
}

- (IBAction)centerButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(centeringButtonDidTap)]) {
        [self.output centeringButtonDidTap];
    }
}

#pragma mark - AthleteInfoViewInput

- (void)setupWithAthlete:(AthleteDataModel *)athlete {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", athlete.firstName, athlete.lastName];
    self.infoLabel.text = [NSString stringWithFormat:@"%@\n%@", athlete.awards, athlete.additionalInfo];
    
    self.cityLabel.text = athlete.city;
    self.locationLabel.text = @"ATHLETE LOCATION:";
    
    NSString *title = [NSString stringWithFormat:@"TagALong with %@", athlete.firstName];
    
    [self.tagALongLabel setTitle:title forState:UIControlStateNormal];
    [self.tagALongLabel setTitle:title forState:UIControlStateSelected];
    [self.tagALongLabel setTitle:title forState:UIControlStateHighlighted];
    
    if (athlete.profileImage.length > 0) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:athlete.profileImage] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width / 2.0f;
        self.avatarImageView.clipsToBounds = YES;
    }
}

@end
