//
//  ProfilePaymentDataProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfilePaymentConstants.h"

@protocol ProfilePaymentDataModelInput <NSObject>

- (void)updateValue:(id)value forType:(NSInteger)type;
- (void)setupMode:(ProfilePaymentModeType)mode;
- (void)sendPaymentCredentials;

- (NSInteger)rowsCount;
- (BOOL)isRegistrationMode;
- (BOOL)isPasswordContained;
- (BOOL)isEnteredCredentialsValid;
- (NSString*)enteredBirthdayDate;

@end

@protocol ProfilePaymentDataModelOutput <NSObject>

- (void)credentalsDidCheckWithError:(NSString*)errorMessage;
- (void)paymentCredentialsDidRegisterSuccess:(BOOL)isSuccessed errorMessage:(NSString*)errorMessage;

@end

@protocol ProfilePaymentDataUserInterfaceInput <NSObject>

- (void)skipButtonDidTap;
- (void)sendDataButtonDidTap;
- (void)birthdayPickerDoneButtonDidTap;

@end

@protocol ProfilePaymentDataUserInterfaceOutput <NSObject>

@end

@protocol ProfilePaymentDataFriendsControllerProtocol <NSObject>

- (UIKeyboardType)keyboardTypeForFieldType:(NSInteger)fieldType;
- (NSString*)placeholderFieldType:(NSInteger)fieldType;

@end

@protocol ProfilePaymentDataModuleDelegate <NSObject>

- (void)paymentCredentialsDidSend;

@optional
- (void)skipSendingPaymentCredentials;

@end
