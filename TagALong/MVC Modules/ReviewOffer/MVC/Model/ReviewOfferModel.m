//
//  ReviewOfferModel.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferModel.h"

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
    [self updateOffer:offerUID withAcceptionState:YES];
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
    }];
}

@end
