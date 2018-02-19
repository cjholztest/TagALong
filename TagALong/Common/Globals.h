//
//  Globals.h
//  TagALong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUser.h"
#import "MExpertUser.h"

@interface Globals : NSObject

+ (Globals *)getSharedInstance;

//사용자 정보
@property(nonatomic, retain) MUser *g_user;
@property(nonatomic, retain) MExpertUser *g_expert;

@property(nonatomic, retain) NSString *g_token;


@end
