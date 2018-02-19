//
//  NSURLHelper.m
//  GumBook
//
//  Created by Smith J. on 2/22/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import "NSURLHelper.h"

@implementation NSURLHelper

+ (NSURL *)URLWithString:(NSString *)url {
    if (url == nil)
        return nil;
    NSString *str = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:str];
}

@end
