//
//  ProsFilterViewController.h
//  TagALong
//
//  Created by User on 7/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProsFilterModuleProtocols.h"

@interface ProsFilterViewController : UIViewController <ProsFilterModuleInput>

@property (nonatomic, weak) id <ProsFilterModuleOutput> moduleOutput;

@end
