//
//  PickerModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerModuleProtocols.h"

@interface PickerModel : NSObject <PickerModelInput, PickerMilesProtocol>

- (instancetype)initWithOutput:(id <PickerModelOutput>)output andPickerType:(PickerType)type;

@end
