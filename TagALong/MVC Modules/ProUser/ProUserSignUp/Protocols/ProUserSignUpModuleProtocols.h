//
//  ProUserSignUpModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProUserSignUpDataModel;

@protocol ProUserSignUpModelInput <NSObject>

- (void)signUpaProUser:(ProUserSignUpDataModel*)userModel;
- (void)updateAddressByLocation:(CLLocationCoordinate2D)location
                 withConpletion:(void(^)(NSString *city, NSString *address))completion;

@end

@protocol ProUserSignUpModelOutput <NSObject>

- (void)proUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString*)message;
- (void)validationDidFailWithMessage:(NSString*)message;

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
