//
//  ReviewOfferDataModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewOfferDataModel : NSObject

@property (nonatomic, strong) NSNumber *bidUID;
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *postType;

@property (nonatomic, strong) NSNumber *toTrainerUID;
@property (nonatomic, strong) NSNumber *fromUserUID;

@property (nonatomic, strong) NSNumber *totalPeople;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSDate *workoutDate;
@property (nonatomic, strong) NSDate *workoutTime;
@property (nonatomic, strong) NSString *workoutTimeSting;

@property (nonatomic, strong) NSString *descriptionInfo;
@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSString *additionalInfo;

- (NSString*)timeString;

@end
