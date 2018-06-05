//
//  RegularUserInfoMapper.h
//  TagALong
//
//  Created by User on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegularUserInfoDataModel;

@interface RegularUserInfoMapper : NSObject

+ (RegularUserInfoDataModel*)regularUserInfoFromJSON:(NSDictionary*)json;

@end
