//
//  SubmitOfferDurationCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferDurationCellAdapter.h"
#import "SubmitOfferDurationTableViewCell.h"
#import "UIView+Nib.h"

@interface SubmitOfferDurationCellAdapter()

@property (nonatomic, weak) id <SubmitOfferDurationCellAdapterOutput> output;

@end

@implementation SubmitOfferDurationCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferDurationCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferDurationTableViewCell *cell = (SubmitOfferDurationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferDurationTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferDurationTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferDurationTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(durationCellDidTap)]) {
        [self.output durationCellDidTap];
    }
}

@end
