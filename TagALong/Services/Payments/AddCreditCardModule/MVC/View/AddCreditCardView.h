//
//  AddCreditCardView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCreditCardProtocols.h"
#import "AddCreditCardConstants.h"

@class STPPaymentCardTextField;

@interface AddCreditCardView : UIView <AddCreditCardUserInterfaceOutput>

@property (nonatomic, weak) IBOutlet UIButton *addNewCard;
@property (nonatomic, weak) IBOutlet UIButton *skipButton;
@property (nonatomic, weak) IBOutlet UIView *paymentCardContainerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *skipButtonHeightConstraint;
@property (nonatomic, strong) STPPaymentCardTextField *paymentCardTextField;


@property (nonatomic, weak) id <AddCreditCardUserInterfaceInput> eventHandler;

- (void)updateAppearanceWithState:(BOOL)isActive;
- (void)updateInterfaceByModeType:(AddCreditCardtModeType)modeType;

@end
