//
//  NoContentSectionAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NoContentSectionAdapter.h"
#import "UIView+Nib.h"
#import "ProsTableViewCell.h"
#import "ProsTableViewCellDisplayModel.h"

@interface NoContentSectionAdapter()

@property (nonatomic, weak) id <NoContentSectionAdapterOutput> output;

@end

@implementation NoContentSectionAdapter

- (instancetype)initWithOutput:(id<NoContentSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[ProsTableViewCell viewNib] forCellReuseIdentifier:[ProsTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return [self.output isNoContentVisible] ? 1 : 0;
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    ProsTableViewCell *cell = (ProsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProsTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    ProsTableViewCellDisplayModel *displayModel = [ProsTableViewCellDisplayModel new];
    displayModel.nameText = @"No Pro Athletes are in your area.";
    
    [cell setupWithDisplayModel:displayModel];
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 54.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 54.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {

}

@end
