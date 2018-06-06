//
//  ProfilePaymentDataViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfilePaymentDataProtocols.h"
#import "ProfilePaymentConstants.h"

@interface ProfilePaymentDataViewController : UIViewController

@property (nonatomic, weak) id <ProfilePaymentDataModuleDelegate> moduleDelegate;
@property (nonatomic, assign) ProfilePaymentModeType modeType;

@end
