//
//  SubmitOfferMainSectionAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferMainSectionAdapter.h"

@implementation SubmitOfferMainSectionAdapter

- (NSArray<SubmitOfferCellAdapter>*)cellAdapters {
    if (!_cellAdapters) {
        _cellAdapters = [NSArray<SubmitOfferCellAdapter> new];
    }
    return _cellAdapters;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    return [self.cellAdapters[indexPath.row] cellForTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellAdapters[indexPath.row] estimatedHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellAdapters[indexPath.row] heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfRows {
    return self.cellAdapters.count;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    for (id <SubmitOfferCellAdapter> cellAdapter in self.cellAdapters) {
        [cellAdapter registerCellsInTableView:tableView];
    }
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellAdapters[indexPath.row] shouldHighightRowAtIndexPath:indexPath];
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [self.cellAdapters[indexPath.row] didSelectRowInTableView:tableView atIndexPath:indexPath];
}

@end
