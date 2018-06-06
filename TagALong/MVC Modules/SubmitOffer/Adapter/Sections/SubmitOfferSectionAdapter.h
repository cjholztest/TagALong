//
//  SubmitOfferSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferSectionAdapter <NSObject>

- (void)registerCellsInTableView:(UITableView*)tableView;

- (NSInteger)numberOfRows;
- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

@end
