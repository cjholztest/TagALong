//
//  SImpleUserEditProfileView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleUserEditProfileModuleProtocols.h"

@interface SimpleUserEditProfileView : UIView

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <SimpleUserEditProfileViewOutput> output;

@end
