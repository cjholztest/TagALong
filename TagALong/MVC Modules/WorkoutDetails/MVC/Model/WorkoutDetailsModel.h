//
//  WorkoutDetailsModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsModuleProtocols.h"

@interface WorkoutDetailsModel : NSObject <WorkoutDetailsModelInput>

- (instancetype)initWithOutput:(id<WorkoutDetailsModelOutput>)output;

@end
