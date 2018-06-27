//
//  SImpleUserEditProfileModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileModel.h"
#import "PaymentClient+CreditCard.h"

@interface SimpleUserEditProfileModel()

@property (nonatomic, weak) id <SimpleUserEditProfileModelOutput> output;

@end

@implementation SimpleUserEditProfileModel

- (instancetype)initWithOutput:(id<SimpleUserEditProfileModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SimpleUserEditProfileModelInput

- (void)loadCrediCardsWithCompletion:(void(^)(NSArray *cards))completion {
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        
        if (completion) {
            completion(cards);
        }
        
    }];
}

- (void)loadCrediCards {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        NSString *cardInfo = @"no credit card";
        
        if (cards.count != 0) {
            NSDictionary *card = cards.firstObject;
            cardInfo = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
        }
        
        [weakSelf.output creditCardsDidLoadSuccess:(error == nil) cardInfo:cardInfo];        
    }];
}

- (void)updateAreaRadius:(BOOL)isEnabled miles:(NSString*)miles {
    
    NSNumber *limit = isEnabled ? @(miles.integerValue) : @(-1);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_PROFILE_UPDATE];
    
    NSDictionary *params = @{ @"pro_search_radius" : limit };
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        BOOL isSuccess = NO;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            isSuccess = YES;
            [self.output areaRadiusDidUpdateSuccess:isSuccess message:@"Changes did save successfully"];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
        
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            
        }
        [self.output areaRadiusDidUpdateSuccess:isSuccess message:@"Undefined error. Please, try again or later"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [self.output areaRadiusDidUpdateSuccess:NO message:error.localizedDescription];
    }];
}

#pragma mark - Private

@end
