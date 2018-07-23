//
//  SimpleUserEditProfileModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleUserProfile;

@protocol SimpleUserEditProfileModelInput <NSObject>

- (void)loadCrediCards;
- (void)loadCrediCardsWithCompletion:(void(^)(NSArray *cards))completion;

- (void)updateAreaRadius:(BOOL)isEnabled miles:(NSString*)miles;

- (void)saveProfile:(SimpleUserProfile*)profile;

- (UIImage *)compressedImageFrom:(UIImage*)original scale:(CGFloat)scale;
- (void)uploadImage:(UIImage*)image scale:(float)scale;

- (void)checkCreditsWithCompletion:(void(^)(BOOL isCreditCradExists))completion;
- (void)loadDataForCreditWithCompletion:(void(^)(NSString *result))completion;

@end

@protocol SimpleUserEditProfileModelOutput <NSObject>

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo;
- (void)areaRadiusDidUpdateSuccess:(BOOL)isSuccess message:(NSString*)message;

- (void)profileDidUpdate:(BOOL)success errorMessage:(NSString*)message;
- (void)photoDidLoadWithUrl:(NSString*)url;

- (void)creditCardDataDidLoad:(NSString*)creditData;

@end

@protocol SimpleUserEditProfileViewInput <NSObject>

@end

@protocol SimpleUserEditProfileViewOutput <NSObject>

@end

@protocol SimpleUserEditProfileModuleInput <NSObject>

- (void)setupProfile:(SimpleUserProfile*)profile;

- (void)setupMiles:(NSInteger)miles;
- (void)setupProfileIcon:(NSString*)iconUrl;

@end

@protocol SimpleUserEditProfileModuleOutput <NSObject>

@end
