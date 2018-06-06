//
//  AthleteMapper.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AthleteDataModel;

@interface AthleteMapper : NSObject

+ (AthleteDataModel*)athleteFromJSON:(NSDictionary*)json;

@end
