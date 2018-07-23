//
//  ProsFilterModel.m
//  TagALong
//
//  Created by User on 7/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsFilterModel.h"

@interface ProsFilterModel()

@property (nonatomic, weak) id <ProsFilterModelOutput> output;

@end

@implementation ProsFilterModel

- (instancetype)initWithOutput:(id<ProsFilterModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsFilterModelInput



@end
