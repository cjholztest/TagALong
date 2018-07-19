//
//  ProUserEditProfileView.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProUserEditProfileModuleProtocols.h"

@interface ProUserEditProfileView : UIView <ProUserEditProfileViewInput>

@property (nonatomic, weak) id <ProUserEditProfileViewOutput> output;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
