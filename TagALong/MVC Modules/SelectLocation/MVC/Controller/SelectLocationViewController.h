//
//  SelectLocationViewController.h
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectLocationModuleProtocols.h"

@interface SelectLocationViewController : UIViewController <SelectLocationModuleInput>

@property (nonatomic, weak) id <SelectLocationModuleOutput> moduleOutput;

@end
