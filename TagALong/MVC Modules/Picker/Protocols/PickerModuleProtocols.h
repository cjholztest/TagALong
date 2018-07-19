//
//  PickerModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerModuleConstants.h"

@protocol PickerModelInput <NSObject>

- (NSInteger)componentsCount;
- (NSString*)titleForComponentAtIndex:(NSInteger)index;

- (NSString*)selectedComponent;
- (NSInteger)selectedComponentIndex;

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

@optional
- (void)pickerDoneButtonDidTapWithSelectedIndex:(NSInteger)index andItemTitle:(NSString*)title;
- (void)pickerDoneButtonDidTapWithTotalOfPeople:(NSString*)title;
- (void)pickerDoneButtonDidTapWithDuration:(NSString*)duration;
- (void)pickerDoneButtonDidTapWithMiles:(NSString*)miles;
- (void)pickerDoneButtonDidTapWithStartTime:(NSString*)title;
- (void)pickerDoneButtonDidTapWithGender:(NSString*)title atIndex:(NSInteger)index;

- (void)pickerDoneButtonDidTapWithMonth:(NSString*)month atIndex:(NSInteger)index;
- (void)pickerDoneButtonDidTapWithYear:(NSString*)year;

@end
