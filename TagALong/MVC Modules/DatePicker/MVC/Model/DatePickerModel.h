//
//  DatePickerModel.h
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerModuleProtocols.h"

@interface DatePickerModel : NSObject <DatePickerModelInput>

- (instancetype)initWithOutput:(id<DatePickerModelOutput>)output andType:(DatePickerType)type;

@end
