//
//  ProUserSignUpModel.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpModel.h"

@interface ProUserSignUpModel()

@property (nonatomic, weak) id <ProUserSignUpModelOutput> output;

@end

@implementation ProUserSignUpModel

- (instancetype)initWithOutput:(id<ProUserSignUpModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

@end
