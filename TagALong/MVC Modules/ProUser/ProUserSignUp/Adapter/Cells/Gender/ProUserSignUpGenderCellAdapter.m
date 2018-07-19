//
//  ProUserSignUpGenderCellAdapter.m
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpGenderCellAdapter.h"
#import "ProUserSignUpInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpGenderCellAdapter ()

@property (nonatomic, weak) id <ProUserSignUpGenderCellAdapterOutput> output;

@end

@implementation ProUserSignUpGenderCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpGenderCellAdapterOutput>)output {
    if (self = [self init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserSignUpInfoTableViewCell.viewNib forCellReuseIdentifier:ProUserSignUpInfoTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserSignUpInfoTableViewCell *cell = (ProUserSignUpInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserSignUpInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    NSString *gender = [self.output gender];
    
    if (gender) {
        cell.infoLabel.text = gender;
        cell.infoLabel.textColor = [UIColor textColor];
    } else {
        cell.infoLabel.text = @"Select Gender";
        cell.infoLabel.textColor = [UIColor placeholderColor];
    }
    
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
    if ([self.output respondsToSelector:@selector(genderDidTap)]) {
        [self.output genderDidTap];
    }
}

@end
