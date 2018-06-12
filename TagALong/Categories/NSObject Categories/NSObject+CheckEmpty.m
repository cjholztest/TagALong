//
//  NSObject+CheckEmpty.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NSObject+CheckEmpty.h"

@implementation NSObject (CheckEmpty)

- (BOOL)isNotEmpty {
    
    if ([self isKindOfClass:NSNull.class]) {
        return NO;
    }
    
    if ([self isKindOfClass:NSString.class]) {
        NSString *string = (NSString*)self;
        if (string.length == 0 || !string) {
            return NO;
        }
    }
    
    return YES;
}

@end
