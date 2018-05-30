//
//  WorkoutDetailsView.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsView.h"
#import "WorkoutDetailsViewDisplayModel.h"

@implementation WorkoutDetailsView

- (void)setupWithProfileInfo:(WorkoutDetailsViewDisplayModel*)profile {
    
    self.userTypeLabel.text = [profile.levelText uppercaseString];
    self.locationLabel.text = profile.locationText;
    
    [self.profileIconImageView sd_setImageWithURL:[NSURL URLWithString:profile.iconURL] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    
    if (profile.phoneText.length > 0) {
        self.phoneLabel.text = profile.phoneText;
        [self.phoneContainerView setHidden:NO];
        self.phoneContainerHeightLayoutConastraint.constant = 36.0f;
    } else {
        [self.phoneContainerView setHidden:YES];
        self.phoneContainerHeightLayoutConastraint.constant = 0.0f;
    }
    
    [self layoutIfNeeded];
}

@end
