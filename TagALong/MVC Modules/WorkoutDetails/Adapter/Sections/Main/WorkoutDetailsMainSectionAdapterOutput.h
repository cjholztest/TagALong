//
//  WorkoutDetailsMainSectionAdapterOutput.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WorkoutDetailsMainSectionAdapterOutput <NSObject>

- (NSInteger)reviewRowsCount;

- (id)infoDisplayModelAtIndexPath:(NSIndexPath*)indexPath;

@end
