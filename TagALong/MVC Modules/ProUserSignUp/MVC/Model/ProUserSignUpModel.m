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
    
    __weak typeof(self)weakSelf = self;
    
    NSString *eMail = [userModel.eMail stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *firstName = [userModel.firstName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *lastName = [userModel.lastName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *phone = [userModel.phone stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *password = [userModel.password stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *additionalInfo = [userModel.additionalInfo stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *awards = [userModel.awards stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *address = userModel.address;
    
    NSString *sport = [[NSNumber numberWithInteger:(long)userModel.sportIndex] stringValue];
//    NSString *isPhoneVisible = [[NSNumber numberWithBool:userModel.isPhoneVisible] stringValue];
    
    NSString *latitude = [[NSNumber numberWithFloat:userModel.location.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithFloat:userModel.location.longitude] stringValue];
    NSNumber *hidePhone = [NSNumber numberWithBool:!userModel.isPhoneVisible];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"export_register"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_NICKNAME      :   firstName,
                             API_REQ_KEY_USER_LAST_NAME     :   lastName,
                             API_REQ_KEY_USER_EMAIL         :   eMail,
                             API_REQ_KEY_USER_PHONE         :   phone,
                             API_REQ_KEY_USER_PWD           :   password,
                             API_REQ_KEY_SPORT_UID          :   sport,
                             API_REQ_KEY_CONTENT            :   additionalInfo,
                             @"longitude"                   :   longitude,
                             @"latitude"                    :   latitude,
                             @"hide_phone"                  :   hidePhone,
                             @"awards"                      :   awards,
                             @"user_city"                   :   address
                             };
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
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
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output proUserDidSignUpSuccessed:NO andMessage:error.localizedDescription];
    }];
}

@end
