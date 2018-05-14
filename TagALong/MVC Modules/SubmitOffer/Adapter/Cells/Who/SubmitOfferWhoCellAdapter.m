//
//  SubmitOfferWhoCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhoCellAdapter.h"
#import "UIView+Nib.h"
#import "SubmitOfferWhoTableViewCell.h"

@interface SubmitOfferWhoCellAdapter()

@property (nonatomic, weak) id <SubmitOfferWhoCellAdapterOutput> output;

@end

@implementation SubmitOfferWhoCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferWhoCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
    SubmitOfferWhoTableViewCell *cell = (SubmitOfferWhoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferWhoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferWhoTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferWhoTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
