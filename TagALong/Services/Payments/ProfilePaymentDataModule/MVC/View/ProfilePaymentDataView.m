//
//  ProfilePaymentDataView.m
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentDataView.h"

@implementation ProfilePaymentDataView

- (IBAction)sendDataAction:(id)sender {
    [self.eventHandler sendDataButtonDidTap];
}

- (IBAction)skipAction:(id)sender {
    
}

@end
