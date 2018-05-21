//
//  PinView.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "Pin.h"

@implementation Pin

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate {
    if (self = [super init]) {
        _coordinate = newCoordinate;
    }
    return self;
}

@end
