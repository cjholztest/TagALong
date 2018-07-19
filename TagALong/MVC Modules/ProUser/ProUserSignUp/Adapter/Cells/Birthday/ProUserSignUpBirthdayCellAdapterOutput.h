//
//  ProUserSignUpBirthdayCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpBirthdayCellAdapterOutput <NSObject>

- (void)birthdayMonthDidTap;
- (void)birthdayYearDidTap;

- (NSString*)birthdayMonth;
- (NSString*)birthdayYear;

@end
