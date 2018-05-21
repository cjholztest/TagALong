//
//  ProUserSignUpRegisterCellAdapter.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpRegisterCellAdapter.h"
#import "ButtonTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpRegisterCellAdapter()

@property (nonatomic, weak) id <ProUserSignUpRegisterCellAdapterOutput> output;

@end

@implementation ProUserSignUpRegisterCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpRegisterCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ButtonTableViewCell.viewNib forCellReuseIdentifier:ButtonTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ButtonTableViewCell *cell = (ButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ButtonTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 60.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 60.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

#pragma mark - ButtonTableViewCellOutput

- (void)textDidChange:(NSString*)text {
    //    if ([self.output respondsToSelector:@selector(addressDidChange:)]) {
    //        [self.output addressDidChange:text];
    //    }
}

@end
