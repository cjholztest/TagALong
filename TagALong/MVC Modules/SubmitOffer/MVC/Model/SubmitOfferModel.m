//
//  SubmitOfferModel.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferModel.h"

@interface SubmitOfferModel()

@property (nonatomic, weak) id <SubmitOfferModelOutput> output;

@end

@implementation SubmitOfferModel

- (instancetype)initWithOutput:(id<SubmitOfferModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferModelInput

@end
