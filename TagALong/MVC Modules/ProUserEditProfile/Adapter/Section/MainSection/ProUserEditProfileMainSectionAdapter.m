//
//  ProUserEditProfileMainSectionAdapter.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileMainSectionAdapter.h"

@implementation ProUserEditProfileMainSectionAdapter

#pragma mark - ProUserSignUpSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    for (id <ProUserEditProfileCellAdapter> cell in self.cellAdapters) {
        [cell registerCellsInTableView:tableView];
    }
}

- (NSInteger)numberOfRows {
    return self.cellAdapters.count;
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    return [self.cellAdapters[indexPath.row] cellForTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self.cellAdapters[indexPath.row] estimatedHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self.cellAdapters[indexPath.row] heightForRowAtIndexPath:indexPath];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self.cellAdapters[indexPath.row] shouldHighightRowAtIndexPath:indexPath];
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    [self.cellAdapters[indexPath.row] didSelectRowInTableView:tableView atIndexPath:indexPath];
}


@end
