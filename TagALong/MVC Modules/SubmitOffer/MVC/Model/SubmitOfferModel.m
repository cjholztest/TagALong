//
//  SubmitOfferModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferModel.h"
#import "OfferDataModel.h"
#import "OfferMapper.h"
#import "PaymentClient+CreditCard.h"

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

- (void)updateTime:(NSString *)timeString {
    self.offer.timeString = timeString;
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
    
    __weak typeof(self)weakSelf = self;
    
    [self requestCardInfoWithCompletion:^(NSString *cardID) {
        if (cardID) {
            [weakSelf submitOffer];
        } else {
            [weakSelf.output showAddCreditCard];
        }
    }];
}

#pragma mark - Prvate

- (void)requestCardInfoWithCompletion:(void(^)(NSString *cardID))completion {
    
    __weak typeof(self)weakSelf = self;
    [SharedAppDelegate showLoading];
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        [SharedAppDelegate closeLoading];
        if (error) {
            [weakSelf.output offerDidSubmitSuccess:NO message:error.localizedDescription];
        } else {
            NSArray *cardList = responseObject;
            NSString *ccUIID = nil;
            
            if (cardList.count > 0) {
                NSDictionary *card = cardList.firstObject;
                ccUIID = card[@"card_uid"];
            }
            
            if (completion) {
                completion(ccUIID);
            }
        }
    }];
}

- (void)submitOffer {
    
    NSString *validationMessage = [self validateOfferData];
    if (validationMessage) {
        [self.output validationDidFailWithMessage:validationMessage];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    
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
        
        BOOL isSuccessed = NO;
        NSString *message = nil;
        
        NSNumber *result = responseObject[@"result"];
        if ([result integerValue] == 1) {
            isSuccessed = YES;
            message = @"Your offer has been successfully submited!";
        }
        
        [weakSelf.output offerDidSubmitSuccess:isSuccessed message:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output offerDidSubmitSuccess:NO message:error.localizedDescription];
    }];
}

- (NSString*)validateOfferData {
    
    if (self.offer.who.length == 0) {
        return @"Select number of people";
    }
    
    if (!self.offer.date) {
        return @"Input Date";
    }
    
    if (!self.offer.timeString) {
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
