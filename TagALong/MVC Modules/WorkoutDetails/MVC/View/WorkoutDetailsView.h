//
//  WorkoutDetailsView.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutDetailsModuleProtocols.h"

@interface WorkoutDetailsView : UIView <WorkoutDetailsViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *confirmationButton;

@property (nonatomic, weak) IBOutlet UIImageView *profileIconImageView;

@property (nonatomic, weak) IBOutlet UILabel *userTypeLabel;

@property (nonatomic, weak) id <WorkoutDetailsViewOutput> output;

@end
