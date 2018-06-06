//
//  ReviewOfferMainSectionAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferMainSectionAdapter.h"
#import "UIView+Nib.h"
#import "SubmitOfferDurationTableViewCell.h"
#import "ReviewOfferCellDisplayModel.h"

@interface ReviewOfferMainSectionAdapter()

@property (nonatomic, weak) id <ReviewOfferMainSectionAdapterOutput> output;

@end

@implementation ReviewOfferMainSectionAdapter

- (instancetype)initWithOutput:(id<ReviewOfferMainSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[SubmitOfferDurationTableViewCell viewNib] forCellReuseIdentifier:[SubmitOfferDurationTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return [self.output reviewRowsCount];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    SubmitOfferDurationTableViewCell *cell = (SubmitOfferDurationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferDurationTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    ReviewOfferCellDisplayModel *displayModel = [self.output infoDisplayModelAtIndexPath:indexPath];
    
    cell.titleLabel.text = displayModel.title;
    cell.durationLabel.text = displayModel.text;
    
//    SubmitOfferDurationTableViewCellDisplayModel *displayModel = [self.output rowDisplayModelAtIndexPath:indexPath];
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
