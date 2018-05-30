//
//  SportService.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportService : NSObject

+ (instancetype)shared;

- (NSString*)sportNameForIndex:(NSInteger)index;
- (NSString*)categoryNameForIndex:(NSInteger)index;
- (NSString*)levelTitleByLevelIndex:(NSString*)index;

@end