//
//  ChangePasswordCellAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChangePasswordCellAdapter <NSObject>

- (void)registerCellsInTableView:(UITableView*)tableView;

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

@end
