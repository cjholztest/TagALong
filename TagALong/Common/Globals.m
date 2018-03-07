//
//  Globals.m
//  TagALong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import "Globals.h"

static Globals * sharedInstance = nil;

@implementation Globals

+ (Globals *) getSharedInstance {
    
    if(!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

@end
