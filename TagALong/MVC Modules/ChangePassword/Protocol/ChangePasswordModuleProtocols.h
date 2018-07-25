//
//  ChangePasswordModuleProtocols.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserPassword;

@protocol ChangePasswordModelInput <NSObject>

- (void)savePassword:(UserPassword*)userPassword;
- (NSString*)isUserPasswordValid:(UserPassword*)userPassword;

@end

@protocol ChangePasswordModelOutput <NSObject>

- (void)passwordDidSaveSuccess:(BOOL)success message:(NSString*)message;

@end

@protocol ChangePasswordViewInput <NSObject>

@end

@protocol ChangePasswordViewOutput <NSObject>

@end

@protocol ChangePasswordModuleInput <NSObject>

@end

@protocol ChangePasswordModuleOutput <NSObject>

@end
