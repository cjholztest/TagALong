//
//  SubmitOfferTableViewAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferTableViewAdapter.h"

@interface SubmitOfferTableViewAdapter() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SubmitOfferTableViewAdapter

#pragma mark - Lazy

- (NSMutableArray<SubmitOfferSectionAdapter>*)sectionAdapters {
    if (!_sectionAdapters) {
        _sectionAdapters = [NSMutableArray<SubmitOfferSectionAdapter> new];
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
    
    for (id <SubmitOfferSectionAdapter> section in self.sectionAdapters) {
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
