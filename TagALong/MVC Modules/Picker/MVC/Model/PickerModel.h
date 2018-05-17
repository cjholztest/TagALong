//
//  PickerModel.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerModuleProtocols.h"

@interface PickerModel : NSObject <PickerModelInput>

- (instancetype)initWithOutput:(id <PickerModelOutput>)output andPickerType:(PickerType)type;

@end
