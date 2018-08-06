//
//  DataStorage+Filter.h
//  TagALong
//
//  Created by User on 8/6/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "DataStorage.h"

@interface DataStorage (Filter)

+ (void)saveProsRadiusSelectedIndex:(NSInteger)index;
+ (void)removeProsRadiusSelectedIndex;
+ (NSInteger)prosRadiusSelectedIndex;

+ (void)saveMapRadiusSelectedIndex:(NSInteger)index;
+ (void)removeMapRadiusSelectedIndex;
+ (NSInteger)mapRadiusSelectedIndex;

@end
