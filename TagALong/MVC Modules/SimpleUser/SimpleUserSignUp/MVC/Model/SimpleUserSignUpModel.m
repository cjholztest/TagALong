//
//  SimpleUserSignUpModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserSignUpModel.h"
#import "SimpleUserSignUpDataModel.h"

@interface SimpleUserSignUpModel()

@property (nonatomic, weak) id <SimpleUserSignUpModelOutput> output;

@end

@implementation SimpleUserSignUpModel

- (instancetype)initWithOutput:(id<SimpleUserSignUpModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SimpleUserSignUpModelInput

- (void)signUpSimpleUser:(SimpleUserSignUpDataModel*)userModel {
    
    NSString *validationError = [self isUserDataValid:userModel];
    if (validationError) {
        [self.output validationDidFailWithMessage:validationError];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    
    NSString *eMail = [userModel.eMail stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *firstName = [userModel.firstName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *lastName = [userModel.lastName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *phone = [userModel.phone stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *password = [userModel.password stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *city = userModel.cityName;
    
    NSString *latitude = [[NSNumber numberWithFloat:userModel.location.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithFloat:userModel.location.longitude] stringValue];
    NSNumber *hidePhone = [NSNumber numberWithBool:YES];
    
    NSNumber *birthday = [NSNumber numberWithInteger:userModel.birthday.timeInterval];
    NSNumber *gender = [NSNumber numberWithInteger:userModel.genderIndex];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"register"];
    
    NSDictionary *params = @{API_REQ_KEY_USER_NICKNAME      :   firstName ? firstName : @"",
                             API_REQ_KEY_USER_LAST_NAME     :   lastName ? lastName : @"",
                             API_REQ_KEY_USER_EMAIL         :   eMail ? eMail : @"",
                             API_REQ_KEY_USER_CITY          :   city ? city : @"",
                             API_REQ_KEY_USER_PWD           :   password ? password : @"",
                             @"latitude"                    :   latitude ? latitude : @"",
                             @"longitude"                   :   longitude ? longitude : @"",
                             @"hide_phone"                  :   hidePhone,
                             @"date_of_birth"               :   birthday,
                             @"gender"                      :   gender
                             };
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
    if (phone.length > 0) {
        [parameters setObject:phone forKey:API_REQ_KEY_USER_PHONE];
    }
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id respObject) {
        NSLog(@"JSON: %@", respObject);
        
        NSString *message = nil;
        BOOL isSuccessed = NO;
        
        int res_code = [[respObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        
        switch (res_code) {
            case RESULT_CODE_SUCCESS:
                isSuccessed = YES;
                message = @"You registered successfully";
                break;
            case RESULT_ERROR_EMAIL_DUPLICATE:
                message = @"This email is in use";
                break;
            case RESULT_ERROR_PHONE_NUM_DUPLICATE:
                message = @"This phone number is in use";
                break;
            case RESULT_ERROR_NICKNAME_DUPLICATE:
                message = @"This nickname is in use";
                break;
            case RESULT_ERROR_PARAMETER:
                message = @"Please input personal info in correct format";
                break;
            default:
                break;
        }
        [weakSelf.output simpleUserDidSignUpSuccessed:isSuccessed andMessage:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output simpleUserDidSignUpSuccessed:NO andMessage:error.localizedDescription];
    }];
}

- (void)updateCityByLocation:(CLLocationCoordinate2D)location withCompletion:(void (^)(NSString *))completion {
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"reverse_geocoding"];
    
    NSDictionary *params = @{@"latitude" : @(location.latitude), @"longitude" : @(location.longitude)};
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
        
        NSLog(@"JSON: %@", respObject);
        NSString *city = respObject[@"city"];
        
        if (completion) {
            completion(city);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output simpleUserDidSignUpSuccessed:NO andMessage:error.localizedDescription];
    }];
}

- (NSString*)isUserDataValid:(SimpleUserSignUpDataModel*)user {
    
    if ([user.firstName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Input first name!";
    }
    
    if ([user.lastName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Input last name!";
    }
    
    if (user.eMail.length == 0) {
        return @"Input email!";
    }
    
    if (![Commons checkEmail:user.eMail]) {
        return @"Please enter in email format.";
    }
    
    if ([user.phone stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Input phone number!";
    }
    
    if (![Commons checkPhoneNumber:user.phone] && user.phone.length > 0) {
        return @"The phone number should be in format +XXXXXXXXXXXX";
    }
    
    if ([user.password stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Input password";
    }
    
    if ([user.password stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length < 5) {
        return @"The password must be at least 5 symbols length";
    }
    
    if ([user.confirmPassword stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        return @"Input confirm password";
    }
    
    if (![user.password isEqualToString:user.confirmPassword]) {
        return @"Confirm password does not match Password!";
    }
    
    if (!user.birthday.dataExists) {
        return @"Please, input Birthday";
    }
    
    if (user.gender.length == 0) {
        return @"Please, input Gender";
    }
    
    return nil;
}

@end
