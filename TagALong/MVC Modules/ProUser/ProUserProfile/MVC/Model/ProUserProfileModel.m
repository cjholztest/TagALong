//
//  ProUserProfileModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserProfileModel.h"

@interface ProUserProfileModel()

@property (nonatomic, weak) id <ProUserProfileModelOutput> output;

@end

@implementation ProUserProfileModel

- (instancetype)initWithOutput:(id<ProUserProfileModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}



@end
