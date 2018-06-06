//
//  DatePickerView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerModuleProtocols.h"

@interface DatePickerView : UIView <DatePickerViewInput>

@property (nonatomic, weak) IBOutlet UIDatePicker *datePickerView;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@property (nonatomic, weak) id <DatePickerViewOutput> output;

@end
