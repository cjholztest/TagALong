//
//  ProUserSignUpBirthdayCellAdapter.m
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpBirthdayCellAdapter.h"
#import "ProUserSignUpBirthdayTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpBirthdayCellAdapter () <ProUserSignUpBirthdayTableViewCellOutput>

@property (nonatomic, weak) id <ProUserSignUpBirthdayCellAdapterOutput> output;

@end

@implementation ProUserSignUpBirthdayCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpBirthdayCellAdapterOutput>)output {
    if (self = [self init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserSignUpBirthdayTableViewCell.viewNib forCellReuseIdentifier:ProUserSignUpBirthdayTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserSignUpBirthdayTableViewCell *cell = (ProUserSignUpBirthdayTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserSignUpBirthdayTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    NSString *month = [self.output birthdayMonth];
    
    BOOL isMonth = month.length > 0;
    
    UIColor *monthTextColor = isMonth ? UIColor.textColor : UIColor.placeholderColor;
    
    if (!isMonth) {
        month = @"Month";
    }
    
    [cell.monthButton setTitleColor:monthTextColor forState:UIControlStateNormal];
    [cell.monthButton setTitleColor:monthTextColor forState:UIControlStateSelected];
    [cell.monthButton setTitleColor:monthTextColor forState:UIControlStateHighlighted];
    
    [cell.monthButton setTitle:month forState:UIControlStateNormal];
    [cell.monthButton setTitle:month forState:UIControlStateSelected];
    [cell.monthButton setTitle:month forState:UIControlStateHighlighted];
    
    NSString *year = [self.output birthdayYear];
    
    BOOL isYear = year.length > 0;
    
    UIColor *yearTextColor = isYear ? UIColor.textColor : UIColor.placeholderColor;
    
    if (!isYear) {
        year = @"Year";
    }
    
    [cell.yearButton setTitleColor:yearTextColor forState:UIControlStateNormal];
    [cell.yearButton setTitleColor:yearTextColor forState:UIControlStateSelected];
    [cell.yearButton setTitleColor:yearTextColor forState:UIControlStateHighlighted];
    
    [cell.yearButton setTitle:year forState:UIControlStateNormal];
    [cell.yearButton setTitle:year forState:UIControlStateSelected];
    [cell.yearButton setTitle:year forState:UIControlStateHighlighted];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {

}

#pragma mark - ProUserSignUpBirthdayTableViewCellOutput

- (void)monthButtonDidTap {
    if ([self.output respondsToSelector:@selector(birthdayMonthDidTap)]) {
        [self.output birthdayMonthDidTap];
    }
}

- (void)yearButtonDidTap {
    if ([self.output respondsToSelector:@selector(birthdayYearDidTap)]) {
        [self.output birthdayYearDidTap];
    }
}

@end
