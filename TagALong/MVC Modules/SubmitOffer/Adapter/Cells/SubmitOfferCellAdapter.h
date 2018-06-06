//
//  SubmitOfferCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferCellAdapter <NSObject>

- (void)registerCellsInTableView:(UITableView*)tableView;

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;

@end
