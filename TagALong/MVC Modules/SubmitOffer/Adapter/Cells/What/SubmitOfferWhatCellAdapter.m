//
//  SubmitOfferWhatCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhatCellAdapter.h"
#import "SubmitOfferWhatTableViewCell.h"
#import "UIView+Nib.h"

@interface SubmitOfferWhatCellAdapter()

@property (nonatomic, weak) id <SubmitOfferWhatCellAdapterOutput> output;

@end

@implementation SubmitOfferWhatCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferWhatCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferWhatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferWhatTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferWhatTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferWhatTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(whatCellDidTap)]) {
        [self.output whatCellDidTap];
    }
}

@end
