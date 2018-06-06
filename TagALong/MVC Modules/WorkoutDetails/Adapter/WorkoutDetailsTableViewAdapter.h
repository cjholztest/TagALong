//
//  WorkoutDetailsTableViewAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsTableViewAdapterInput.h"
#import "WorkoutDetailsSectionAdapter.h"

@interface WorkoutDetailsTableViewAdapter : NSObject <WorkoutDetailsTableViewAdapterInput>

@property (nonatomic, strong) NSMutableArray <WorkoutDetailsSectionAdapter> *sectionAdapters;

@end
