//
//  ProfilePaymentDataView.h
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfilePaymentDataProtocols.h"

@interface ProfilePaymentDataView : UIView <ProfilePaymentDataUserInterfaceOutput>

@property (nonatomic, weak) id <ProfilePaymentDataUserInterfaceInput> eventHandler;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *birtdayTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;
@property (nonatomic, weak) IBOutlet UITextField *postCodeTextField;
@property (nonatomic, weak) IBOutlet UITextField *cityTextField;
@property (nonatomic, weak) IBOutlet UITextField *stateTextField;
@property (nonatomic, weak) IBOutlet UITextField *ssnLastTextField;
@property (nonatomic, weak) IBOutlet UITextField *ssbFullTextField;

@end
