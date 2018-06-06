//
//  WorkoutDetailsModuleConstants.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BookedUsersCompletion)(NSArray *bookedUsers, NSError *error);
typedef void(^WorkoutDetilsCompletion)(NSDictionary *workoutInfo, NSError *error);

typedef enum : NSUInteger {
    NoneButtonType,
    BookNowButtonType,
    BookedUsersButtonType,
} WorkoutDetailsButtonType;
