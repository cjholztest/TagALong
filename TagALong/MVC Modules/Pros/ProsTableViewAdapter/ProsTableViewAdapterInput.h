//
//  ProsTableViewAdapterInput.h
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ProsTableViewAdapterInput <NSObject>

- (void)setupWithTableView:(UITableView*)tableView;

@end
