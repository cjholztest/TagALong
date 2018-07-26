//
//  ReviewOfferModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferModel.h"
#import "RegularUserInfoDataModel.h"
#import "RegularUserInfoMapper.h"
#import "PaymentClient+Customer.h"
#import "PaymentClient+CreditCard.h"

@interface ReviewOfferModel()

@property (nonatomic, weak) id <ReviewOfferModelOutput> output;

@end

@implementation ReviewOfferModel

- (instancetype)initWithOutput:(id<ReviewOfferModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ReviewOfferModelInput

- (void)acceptOffer:(NSString*)offerUID {
    __weak typeof(self)weakSelf = self;
    
    [self checkPaymentAccountCredentialsWithCompletion:^(BOOL isPaymentAccountExists, BOOL isCreditCradExists) {
        if (isPaymentAccountExists && isCreditCradExists) {
            [weakSelf updateOffer:offerUID withAcceptionState:YES];
        } else if (!isPaymentAccountExists && !isCreditCradExists) {
            [weakSelf.output showPaymentCredentialsRegistration];
        } else if (isPaymentAccountExists && !isCreditCradExists) {
            [weakSelf.output showAddCreditCard];
        }
    }];
}

- (void)declineOffer:(NSString*)offerUID {
    [self updateOffer:offerUID withAcceptionState:NO];
}

- (void)offerWasSeen:(NSString*)offerUID {
    [self changeOfferStateToSeen:offerUID];
}

#pragma mark - Private

- (void)updateOffer:(NSString*)offerUID withAcceptionState:(BOOL)isAccepted {
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *acceptionPath = isAccepted ? @"bids/accept_bid" : @"bids/decline_bid";
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, acceptionPath];
    
    NSDictionary *parameters = @{@"bid_uid" : offerUID};
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);

        NSNumber *result = responseObject[@"result"];
        BOOL isSuccess = result.boolValue;
        
        NSString *message = nil;
        
        if (isSuccess) {
            message = [NSString stringWithFormat:@"The Offer has been %@", isAccepted ? @"Accepted" : @"Declined"];
        } else {
            message = @"Something was wrong, try again or later";
        }
        
        [weakSelf.output showResultOfferIsAccepted:isAccepted isSuccess:isSuccess message:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError *jsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        NSString *errorMessage = dict[@"error"][@"message"];
        NSError *errorToDisplay = nil;
        if (errorMessage) {
            NSMutableDictionary* customDetails = [NSMutableDictionary dictionary];
            [customDetails setValue:errorMessage forKey:NSLocalizedDescriptionKey];
            errorToDisplay = [NSError errorWithDomain:@"local" code:200 userInfo:customDetails];
        } else {
            errorToDisplay = error;
        }
        
        [weakSelf.output showResultOfferIsAccepted:isAccepted isSuccess:NO message:error.localizedDescription];
    }];
}

- (void)changeOfferStateToSeen:(NSString*)offerUID {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"bids/view_bid"];
    
    NSDictionary *parameters = @{@"bid_uid" : offerUID};
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSNumber *result = responseObject[@"result"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        
//        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSError *jsonError = nil;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
//        NSString *errorMessage = dict[@"error"][@"message"];
//        NSError *errorToDisplay = nil;
//        if (errorMessage) {
//            NSMutableDictionary* customDetails = [NSMutableDictionary dictionary];
//            [customDetails setValue:errorMessage forKey:NSLocalizedDescriptionKey];
//            errorToDisplay = [NSError errorWithDomain:@"local" code:200 userInfo:customDetails];
//        } else {
//            errorToDisplay = error;
//        }
    }];
}

- (void)loadInfoForUserUID:(NSString*)userUID userType:(NSNumber*)userType byDate:(NSString*)date {
    
    __weak typeof(self)weakSelf = self;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url;
    
    __block BOOL isPro = NO;
    
    NSDictionary *params = [[NSDictionary alloc] init];
    if (userType.integerValue == 1) {
        url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_OTHER_GET_PROFILE];
        params = @{ API_REQ_KEY_USER_UID: userUID,
                    API_REQ_KEY_TARGET_DATE: date };
        isPro = NO;
        
    } else {
        url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"export_other_get_profile"];
        params = @{ API_REQ_KEY_EXPERT_UID: userUID,
                    API_REQ_KEY_TARGET_DATE: date };
        isPro = YES;
    }
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        BOOL isSuccessed = NO;
        NSString *message = nil;
        RegularUserInfoDataModel *userInfo = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            isSuccessed = YES;
            NSDictionary *json = responseObject[@"user_info"];
            if (isPro) {
                userInfo = [RegularUserInfoMapper proUserInfoFromJSON:json];
            } else {
                userInfo = [RegularUserInfoMapper regularUserInfoFromJSON:json];
            }
            
        }  else if(res_code == RESULT_ERROR_PASSWORD) {
            message = @"The password is incorrect";
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST) {
            message = @"User does not exist.";
        }  else if(res_code == RESULT_ERROR_PARAMETER) {
            message = @"The request parameters are incorrect.";
        }
        
        [weakSelf.output userInfoDidLoad:userInfo isSuccess:isSuccessed message:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [weakSelf.output userInfoDidLoad:nil isSuccess:NO message:error.localizedDescription];
    }];
}

- (void)checkPaymentAccountCredentialsWithCompletion:(void(^)(BOOL isPaymentAccountExists, BOOL isCreditCradExists))completion {
    [SharedAppDelegate showLoading];
    
    __block BOOL isAccountExists = NO;
    __block BOOL isCreditExists = NO;
    
    [PaymentClient expertPaymentDataWithCompletion:^(id responseObject, NSError *error) {
        BOOL isDataExists = [responseObject[@"exist"] boolValue];
        if (isDataExists) {
            isAccountExists = YES;
            [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
                [SharedAppDelegate closeLoading];
                NSArray *cards = responseObject;
                if (cards.count != 0) {
                    isCreditExists = YES;
                }
                if (completion) {
                    completion(isAccountExists, isCreditExists);
                }
            }];
        } else {
            [SharedAppDelegate closeLoading];
            if (completion) {
                completion(isAccountExists, isCreditExists);
            }
        }
    }];
}

@end
