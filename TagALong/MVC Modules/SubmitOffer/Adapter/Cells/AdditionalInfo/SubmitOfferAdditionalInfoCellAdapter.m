//
//  SubmitOfferAdditionalInfoCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAdditionalInfoCellAdapter.h"
#import "SubmitOfferAdditionalInfoTableViewCell.h"
#import "UIView+Nib.h"

@interface SubmitOfferAdditionalInfoCellAdapter()

@property (nonatomic, weak) id <SubmitOfferAdditionalInfoCellAdapterOutput> output;

@end

@implementation SubmitOfferAdditionalInfoCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferAdditionalInfoCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferAdditionalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferAdditionalInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferAdditionalInfoTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferAdditionalInfoTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
