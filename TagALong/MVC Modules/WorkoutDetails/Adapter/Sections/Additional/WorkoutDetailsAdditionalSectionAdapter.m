//
//  WorkoutDetailsAdditionalSectionAdapter.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsAdditionalSectionAdapter.h"
#import "UIView+Nib.h"
#import "UIFont+HelveticaNeue.h"
#import "WorkoutAdditionalDetailsTableViewCell.h"
#import "ReviewOfferCellDisplayModel.h"
#import "NSString+TextSize.h"
#import "UIColor+AppColors.h"

@interface WorkoutDetailsAdditionalSectionAdapter()

@property (nonatomic, weak) id <WorkoutDetailsAdditionalSectionAdapterOutput> output;
@property (nonatomic, weak) WorkoutAdditionalDetailsTableViewCell *cell;
@property (nonatomic, strong) NSString *text;

@end

@implementation WorkoutDetailsAdditionalSectionAdapter

- (instancetype)initWithOutput:(id<WorkoutDetailsAdditionalSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[WorkoutAdditionalDetailsTableViewCell viewNib] forCellReuseIdentifier:[WorkoutAdditionalDetailsTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return 1;
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    WorkoutAdditionalDetailsTableViewCell *cell = (WorkoutAdditionalDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:WorkoutAdditionalDetailsTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    self.text = [self.output additionalTextAtIndexPath:indexPath];
    cell.valueLabel.text = self.text;
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 88.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    CGFloat height = 70.0f;
    
    UIFont *font = [UIFont textFont];
    
    if (self.text && font) {
        
        [self.cell setNeedsUpdateConstraints];
        [self.cell updateConstraintsIfNeeded];
        
        CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width - 30.0f;
        
        CGFloat oneStringHeight = [@"text" sizeByWidth:contentWidth withFont:font].height;
        CGFloat textHeight = [self.text sizeByWidth:contentWidth withFont:font].height;
        
        if (textHeight > oneStringHeight) {
            height += textHeight - oneStringHeight;
        }
        
        [self.cell setNeedsLayout];
        [self.cell layoutIfNeeded];
    }
    
    return height;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

@end
