//
//  ProsFilterView.h
//  TagALong
//
//  Created by User on 7/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProsFilterModuleProtocols.h"

@interface ProsFilterView : UIView

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <ProsFilterViewOutput> output;

@end
