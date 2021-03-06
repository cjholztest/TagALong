//
//  OfferMapper.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/22/18.
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
    [json setObject:offer.timeString forKey:@"start_time"];
    
    [json setObject:offer.duration forKey:@"duration"];
    [json setObject:@([offer.amount floatValue]) forKey:@"amount"];
    
    if (offer.additionalInfo.length > 0) {
        [json setObject:offer.additionalInfo forKeyedSubscript:@"addition"];
    }
    
    return json;
}

@end
