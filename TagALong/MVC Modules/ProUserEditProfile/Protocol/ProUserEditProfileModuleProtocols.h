//
//  ProUserEditProfileModuleProtocols.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProUserProfile;

@protocol ProUserEditProfileViewInput <NSObject>

@end

@protocol ProUserEditProfileViewOutput <NSObject>

@end

@protocol ProUserEditProfileModelInput <NSObject>

- (void)saveProfile:(ProUserProfile*)profile;

- (UIImage *)compressedImageFrom:(UIImage*)original scale:(CGFloat)scale;

- (void)uploadImage:(UIImage*)image scale:(float)scale;

- (void)checkCreditsWithCompletion:(void(^)(BOOL isCreditCradExists))completion;
- (void)checkPaymentAccountCredentialsWithCompletion:(void(^)(BOOL isPaymentAccountExists, BOOL isCreditCradExists))completion;

- (void)loadDataForBankCredentialsWithCompletion:(void(^)(NSString *result))completion;
- (void)loadDataForDebitWithCompletion:(void(^)(NSString *result))completion;
- (void)loadDataForCreditWithCompletion:(void(^)(NSString *result))completion;

@end

@protocol ProUserEditProfileModelOutput <NSObject>

- (void)profileDidUpdate:(BOOL)success errorMessage:(NSString*)message;

- (void)bankDataDidLoad:(NSString*)bankData;
- (void)debitCardDataDidLoad:(NSString*)debitData;
- (void)creditCardDataDidLoad:(NSString*)creditData;

- (void)photoDidLoadWithUrl:(NSString*)url;

@end

@protocol ProUserEditProfileModuleInput <NSObject>

- (void)setupProfile:(ProUserProfile*)profile;

@end

@protocol ProUserEditProfileModuleOutput <NSObject>

@end
