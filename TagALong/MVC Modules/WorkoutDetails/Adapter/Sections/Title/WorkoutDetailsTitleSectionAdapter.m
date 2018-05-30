//
//  WorkoutDetailsTitleSectionAdapter.m
//  TagALong
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsTitleSectionAdapter.h"

#import "UIView+Nib.h"
#import "UIFont+HelveticaNeue.h"
#import "WorkoutTitleDetailsTableViewCell.h"
#import "ReviewOfferCellDisplayModel.h"
#import "NSString+TextSize.h"
#import "UIColor+AppColors.h"

@interface WorkoutDetailsTitleSectionAdapter()

@property (nonatomic, weak) id <WorkoutDetailsTitleSectionAdapterOutput> output;
@property (nonatomic, weak) WorkoutTitleDetailsTableViewCell *cell;
@property (nonatomic, strong) NSString *text;

@end

@implementation WorkoutDetailsTitleSectionAdapter

- (instancetype)initWithOutput:(id<WorkoutDetailsTitleSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[WorkoutTitleDetailsTableViewCell viewNib] forCellReuseIdentifier:[WorkoutTitleDetailsTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return 1;
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    WorkoutTitleDetailsTableViewCell *cell = (WorkoutTitleDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:WorkoutTitleDetailsTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.output titleAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 70.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 70.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

@end
