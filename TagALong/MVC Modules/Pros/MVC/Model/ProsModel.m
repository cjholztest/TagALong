//
//  ProsModel.m
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsModel.h"
#import "ProsTableViewCellDisplayModel.h"

@interface ProsModel()

@property (nonatomic, weak) id <ProsModelOutput> output;

@property (nonatomic, strong) NSMutableArray *athletes;

@end

@implementation ProsModel

- (instancetype)initWithOutput:(id<ProsModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
        self.athletes = [NSMutableArray new];
        
        for (NSInteger i = 0; i < 5; i++) {
            
            ProsTableViewCellDisplayModel *displayModel = [ProsTableViewCellDisplayModel new];
            
            displayModel.nameText = [NSString stringWithFormat:@"Name %lu", i];
            if (i % 2 == 0) {
                displayModel.locationText = [NSString stringWithFormat:@"City %lu", i];
            }
            displayModel.descriptionText = [NSString stringWithFormat:@"Description %lu", i];
            displayModel.subInfoText = [NSString stringWithFormat:@"Sub info %lu", i];
            
            [self.athletes addObject:displayModel];
        }
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
