//
//  WorkoutDetailsMainSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsMainSectionAdapterOutput.h"
#import "WorkoutDetailsSectionAdapter.h"

@interface WorkoutDetailsMainSectionAdapter : NSObject <WorkoutDetailsSectionAdapter>

- (instancetype)initWithOutput:(id<WorkoutDetailsMainSectionAdapterOutput>)output;

@end
