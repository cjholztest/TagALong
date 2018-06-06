//
//  WorkoutDetailsViewDisplayModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutDetailsModuleConstants.h"

@interface WorkoutDetailsViewDisplayModel : NSObject

@property (nonatomic, strong) NSString *fullNameText;
@property (nonatomic, strong) NSString *locationText;
@property (nonatomic, strong) NSString *phoneText;
@property (nonatomic, strong) NSString *levelText;
@property (nonatomic, strong) NSString *iconURL;

@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, assign) BOOL isButtonVisible;
@property (nonatomic, assign) WorkoutDetailsButtonType actionButtonType;

@property (nonatomic, strong) UIColor *lineBackgroundColor;
@property (nonatomic, strong) UIColor *lineTextColor;

@end
