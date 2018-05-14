//
//  ProsView.h
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProsModuleProtocols.h"

@interface ProsView : UIView

@property (nonatomic, weak) id <ProsViewOutput> output;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
