//
//  SportService.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SportService.h"
#import "UIColor+AppColors.h"

@interface SportService()

@property (nonatomic, strong) NSArray *sports;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *levels;

@end

@implementation SportService

+ (instancetype)shared {
    static SportService *sportSevice;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sportSevice = [self new];
    });
    return sportSevice;
}

#pragma mark - Lazy

- (NSArray*)sports {
    if (!_sports) {
        _sports = @[@"Running",
                    @"Cycling",
                    @"Yoga",
                    @"Pilates",
                    @"Crossfit",
                    @"Other"];
    }
    return _sports;
}

- (NSArray*)categories {
    if (!_categories) {
        _categories = @[@"Cardio",
                        @"Strength",
                        @"High Intensity",
                        @"Balance",
                        @"Weights",
                        @"Intervals"];
    }
    return _categories;
}

- (NSArray*)levels {
    if (!_levels) {
        _levels = @[@"INDIVIDUAL",
                    @"GYM",
                    @"PRO",
                    @"TRAINER"];
    }
    return _levels;
}

#pragma mark - Public

- (NSString*)sportNameForIndex:(NSInteger)index {
    NSString *sport = @"";
    if (index > -1 && index < self.sports.count) {
        sport = self.sports[index];
    }
    return sport;
}

- (NSString*)categoryNameForIndex:(NSInteger)index {
    NSString *category = @"";
    if (index > -1 && index < self.sports.count) {
        category = self.categories[index];
    }
    return category;
}

- (NSString*)levelTitleByLevelIndex:(NSString*)index {
    
    NSString *title = @"";
    NSInteger levelIndex = [index integerValue];
    
    if (levelIndex > -1 && levelIndex < self.levels.count) {
        title = self.levels[levelIndex];
    }
    return title;
}

- (UIColor*)backgroundColorForLevel:(NSString*)level {
    
    UIColor *color = nil;
    
    switch (level.integerValue) {
        case 0:
            color = UIColor.individualBackgroundColor;
            break;
        case 1:
            color = UIColor.gymBackgroundColor;
            break;
        case 2:
            color = UIColor.proBackgroundColor;
            break;
        case 3:
            color = UIColor.trainerBackgroundColor;
            break;
        default:
            break;
    }
    
    return color;
}

- (UIColor*)titleColorForLevel:(NSString*)level {
    
    UIColor *color = nil;
    
    switch (level.integerValue) {
        case 0:
            color = UIColor.individualTextColor;
            break;
        case 1:
            color = UIColor.gymTextColor;
            break;
        case 2:
            color = UIColor.proTextColor;
            break;
        case 3:
            color = UIColor.trainerTextColor;
            break;
        default:
            break;
    }
    
    return color;
}

- (BOOL)isLevelIndividual:(NSNumber*)level {
    return level.integerValue == 0;
}

@end
