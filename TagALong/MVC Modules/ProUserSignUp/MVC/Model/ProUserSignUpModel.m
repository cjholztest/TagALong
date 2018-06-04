//
//  ProUserSignUpModel.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpModel.h"
#import "ProUserSignUpDataModel.h"

@interface ProUserSignUpModel()

@property (nonatomic, weak) id <ProUserSignUpModelOutput> output;

@end

@implementation ProUserSignUpModel

- (instancetype)initWithOutput:(id<ProUserSignUpModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpModelInput

- (void)signUpaProUser:(ProUserSignUpDataModel*)userModel {
    
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
    NSString *additionalInfo = [userModel.additionalInfo stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *awards = [userModel.awards stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *address = userModel.address;
    NSString *city = userModel.cityName;
    
    NSString *sport = userModel.sportActivity;
//    NSString *isPhoneVisible = [[NSNumber numberWithBool:userModel.isPhoneVisible] stringValue];
    
    NSString *latitude = [[NSNumber numberWithFloat:userModel.location.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithFloat:userModel.location.longitude] stringValue];
    NSNumber *hidePhone = [NSNumber numberWithBool:!userModel.isPhoneVisible];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"export_register"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_NICKNAME      :   firstName ? firstName : @"",
                             API_REQ_KEY_USER_LAST_NAME     :   lastName ? lastName : @"",
                             API_REQ_KEY_USER_EMAIL         :   eMail ? eMail : @"",
                             API_REQ_KEY_USER_PWD           :   password ? password : @"",
                             API_REQ_KEY_SPORT_UID          :   sport ? sport : @"",
                             API_REQ_KEY_CONTENT            :   additionalInfo ? additionalInfo : @"",
                             @"longitude"                   :   longitude,
                             @"latitude"                    :   latitude,
                             @"hide_phone"                  :   hidePhone,
                             @"awards"                      :   awards ? awards : @"",
                             @"user_city"                   :   city ? city : @"",
                             @"user_address"                :   address ? address : @"",
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
                message = @"Due to the qualification and approval process someone from TAG-A-LONG will contact you within next 24 hours";
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
        [weakSelf.output proUserDidSignUpSuccessed:isSuccessed andMessage:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output proUserDidSignUpSuccessed:NO andMessage:error.localizedDescription];
    }];
}

- (void)updateAddressByLocation:(CLLocationCoordinate2D)location withConpletion:(void (^)(NSString *, NSString *))completion {
    
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
        NSString *address = respObject[@"address"];
        
        if (completion) {
            completion(city, address);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output proUserDidSignUpSuccessed:NO andMessage:error.localizedDescription];
    }];
}

#pragma mark - Private

- (NSString*)isUserDataValid:(ProUserSignUpDataModel*)user {
    
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
    
    if (user.sportActivity.length == 0) {
        return @"Please, Enter Sport Activity";
    }
    
    if (user.awards.length == 0) {
        return @"Please, input awards!";
    }
    
    return nil;
}

@end
