//
//  ProsTableViewAdapter.m
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsTableViewAdapter.h"

@interface ProsTableViewAdapter() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProsTableViewAdapter

#pragma mark - Lazy

- (NSMutableArray<ProsSectionAdapter>*)sectionAdapters {
    if (!_sectionAdapters) {
        _sectionAdapters = [NSMutableArray<ProsSectionAdapter> new];
    }
    return _sectionAdapters;
}

#pragma mark - ProsTableViewAdapterInput

- (void)setupWithTableView:(UITableView*)tableView {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    for (id <ProsSectionAdapter> section in self.sectionAdapters) {
        [section registerCellsInTableView:tableView];
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(self.sectionAdapters[indexPath.section]) cellForTableView:tableView atIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(self.sectionAdapters[section]) numberOfRows];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(self.sectionAdapters[indexPath.section]) estimatedHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(self.sectionAdapters[indexPath.section]) heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(self.sectionAdapters[indexPath.section]) didSelectRowInTableView:tableView atIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(self.sectionAdapters[indexPath.section]) shouldHighightRowAtIndexPath:indexPath];
}

@end
