//
//  PickerViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerModuleProtocols.h"

@interface PickerViewController : UIViewController <PickerModuleInput>

@property (nonatomic, weak) id <PickerModuleOutput> moduleOutput;

@end
