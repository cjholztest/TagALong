//
//  PickerModuleProtocols.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerModuleConstants.h"

@protocol PickerModelInput <NSObject>

- (NSInteger)componentsCount;
- (NSString*)titleForComponentAtIndex:(NSInteger)index;

- (NSString*)selectedComponent;

- (void)updateSelectedComponentWithIndex:(NSInteger)selectedIndex;

@end

@protocol PickerModelOutput <NSObject>

@end

@protocol PickerViewInput <NSObject>

@end

@protocol PickerViewOutput <NSObject>

- (void)doneButtonDidTap;
- (void)pickerViewDidHide;

@end

@protocol PickerModuleInput <NSObject>

- (void)setupWithType:(PickerType)type;

@end

@protocol PickerModuleOutput <NSObject>

- (void)durationDidSelect:(NSString*)durationText;

@end
