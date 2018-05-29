//
//  WorkoutDetailsModuleProtocols.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WorkoutDetailsModelInput <NSObject>

- (void)loadDetaisForWorkout:(NSString*)workoutUID;

@end

@protocol WorkoutDetailsModelOutput <NSObject>

@end

@protocol WorkoutDetailsViewInput <NSObject>

@end

@protocol WorkoutDetailsViewOutput <NSObject>

@end

@protocol WorkoutDetailsModuleInput <NSObject>

- (void)setupWorkout:(id)workout;

@end

@protocol WorkoutDetailsModuleOutput <NSObject>

@end
