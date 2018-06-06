//
//  ProUserSignUpSportCellAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpSportCellAdapter.h"
#import "ProUserSignUpInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpSportCellAdapter()

@property (nonatomic, weak) id <ProUserSignUpSportCellAdapterOutput> output;

@end

@implementation ProUserSignUpSportCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpSportCellAdapterOutput>)output {
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
    
    NSString *sport = [self.output kindOfSport];
    
    if (sport) {
        cell.infoLabel.text = sport;
        cell.infoLabel.textColor = [UIColor textColor];
    } else {
        cell.infoLabel.text = @"Select Kind of Sport";
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
    if ([self.output respondsToSelector:@selector(sportCellDidTap)]) {
        [self.output sportCellDidTap];
    }
}

@end
