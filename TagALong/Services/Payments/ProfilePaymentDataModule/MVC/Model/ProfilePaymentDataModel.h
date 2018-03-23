//
//  ProfilePaymentDataModel.h
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfilePaymentDataProtocols.h"
#import "ProfilePaymentConstants.h"

@interface ProfilePaymentDataModel : NSObject <ProfilePaymentDataModelInput>

@property (nonatomic, weak) id <ProfilePaymentDataModelOutput> output;

@end
