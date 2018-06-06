//
//  WorkoutDetailsMainSectionAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WorkoutDetailsMainSectionAdapterOutput <NSObject>

- (NSInteger)mainRowsCount;
- (id)workoutDisplayModelAtIndexPath:(NSIndexPath*)indexPath;

@end
