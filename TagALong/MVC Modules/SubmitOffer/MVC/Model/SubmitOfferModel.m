//
//  SubmitOfferModel.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferModel.h"
#import "OfferDataModel.h"

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
}

- (void)updateWhatInfo:(NSString*)whatInfo {
    self.offer.what = whatInfo;
    [self.output dataDidChange];
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

@end
