//
//  AthleteInfoModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteInfoModel.h"

@interface AthleteInfoModel()

@property (nonatomic, weak) id <AthleteInfoModelOutput> output;

@end

@implementation AthleteInfoModel

- (instancetype)initWithOuput:(id<AthleteInfoModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - AthleteInfoModelInput

- (void)loadData {
    
    __weak typeof(self)weakSelf = self;
}

@end
