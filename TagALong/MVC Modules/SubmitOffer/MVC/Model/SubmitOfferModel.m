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
    
    NSDictionary *parameters = [OfferMapper jsonFromOffer:self.offer];
    
    return;
    
//    [SharedAppDelegate showLoading];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
//
//    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"bids/make_bid"];
//
//    NSDictionary *params = @{API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
//                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude};
    
    //    NSDictionary *params = @{API_REQ_KEY_USER_LATITUDE      :   @(0.0f),
    //                             API_REQ_KEY_USER_LONGITUDE     :   @(0.0f)};
    
//    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        //        NSError* error;
        //        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
        //                                                                       options:kNilOptions
        //                                                                         error:&error];
//        [SharedAppDelegate closeLoading];
//
//        self.athletesDisplayModels = [NSMutableArray array];
//        self.athletes = [NSMutableArray array];
//
//        for (NSDictionary *dict in responseObject) {
//
//            AthleteDataModel *athlete = [AthleteMapper athleteFromJSON:dict];
//            [self.athletes addObject:athlete];
//
//            ProsTableViewCellDisplayModel *displayModel = [ProsTableViewCellDisplayModel new];
//
//            displayModel.nameText = [NSString stringWithFormat:@"%@ %@", athlete.firstName, athlete.lastName];
//            displayModel.locationText = athlete.city;
//
//            //                displayModel.descriptionText = [NSString stringWithFormat:@"Description %lu", i];
//            //                displayModel.subInfoText = [NSString stringWithFormat:@"Sub info %lu", i];
//
//            [self.athletesDisplayModels addObject:displayModel];
//
//        }
//
//        [self.output prosDidLoadSuccessfully];
        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error: %@", error);
//        [SharedAppDelegate closeLoading];
//        [Commons showToast:@"Failed to communicate with the server"];
        
//    }];
}

@end
