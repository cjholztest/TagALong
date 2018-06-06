//
//  ReviewOfferTableViewAdapterInput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ReviewOfferTableViewAdapterInput <NSObject>

- (void)setupWithTableView:(UITableView*)tableView;

@end
