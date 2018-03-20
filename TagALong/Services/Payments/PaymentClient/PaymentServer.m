//
//  PaymentServer.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentServer.h"

@implementation PaymentServer

+ (PaymentServer*)shared {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [PaymentServer new];
    });
    return instance;
}

@end
