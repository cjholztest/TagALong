//
//  SubmitOfferModel.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferModel.h"
#import "OfferDataModel.h"
#import "OfferMapper.h"

@interface SubmitOfferModel()

@property (nonatomic, weak) id <SubmitOfferModelOutput> output;
@property (nonatomic, strong) OfferDataModel *offer;

@end

@implementation SubmitOfferModel

- (instancetype)initWithOutput:(id<SubmitOfferModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
        self.offer = [OfferDataModel new];
    }
    return self;
}

#pragma mark - SubmitOfferModelInput

- (void)updateDate:(NSDate*)date {
    self.offer.date = date;
    [self.output dataDidChange];
}

- (void)updateTime:(NSDate*)time {
    self.offer.time = time;
    [self.output dataDidChange];
}

- (void)updateWhoInfo:(NSString*)whoInfo {
    self.offer.who = whoInfo;
    [self.output dataDidChange];    
}

- (void)updateWhatInfo:(NSString*)whatInfo {
    self.offer.what = whatInfo;
}

- (void)updateDuration:(NSString*)duration {
    self.offer.duration = duration;
    [self.output dataDidChange];
}

- (void)updateAmount:(NSString*)amount {
    self.offer.amount = amount;
    [self.output dataDidChange];
}

- (void)updateAdditionalInfo:(NSString*)additionalInfo {
    self.offer.additionalInfo = additionalInfo;
    [self.output dataDidChange];
}

- (OfferDataModel*)currentOfferInfo {
    return self.offer;
}

- (void)submitOfferToArhlete:(NSString *)athleteID {
    
    self.offer.athleteUID = athleteID;
    self.offer.addressUID = @"-1";
    
    NSString *validationMessage = [self validateOfferData];
    if (validationMessage) {
        [self.output validationDidFailWithMessage:validationMessage];
        return;
    }
    
    [SharedAppDelegate showLoading];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];

    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"bids/make_bid"];

    NSDictionary *params = [OfferMapper jsonFromOffer:self.offer];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
//        [Commons showToast:@"Failed to communicate with the server"];
        
    }];
}

#pragma mark - Prvate

- (NSString*)validateOfferData {
    
    if (self.offer.who.length == 0) {
        return @"Select number of people";
    }
    
    if (!self.offer.date) {
        return @"Input Date";
    }
    
    if (!self.offer.time) {
        return @"Input Time";
    }
    
    if (!self.offer.duration) {
        return @"Select Duration";
    }
    
    if (!self.offer.amount) {
        return @"Input Amount";
    }
    
    return nil;
}

@end
