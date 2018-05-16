//
//  SubmitOfferView.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferView.h"

@interface SubmitOfferView()

@end

@implementation SubmitOfferView

#pragma mark - SubmitOfferViewInput

#pragma mark - Actoins

- (IBAction)submitOfferButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(submitOfferDidTap)]) {
        [self.output submitOfferDidTap];
    }
}

@end
