//
//  ProsSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ProsSectionAdapter <NSObject>

- (void)registerCellsInTableView:(UITableView*)tableView;

- (NSInteger)numberOfRows;
- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

@end
