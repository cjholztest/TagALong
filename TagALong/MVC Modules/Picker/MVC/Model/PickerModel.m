//
//  PickerModel.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PickerModel.h"

@interface PickerModel()

@property (nonatomic, weak) id <PickerModelOutput> output;

@property (nonatomic, strong) NSMutableArray *pickerComponents;

@property (nonatomic, assign) PickerType type;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation PickerModel

- (instancetype)initWithOutput:(id <PickerModelOutput>)output andPickerType:(PickerType)type {
    if (self = [super init]) {
        
        self.output = output;
        self.type = type;
        self.selectedIndex = -1;
        
        switch (type) {
            case DuratoinPickerType:
                [self setupDurationComponents];
                break;
            default:
                break;
        }
    }
    return self;
}

#pragma mark - PickerModelInput

- (NSInteger)componentsCount {
    return self.pickerComponents.count;
}

- (NSString*)titleForComponentAtIndex:(NSInteger)index {
    return self.pickerComponents[index];
}

- (NSString*)selectedComponent {
    return self.selectedIndex != -1 ? self.pickerComponents[self.selectedIndex] : nil;
}

- (void)updateSelectedComponentWithIndex:(NSInteger)selectedIndex {
    self.selectedIndex = selectedIndex;
}

#pragma mark - Private

- (void)setupDurationComponents {
    self.pickerComponents = [NSMutableArray array];
    for (NSInteger i = 1; i < 13; i++) {
        NSString *value = @"";
        if ((i * 15) / 60 == 0) {
            value = [NSString stringWithFormat:@"%0ldmin", (i  * 15) % 60];
        } else if ((i  * 15) % 60 == 0) {
            value = [NSString stringWithFormat:@"%0ldh", (i * 15) / 60];
        } else {
            value = [NSString stringWithFormat:@"%0ldh %0ldmin", (i * 15) / 60, (i  * 15) % 60];
        }
        [self.pickerComponents addObject:value];
    }
}

@end