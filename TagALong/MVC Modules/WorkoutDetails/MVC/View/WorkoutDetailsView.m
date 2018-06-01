//
//  WorkoutDetailsView.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsView.h"
#import "WorkoutDetailsViewDisplayModel.h"

static NSString *const kPlaceholderIconName = @"ic_profile_black";

@implementation WorkoutDetailsView

- (void)setupWithProfileInfo:(WorkoutDetailsViewDisplayModel*)displayModel {
    
    self.userTypeLabel.text = [displayModel.levelText uppercaseString];
    self.locationLabel.text = displayModel.locationText;
    
    NSString *buttonTitle = displayModel.isButtonVisible ? displayModel.buttonTitle : @"";
    
    [self.confirmationButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.confirmationButton setTitle:buttonTitle forState:UIControlStateSelected];
    [self.confirmationButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    
    self.confirmationButton.tag = displayModel.actionButtonType;
    
    [self.profileIconImageView sd_setImageWithURL:[NSURL URLWithString:displayModel.iconURL]
                                 placeholderImage:[UIImage imageNamed:kPlaceholderIconName]];
    
    self.phoneLabel.text = (displayModel.phoneText.length > 0) ? displayModel.phoneText : @"no phone number";
    self.buttonHeightLayoutConastraint.constant = displayModel.isButtonVisible ? 60.0f : 0.0f;
}

#pragma mark - Actions

- (IBAction)buttonAction:(UIButton*)button {
    
    WorkoutDetailsButtonType type = button.tag;
    
    switch (type) {
        case NoneButtonType:
            break;
        case BookNowButtonType:
            if ([self.output respondsToSelector:@selector(bookWorkoutNowDidTap)]) {
                [self.output bookWorkoutNowDidTap];
            }
            break;
        case BookedUsersButtonType:
            if ([self.output respondsToSelector:@selector(showVisitorsDidTap)]) {
                [self.output showVisitorsDidTap];
            }
            break;
        default:
            break;
    }
}

@end
