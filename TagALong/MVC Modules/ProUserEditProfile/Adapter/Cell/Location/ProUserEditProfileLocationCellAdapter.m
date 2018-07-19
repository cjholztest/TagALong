//
//  ProUserEditProfileLocationCellAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 7/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileLocationCellAdapter.h"
#import "ProUserEditProfilePaymentInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserEditProfileLocationCellAdapter()

@property (nonatomic, weak) id <ProUserEditProfileLocationCellAdapterOutput> output;

@end

@implementation ProUserEditProfileLocationCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileLocationCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserEditProfileCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserEditProfilePaymentInfoTableViewCell.viewNib forCellReuseIdentifier:ProUserEditProfilePaymentInfoTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserEditProfilePaymentInfoTableViewCell *cell = (ProUserEditProfilePaymentInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserEditProfilePaymentInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    BOOL isUserLocationSelected = [self.output userLocationSelected];
    
    if (isUserLocationSelected) {
        cell.titleLabel.text = @"Location is Set. Tap to Show...";
        cell.titleLabel.textColor = [UIColor textColor];
    } else {
        cell.titleLabel.text = @"Location...";
        cell.titleLabel.textColor = [UIColor placeholderColor];
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
    if ([self.output respondsToSelector:@selector(locationDidTapAtIndexPath:)]) {
        [self.output locationDidTapAtIndexPath:indexPath];
    }
}

@end
