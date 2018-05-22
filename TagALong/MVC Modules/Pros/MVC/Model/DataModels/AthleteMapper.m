//
//  AthleteMapper.m
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteMapper.h"
#import "AthleteDataModel.h"

@implementation AthleteMapper

+ (AthleteDataModel*)athleteFromJSON:(NSDictionary*)json {
    
    AthleteDataModel *athlete = [AthleteDataModel new];
    
    athlete.firstName = json[@"user_nck"];
    athlete.lastName = json[@"user_last_name"];
    athlete.userUID = json[@"user_uid"];
    athlete.city = json[@"user_city"];
    athlete.sportIndex = json[@"sport_uid"];
    athlete.profileImage = json[@"profile_img"];
    athlete.longitude = json[@"longitude"];
    athlete.latitude = json[@"latitude"];
    athlete.level = json[@"level"];
    athlete.awards = json[@"awards"];
    athlete.additionalInfo = json[@"content"];
    
    return athlete;
}

@end
