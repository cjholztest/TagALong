//
//  SimpleUserProfileMapper.h
//  TagALong
//
//  Created by User on 7/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleUserProfile;

@interface SimpleUserProfileMapper : NSObject

+ (SimpleUserProfile*)simpleUserProfileFromJSON:(NSDictionary*)json;
+ (NSDictionary*)jsonFromSimpleUserProfile:(SimpleUserProfile*)profile;

@end
