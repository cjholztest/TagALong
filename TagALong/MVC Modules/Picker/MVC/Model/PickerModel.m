//
//  PickerModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
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
            case SportsPickerType:
                [self setupSportComponents];
                break;
            case TotalPeoplePickerType:
                [self setupTotalOfPeopleComponents];
                break;
            case MilesPickerType:
                [self setupMilesComponents];
                break;
            case StartTimePickerType:
                [self setupStartTimeComponents];
                break;
            case GenderPickerType:
                [self setupGenderComponentes];
                break;
            case MonthPickerType:
                [self setupMonthComponents];
                break;
            case YearPickerType:
                [self setupYearComponents];
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
    return self.selectedIndex != -1 ? self.pickerComponents[self.selectedIndex] : self.pickerComponents.firstObject;
}

- (NSInteger)selectedComponentIndex {
    return self.selectedIndex != -1 ? self.selectedIndex : 0;
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

- (void)setupStartTimeComponents {
    self.pickerComponents = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 96; i++) {
        NSString *temp = @"";
        if (i >= 48) {
            NSInteger hours = ((i - 48) * 15) / 60;
            NSInteger mins = ((i - 48) * 15) % 60;
            if (hours == 0) hours = 12;
            temp = [NSString stringWithFormat:@"%0ld:%02ld pm", hours, mins];
            [self.pickerComponents addObject:temp];
        } else {
//            if (i == 20 || i == 24 || i == 28 || i >= 32) {
            if (i == 20 || i == 24 || i == 28 || i >= 20) {
                temp = [NSString stringWithFormat:@"%0ld:%02ld am", (i * 15) / 60, (i * 15) % 60];
                [self.pickerComponents addObject:temp];
            }
        }
    }
}

- (void)setupSportComponents {
    self.pickerComponents = [NSMutableArray arrayWithObjects:@"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
}

- (void)setupTotalOfPeopleComponents {
    self.pickerComponents = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        NSString *title = [NSString stringWithFormat:@"%lu", i+1];
        [self.pickerComponents addObject:title];
    }
}

- (void)setupMilesComponents {
    self.pickerComponents = [NSMutableArray arrayWithObjects:@"No filter", @"5", @"10", @"15", @"20", @"25", @"30", nil];
}

- (void)setupGenderComponentes {
    self.pickerComponents = [NSMutableArray arrayWithObjects:@"Male", @"Female", nil];
}

- (void)setupMonthComponents {
    
    NSMutableArray *monthes = [NSMutableArray array];
    
    NSDateFormatter  *dateFormatter   = [[NSDateFormatter alloc] init];
    [monthes addObjectsFromArray:[dateFormatter monthSymbols]];
    
    self.pickerComponents = monthes;
}

- (void)setupYearComponents {
    
    NSMutableArray *years = [NSMutableArray array];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger currentYear = [components year];
    NSInteger startYear = currentYear - 100;
    
    for (NSInteger i = currentYear; i >= startYear; i--) {
        [years addObject:[NSString stringWithFormat:@"%lu", i]];
    }
    
    self.pickerComponents = years;
}

@end
