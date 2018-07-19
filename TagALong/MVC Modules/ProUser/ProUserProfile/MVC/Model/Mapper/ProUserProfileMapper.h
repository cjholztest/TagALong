//
//  ProUserProfileMapper.h
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProUserProfile;

@interface ProUserProfileMapper : NSObject

+ (ProUserProfile*)proUserProfileFromJSON:(NSDictionary*)json;
+ (NSDictionary*)jsonFromProUserProfile:(ProUserProfile*)profile;

@end
