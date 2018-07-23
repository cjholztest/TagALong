//
//  ProsViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProsModuleProtocols.h"

@interface ProsViewController : UIViewController <ProsModuleInput>

@property (nonatomic, weak) id <ProsModuleOutput> moduleOutput;

@end
