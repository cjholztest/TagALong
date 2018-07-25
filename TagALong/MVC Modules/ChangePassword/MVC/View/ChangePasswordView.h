//
//  ChangePasswordView.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordModuleProtocols.h"

@interface ChangePasswordView : UIView <ChangePasswordViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <ChangePasswordViewOutput> output;

@end
