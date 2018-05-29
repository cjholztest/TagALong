//
//  WorkoutDetailsTableViewAdapter.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsTableViewAdapter.h"

@interface WorkoutDetailsTableViewAdapter()
<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation WorkoutDetailsTableViewAdapter

#pragma mark - Lazy

- (NSMutableArray<WorkoutDetailsSectionAdapter>*)sectionAdapters {
    if (!_sectionAdapters) {
        _sectionAdapters = [NSMutableArray<WorkoutDetailsSectionAdapter> new];
    }
    return _sectionAdapters;
}

#pragma mark - SubmitOfferTableViewAdapterInput

- (void)setupWithTableView:(UITableView*)tableView {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [UIView new];
    tableView.separatorInset = UIEdgeInsetsZero;
    
    tableView.backgroundView.backgroundColor = UIColor.clearColor;
    tableView.backgroundColor = UIColor.clearColor;
    
    tableView.separatorColor = [UIColor.whiteColor colorWithAlphaComponent:0.05];
    
    for (id <WorkoutDetailsSectionAdapter> section in self.sectionAdapters) {
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
