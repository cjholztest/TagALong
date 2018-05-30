//
//  WorkoutDetailsMainSectionAdapter.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsMainSectionAdapter.h"
#import "UIView+Nib.h"
#import "WorkoutMainDetailsTableViewCell.h"
#import "ReviewOfferCellDisplayModel.h"

@interface WorkoutDetailsMainSectionAdapter()

@property (nonatomic, weak) id <WorkoutDetailsMainSectionAdapterOutput> output;

@end

@implementation WorkoutDetailsMainSectionAdapter

- (instancetype)initWithOutput:(id<WorkoutDetailsMainSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - MainSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[WorkoutMainDetailsTableViewCell viewNib] forCellReuseIdentifier:[WorkoutMainDetailsTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return [self.output reviewRowsCount];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    WorkoutMainDetailsTableViewCell *cell = (WorkoutMainDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:WorkoutMainDetailsTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    ReviewOfferCellDisplayModel *displayModel = [self.output infoDisplayModelAtIndexPath:indexPath];
    
//    cell.titleLabel.text = displayModel.title;
//    cell.durationLabel.text = displayModel.text;
    
    //    WorkoutMainDetailsTableViewCellDisplayModel *displayModel = [self.output rowDisplayModelAtIndexPath:indexPath];
    //    [cell setupWithDisplayModel:displayModel];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 54.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 54.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

@end