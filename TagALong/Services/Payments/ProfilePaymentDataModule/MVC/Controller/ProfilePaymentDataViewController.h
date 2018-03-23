//
//  ProfilePaymentDataViewController.h
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfilePaymentDataProtocols.h"

@interface ProfilePaymentDataViewController : UIViewController

@property (nonatomic, weak) id <ProfilePaymentDataModuleDelegate> moduleDelegate;

@end
