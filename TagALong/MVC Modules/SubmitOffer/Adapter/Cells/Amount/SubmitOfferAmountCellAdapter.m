//
//  SubmitOfferAmountCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAmountCellAdapter.h"
#import "SubmitOfferAmountTableViewCell.h"
#import "UIView+Nib.h"

@interface SubmitOfferAmountCellAdapter()

@property (nonatomic, weak) id <SubmitOfferAmountCellAdapterOutput> output;

@end

@implementation SubmitOfferAmountCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferAmountCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferAmountTableViewCell.reuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferAmountTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferAmountTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
