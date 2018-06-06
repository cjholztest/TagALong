//
//  WorkoutDetailsModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorkoutDetailsViewDisplayModel;

@protocol WorkoutDetailsModelInput <NSObject>

- (void)loadDetaisForWorkout:(NSString*)workoutUID;
- (void)bookWorkout;

- (NSString*)titleText;
- (NSString*)additionalInfoText;

@end

@protocol WorkoutDetailsModelOutput <NSObject>

- (void)workoutDetaisDidLoadSuccess:(BOOL)isSuccessed
                            message:(NSString*)message
                      displayModels:(NSArray*)displayModels
                profileDisplayModel:(WorkoutDetailsViewDisplayModel*)profileDisplayModel;

- (void)workoutDidBookSuccess:(BOOL)isSuccessed
                      message:(NSString*)message;

- (void)showConfirmationPyamentAlertWithAmount:(NSString*)amount andCompletion:(void(^)(void))completion;

- (void)creditCardNotFound;

- (void)showLoader;
- (void)hideLoader;

@end

@protocol WorkoutDetailsViewInput <NSObject>

@end

@protocol WorkoutDetailsViewOutput <NSObject>

- (void)bookWorkoutNowDidTap;
- (void)showVisitorsDidTap;

@end

@protocol WorkoutDetailsModuleInput <NSObject>

- (void)setupWorkout:(id)workout;

@end

@protocol WorkoutDetailsModuleOutput <NSObject>

@end
