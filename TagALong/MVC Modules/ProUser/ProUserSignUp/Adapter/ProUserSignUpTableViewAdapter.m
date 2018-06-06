//
//  ProUserSignUpTableViewAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpTableViewAdapter.h"

@interface ProUserSignUpTableViewAdapter() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProUserSignUpTableViewAdapter

#pragma mark - Lazy

- (NSArray<ProUserSignUpSectionAdapter>*)sectionAdapters {
    if (!_sectionAdapters) {
        _sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> new];
    }
    return _sectionAdapters;
}

#pragma mark - ProsTableViewAdapterInput

- (void)setupWithTableView:(UITableView*)tableView {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorColor = [UIColor.whiteColor colorWithAlphaComponent:0.05];
    
    tableView.tableFooterView = [UIView new];
    
    for (id <ProUserSignUpSectionAdapter> section in self.sectionAdapters) {
        [section registerCellsInTableView:tableView];
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionAdapters[indexPath.section] cellForTableView:tableView atIndexPath:indexPath];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionAdapters[section] numberOfRows];;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionAdapters[indexPath.section] estimatedHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionAdapters[indexPath.section] heightForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionAdapters[indexPath.section] shouldHighightRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sectionAdapters[indexPath.section] didSelectRowInTableView:tableView atIndexPath:indexPath];
}

@end
