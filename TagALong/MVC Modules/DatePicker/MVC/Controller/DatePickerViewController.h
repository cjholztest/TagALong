//
//  DatePickerViewController.h
//  TagALong
//
//  Created by User on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerModuleProtocols.h"

@interface DatePickerViewController : UIViewController <DatePickerModuleInput>

@property (nonatomic, weak) id <DatePickerModuleOutput> moduleOutput;

@end
