//
//  ProUserEditProfilePaymentHeaderCellAdapter.m
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfilePaymentHeaderCellAdapter.h"
#import "ProUserEditProfileHeaderTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@implementation ProUserEditProfilePaymentHeaderCellAdapter

#pragma mark - ProUserEditProfileCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserEditProfileHeaderTableViewCell.viewNib forCellReuseIdentifier:ProUserEditProfileHeaderTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserEditProfileHeaderTableViewCell *cell = (ProUserEditProfileHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserEditProfileHeaderTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.textColor = UIColor.titleColor;
    
//    cell.titleLabel.text = @"".uppercaseString;
    
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

@end
