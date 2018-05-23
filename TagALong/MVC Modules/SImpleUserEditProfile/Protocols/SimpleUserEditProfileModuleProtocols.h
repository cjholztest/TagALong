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

@end

@protocol SimpleUserEditProfileModelOutput <NSObject>

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo;

@end

@protocol SimpleUserEditProfileViewInput <NSObject>

@end

@protocol SimpleUserEditProfileViewOutput <NSObject>

- (void)limitSwitcherDidChange:(BOOL)isOn;
- (void)editCreditButtonDidTap;

@end

@protocol SimpleUserEditProfileModuleInput <NSObject>

@end

@protocol SimpleUserEditProfileModuleOutput <NSObject>

@end
