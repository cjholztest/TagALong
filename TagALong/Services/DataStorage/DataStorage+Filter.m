//
//  DataStorage+Filter.m
//  TagALong
//
//  Created by User on 8/6/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "DataStorage+Filter.h"
#import "Miles.h"

static NSString *const kProsRadiusKey = @"ProsRadiusKey";
static NSString *const kMapRadiusKey = @"MapRadiusKey";

@implementation DataStorage (Filter)

+ (void)saveProsRadiusSelectedIndex:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setObject:@(index) forKey:kProsRadiusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeProsRadiusSelectedIndex {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kProsRadiusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)prosRadiusSelectedIndex {
    NSNumber *index = [[NSUserDefaults standardUserDefaults] objectForKey:kProsRadiusKey];
    return index ? index.integerValue : [self lastMilesIndex];
}

+ (void)saveMapRadiusSelectedIndex:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setObject:@(index) forKey:kMapRadiusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeMapRadiusSelectedIndex {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMapRadiusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)mapRadiusSelectedIndex {
    NSNumber *index = [[NSUserDefaults standardUserDefaults] objectForKey:kMapRadiusKey];
    return index ? index.integerValue : [self lastMilesIndex];
}

#pragma mark - Helpers

+ (NSInteger)lastMilesIndex {
    return [Miles milesValues].count - 1;
}

@end
