//
//  SimpleUserSignUpModuleProtocols.h
//  TagALong
//
//  Created by User on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleUserSignUpDataModel;

@protocol SimpleUserSignUpModelInput <NSObject>

- (void)signUpSimpleUser:(SimpleUserSignUpDataModel*)userModel;
- (void)updateCityByLocation:(CLLocationCoordinate2D)location withCompletion:(void(^)(NSString *city))completion;

@end

@protocol SimpleUserSignUpModelOutput <NSObject>

- (void)simpleUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString*)message;
- (void)validationDidFailWithMessage:(NSString*)message;

@end

@protocol SimpleUserSignUpViewInput <NSObject>

@end

@protocol SimpleUserSignUpViewOutput <NSObject>

- (void)signUpButtonDidTap;

@end

@protocol SimpleUserSignUpModuleInput <NSObject>

@end

@protocol SimpleUserSignUpModuleOutput <NSObject>

@end
