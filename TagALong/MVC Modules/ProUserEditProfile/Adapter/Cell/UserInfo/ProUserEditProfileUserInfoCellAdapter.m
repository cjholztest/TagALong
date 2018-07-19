//
//  ProUserEditProfileUserInfoCellAdapter.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileUserInfoCellAdapter.h"
#import "ProUserEditProfileLogoInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserEditProfileUserInfoCellAdapter() <ProUserEditProfileLogoInfoTableViewCellOutput>

@property (nonatomic, weak) id <ProUserEditProfileUserInfoCellAdapterOutput> output;

@end

@implementation ProUserEditProfileUserInfoCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileUserInfoCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserEditProfileLogoInfoTableViewCell.viewNib forCellReuseIdentifier:ProUserEditProfileLogoInfoTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserEditProfileLogoInfoTableViewCell *cell = (ProUserEditProfileLogoInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserEditProfileLogoInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    NSString *urlString = self.output.userProfileIconURL;
    
    if (urlString) {
        [cell.userIconImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    cell.typeLabel.text = self.output.sportName;
    cell.lineView.backgroundColor = self.output.lineColor;
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 132.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 132.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

#pragma mark - ProUserEditProfileLogoInfoTableViewCellOutput

- (void)userIconDidTap {
    [self.output userIconDidTap];
}

@end
