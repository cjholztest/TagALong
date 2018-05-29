//
//  WorkoutDetailsAdditionalSectionAdapter.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsAdditionalSectionAdapterOutput.h"
#import "WorkoutDetailsSectionAdapter.h"

@interface WorkoutDetailsAdditionalSectionAdapter : NSObject

- (instancetype)initWithOutput:(id<WorkoutDetailsAdditionalSectionAdapterOutput>)output;

@end
