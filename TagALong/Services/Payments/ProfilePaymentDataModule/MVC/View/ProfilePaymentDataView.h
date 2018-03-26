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
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *birthdayContainerView;
@property (nonatomic, weak) IBOutlet UIView *birthdayMaskView;
@property (nonatomic, weak) IBOutlet UIDatePicker *birthdayPicker;

- (void)upsateBirthdayPickerAppearanceWithVisibleState:(BOOL)isVisible;

@end
