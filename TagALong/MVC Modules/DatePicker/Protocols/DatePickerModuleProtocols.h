//
//  DatePickerModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerModuleConstants.h"

@protocol DatePickerModelInput <NSObject>

@end

@protocol DatePickerModelOutput <NSObject>

@end

@protocol DatePickerViewInput <NSObject>

@end

@protocol DatePickerViewOutput <NSObject>

- (void)doneButtonDidTap;

@end

@protocol DatePickerModuleInput <NSObject>

- (void)setupWithType:(DatePickerType)type;

@end

@protocol DatePickerModuleOutput <NSObject>

@optional
- (void)dateDidChange:(NSDate*)date;
- (void)timeDidChange:(NSDate*)date;

@end
