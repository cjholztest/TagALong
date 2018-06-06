//
//  ReviewOfferMapper.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferMapper.h"
#import "ReviewOfferDataModel.h"

@implementation ReviewOfferMapper

+ (ReviewOfferDataModel*)reviewOfferFromJSON:(NSDictionary*)json {
    
    ReviewOfferDataModel *reviewOffer = [ReviewOfferDataModel new];
    
    reviewOffer.bidUID = json[@"bid_uid"];
    reviewOffer.postType = json[@"post_type"];
    
    reviewOffer.amount = json[@"amount"];
    reviewOffer.additionalInfo = json[@"addition"];
    reviewOffer.descriptionInfo = json[@"description"];
    reviewOffer.duration = json[@"duration"];
    reviewOffer.totalPeople = json[@"number_of_persons"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = json[@"workout_date"];
    reviewOffer.workoutDate = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    dateFormatter.dateFormat = @"h:mm a";
    
    NSString *timeString = json[@"start_time"];
    reviewOffer.workoutTimeSting = timeString;
    reviewOffer.workoutTime = [dateFormatter dateFromString:timeString];
    
    reviewOffer.status = json[@"status"];
    reviewOffer.title = json[@"title"];
    
    reviewOffer.toTrainerUID = json[@"trainer_uid"];
    reviewOffer.fromUserUID = json[@"user_uid"];
    
    return reviewOffer;
}

@end
