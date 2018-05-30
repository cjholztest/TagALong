//
//  WorkoutProfileInfoMapper.h
//  TagALong
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorkoutProfileInfoDataModel;

@interface WorkoutProfileInfoMapper : NSObject

+ (WorkoutProfileInfoDataModel*)profileInfoFromJSON:(NSDictionary*)json;

@end
