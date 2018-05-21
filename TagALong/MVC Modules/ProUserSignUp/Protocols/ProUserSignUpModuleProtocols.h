//
//  ProUserSignUpModuleProtocols.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProUserSignUpDataModel;

@protocol ProUserSignUpModelInput <NSObject>

- (void)signUpaProUser:(ProUserSignUpDataModel*)userModel;

@end

@protocol ProUserSignUpModelOutput <NSObject>

- (void)proUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString*)message;

@end

@protocol ProUserSignUpViewInput <NSObject>

@end

@protocol ProUserSignUpViewOutput <NSObject>

- (void)signUpButtonDidTap;

@end

@protocol ProUserSignUpModuleInput <NSObject>

@end

@protocol ProUserSignUpModuleOutput <NSObject>

@end
