//
//  NSString+Validation.m
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isEmpty {
    return self.length == 0 || !self;
}

@end
