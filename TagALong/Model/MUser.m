//
//  MUser.m
//  Tagalong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import "MUser.h"

@implementation MUser

- (BOOL)loggedInUserIsPro {
    return [self.user_login isEqualToString:@"2"];
}

- (BOOL)loggedInUserIsRegualar {
    return [self.user_login isEqualToString:@"1"];
}

@end
