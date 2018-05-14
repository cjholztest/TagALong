//
//  AthleteInfoView.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteInfoView.h"

@interface AthleteInfoView()

@end

@implementation AthleteInfoView

#pragma mark - Actions

- (IBAction)tagALongAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(tagALongButtonDidTap)]) {
        [self.output tagALongButtonDidTap];
    }
}

#pragma mark - AthleteInfoViewInput

@end
