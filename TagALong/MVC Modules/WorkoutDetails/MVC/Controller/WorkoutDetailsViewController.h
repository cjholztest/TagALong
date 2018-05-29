//
//  WorkoutDetailsViewController.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutDetailsModuleProtocols.h"

@interface WorkoutDetailsViewController : UIViewController <WorkoutDetailsModuleInput>

@property (nonatomic, weak) id <WorkoutDetailsModuleOutput> moduleOutput;

@end
