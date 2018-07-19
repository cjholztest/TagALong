//
//  Birthday.h
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Birthday : NSObject

@property (nonatomic, strong) NSString *monthTitle;
@property (nonatomic, strong) NSString *yearTitle;
@property (nonatomic, assign) NSInteger monthIndex;

- (BOOL)dataExists;
- (NSTimeInterval)timeInterval;

@end
