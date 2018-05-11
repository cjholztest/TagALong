//
//  ProsMainSectionAdapter.m
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsMainSectionAdapter.h"
#import "UIView+Nib.h"
#import "ProsTableViewCell.h"
#import "ProsTableViewCellDisplayModel.h"

@interface ProsMainSectionAdapter()

@property (nonatomic, weak) id <ProsMainSectionAdapterOutput> output;

@end

@implementation ProsMainSectionAdapter

- (instancetype)initWithOutput:(id<ProsMainSectionAdapterOutput>)output {
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
    return [self.output rowsCount];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    ProsTableViewCell *cell = (ProsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProsTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    ProsTableViewCellDisplayModel *displayModel = [self.output rowDisplayModelAtIndexPath:indexPath];
    [cell setupWithDisplayModel:displayModel];
    
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
