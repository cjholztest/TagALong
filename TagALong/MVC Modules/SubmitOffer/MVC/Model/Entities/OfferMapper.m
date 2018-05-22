//
//  OfferMapper.m
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "OfferMapper.h"
#import "OfferDataModel.h"

@implementation OfferMapper

+ (NSDictionary*)jsonFromOffer:(OfferDataModel*)offer {
    
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    [json setObject:offer.addressUID forKey:@"address_uid"];
    [json setObject:@([offer.who integerValue]) forKey:@"number_of_persons"];
    
    [json setObject:offer.what forKey:@"title"];
    [json setObject:offer.what forKey:@"description"];
    [json setObject:offer.athleteUID forKey:@"trainer_uid"];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:offer.date];
    
    [json setObject:dateString forKey:@"workout_date"];
    [formatter setDateFormat:@"h:mm a"];
    
    NSString *timeString = [formatter stringFromDate:offer.time];
    [json setObject:timeString forKey:@"start_time"];
    
    [json setObject:offer.duration forKey:@"duration"];
    [json setObject:@([offer.amount floatValue]) forKey:@"amount"];
    
    return json;
}

@end
