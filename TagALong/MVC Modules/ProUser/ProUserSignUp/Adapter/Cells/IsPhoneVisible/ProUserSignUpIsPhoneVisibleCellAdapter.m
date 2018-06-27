//
//  ProUserSignUpIsPhoneVisibleCellAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpIsPhoneVisibleCellAdapter.h"
#import "ProUserSignUpSwitchTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpIsPhoneVisibleCellAdapter() <ProUserSignUpSwitchTableViewCellOutput>

@property (nonatomic, weak) id <ProUserSignUpIsPhoneVisibleCellAdapterOutput> output;

@end

@implementation ProUserSignUpIsPhoneVisibleCellAdapter

- (instancetype)initWithOutput:(id <ProUserSignUpIsPhoneVisibleCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserSignUpSwitchTableViewCell.viewNib forCellReuseIdentifier:ProUserSignUpSwitchTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserSignUpSwitchTableViewCell *cell = (ProUserSignUpSwitchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserSignUpSwitchTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    BOOL isOn = [self.output isPhoneVisible];
    [cell.switcher setOn:isOn];
    
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

#pragma mark - ProUserSignUpSwitchTableViewCellOutput

- (void)switcherDidChange:(BOOL)isOn {
    if ([self.output respondsToSelector:@selector(isPhoneVisibleStateDidChange:)]) {
        [self.output isPhoneVisibleStateDidChange:isOn];
    }
}

@end
