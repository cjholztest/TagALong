//
//  ProfilePaymentRegistrationFooter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfilePaymentRegistrationFooterDelegate <NSObject>

- (void)skipButtonDidTap;
- (void)sendCredentialsButtonDidTap;

@end

@interface ProfilePaymentRegistrationFooter : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton *skipButton;
@property (nonatomic, weak) IBOutlet UIButton *sendCredentialsButton;
@property (nonatomic, weak) id <ProfilePaymentRegistrationFooterDelegate> delegate;

@end
