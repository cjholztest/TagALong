//
//  SimpleUserEditProfileModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SimpleUserEditProfileModelInput <NSObject>

- (void)loadCrediCards;
- (void)loadCrediCardsWithCompletion:(void(^)(NSArray *cards))completion;

- (void)updateAreaRadius:(BOOL)isEnabled miles:(NSString*)miles;

@end

@protocol SimpleUserEditProfileModelOutput <NSObject>

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo;
- (void)areaRadiusDidUpdateSuccess:(BOOL)isSuccess message:(NSString*)message;

@end

@protocol SimpleUserEditProfileViewInput <NSObject>

@end

@protocol SimpleUserEditProfileViewOutput <NSObject>

- (void)limitSwitcherDidChange:(BOOL)isOn;
- (void)editCreditButtonDidTap;
- (void)areaRadiusDidTap;

@end

@protocol SimpleUserEditProfileModuleInput <NSObject>

- (void)setupMiles:(NSInteger)miles;
- (void)setupProfileIcon:(NSString*)iconUrl;

@end

@protocol SimpleUserEditProfileModuleOutput <NSObject>

@end
