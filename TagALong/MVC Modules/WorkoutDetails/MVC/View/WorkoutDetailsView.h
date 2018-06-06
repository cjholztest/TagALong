//
//  WorkoutDetailsView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutDetailsModuleProtocols.h"

@class WorkoutDetailsViewDisplayModel;

@interface WorkoutDetailsView : UIView <WorkoutDetailsViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *confirmationButton;

@property (nonatomic, weak) IBOutlet UIImageView *profileIconImageView;

@property (nonatomic, weak) IBOutlet UILabel *userTypeLabel;

@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;

@property (nonatomic, weak) IBOutlet UIView *phoneContainerView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *phoneContainerHeightLayoutConastraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonHeightLayoutConastraint;

@property (nonatomic, weak) id <WorkoutDetailsViewOutput> output;

- (void)setupWithProfileInfo:(WorkoutDetailsViewDisplayModel*)displayModel;

@end
