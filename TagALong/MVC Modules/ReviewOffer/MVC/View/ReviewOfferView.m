//
//  ReviewOfferView.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferView.h"
#import "RegularUserInfoDataModel.h"

@implementation ReviewOfferView

#pragma mark - Actions

- (IBAction)acceptButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(acceptButtonDidTap)]) {
        [self.output acceptButtonDidTap];
    }
}

- (IBAction)declineButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(declineButtonDidTap)]) {
        [self.output declineButtonDidTap];
    }
}

#pragma mark -

- (void)setupWithDisplayModel:(RegularUserInfoDataModel*)userInfo {
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", userInfo.firstName, userInfo.lastName];
    self.descriptionLabel.text = userInfo.location;
}

@end
