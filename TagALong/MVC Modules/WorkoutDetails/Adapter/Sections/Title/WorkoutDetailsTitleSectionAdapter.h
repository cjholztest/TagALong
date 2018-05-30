//
//  WorkoutDetailsTitleSectionAdapter.h
//  TagALong
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsTitleSectionAdapterOutput.h"
#import "WorkoutDetailsSectionAdapter.h"

@interface WorkoutDetailsTitleSectionAdapter : NSObject <WorkoutDetailsSectionAdapter>

- (instancetype)initWithOutput:(id<WorkoutDetailsTitleSectionAdapterOutput>)output;

@end
