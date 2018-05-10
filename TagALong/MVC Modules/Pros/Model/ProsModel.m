//
//  ProsModel.m
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsModel.h"

@interface ProsModel()

@property (nonatomic, weak) id <ProsModelOutput> output;

@property (nonatomic, strong) NSMutableArray *athletes;

@end

@implementation ProsModel

- (instancetype)initWithOutput:(id<ProsModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
        self.athletes = [NSMutableArray new];
    }
    return self;
}

#pragma mark - ProsModelInput

- (void)loadPros {
    // need to add load logic
    [self.output prosDidLoadSuccessfully];
}

#pragma mark - ProsModelDataSource

- (id)athleteAtIndex:(NSInteger)index {
    return self.athletes[index];
}

- (NSInteger)athletesCount {
    return self.athletes.count;
}

@end
