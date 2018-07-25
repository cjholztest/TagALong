//
//  ChangePasswordModel.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ChangePasswordModel.h"
#import "UserPassword.h"

@interface ChangePasswordModel()

@property (nonatomic, weak) id <ChangePasswordModelOutput> output;

@end

@implementation ChangePasswordModel

- (instancetype)initWithOutput:(id<ChangePasswordModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ChangePasswordModelInput

- (void)savePassword:(UserPassword *)userPassword {
    
    __weak typeof(self)weakSelf = self;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"change_password"];
    
    NSString *oldPassword = [userPassword.oldPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *theNewPassword = [userPassword.theNewPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    
    NSDictionary *parameters = @{@"old_password" : oldPassword,
                                 @"new_password" : theNewPassword};
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        BOOL success = NO;
        NSString *errorMessage = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            success = YES;
        }  else if(res_code == RESULT_ERROR_PASSWORD) {
            errorMessage = @"The password is incorrect.";
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST) {
            errorMessage = @"User does not exist.";
        }  else if(res_code == RESULT_ERROR_PARAMETER) {
            errorMessage = @"The request parameters are incorrect.";
        }
        
        [weakSelf.output passwordDidSaveSuccess:success message:errorMessage];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [weakSelf.output passwordDidSaveSuccess:NO message:error.localizedDescription];
    }];
}

- (NSString*)isUserPasswordValid:(UserPassword *)userPassword {
    
    if ([userPassword.oldPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Old Password field shouldn't be empty";
    }
    
    if ([userPassword.theNewPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"New Password field shouldn't be empty";
    }
    
    if ([userPassword.confirmPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Confirm Password field shouldn't be empty";
    }
    
    NSArray *passwords = @[userPassword.oldPassword, userPassword.theNewPassword, userPassword.confirmPassword];
    
    for (NSString *password in passwords) {
        if ([password stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length < 5) {
            return @"The password must be at least 5 symbols length";
        }
    }
    
    if (![userPassword.theNewPassword isEqualToString:userPassword.confirmPassword]) {
        return @"Confirm password does not match New Password!";
    }
    
    return nil;
}

@end
