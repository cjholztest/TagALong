//
//  WorkoutDetailsDataModel.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutDetailsDataModel : NSObject

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSNumber *amount;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, strong) NSNumber *postType;
@property (nonatomic, strong) NSNumber *postUID;

@property (nonatomic, strong) NSNumber *sportUID;
@property (nonatomic, strong) NSNumber *isPrivate;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *workoutDate;

@property (nonatomic, strong) NSString *startTimeString;

@property (nonatomic, strong) NSNumber *repeat;
@property (nonatomic, strong) NSNumber *repeatsUID;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *additionalInfo;

- (NSString*)amountText;
- (BOOL)isAmountEmpty;

@end
