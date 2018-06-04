//
//  ProUserSignUpLocationCellAdapter.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpLocationCellAdapter.h"
#import "ProUserSignUpInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpLocationCellAdapter()

@property (nonatomic, weak) id <ProUserSignUpLocationCellAdapterOutput> output;

@end

@implementation ProUserSignUpLocationCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpLocationCellAdapterOutput>)output {
    if (self = [super init]) {
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
    
    BOOL isUserLocationSelected = [self.output userLocationSelected];
    
    if (isUserLocationSelected) {
        cell.infoLabel.text = @"Location is Set. Tap to Show...";
        cell.infoLabel.textColor = [UIColor textColor];
    } else {
        cell.infoLabel.text = @"Location...";
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
    if ([self.output respondsToSelector:@selector(locationDidTapAtIndexPath:)]) {
        [self.output locationDidTapAtIndexPath:indexPath];
    }
}

@end
