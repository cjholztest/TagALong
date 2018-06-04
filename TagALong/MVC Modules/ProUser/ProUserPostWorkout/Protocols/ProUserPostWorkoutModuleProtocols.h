//
//  ProUserPostWorkoutModuleProtocols.h
//  TagALong
//
//  Created by User on 6/4/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorkoutDetailsDataModel;

@protocol ProUserPostWorkoutModelInput <NSObject>

- (void)postWorkout:(WorkoutDetailsDataModel*)workout;

@end

@protocol ProUserPostWorkoutModelOutput <NSObject>

- (void)workoutDidPostSuccess:(BOOL)isSuccesed message:(NSString*)message;

@end

@protocol ProUserPostWorkoutViewInput <NSObject>

@end

@protocol ProUserPostWorkoutViewOutput <NSObject>

- (void)postWorkoutButtonDidTap;

@end

@protocol ProUserPostWorkoutModuleInput <NSObject>



@end

@protocol ProUserPostWorkoutModuleOutput <NSObject>

@end
