//
//  WorkoutDetailsMapper.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorkoutDetailsDataModel;

@interface WorkoutDetailsMapper : NSObject

+ (WorkoutDetailsDataModel*)workoutDetailsFromJSON:(NSDictionary*)json;

+ (NSDictionary*)jsonFromWorkoutDetails:(WorkoutDetailsDataModel*)workoutDetails;

@end
