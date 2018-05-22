//
//  SubmitOfferWhoCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhoCellAdapter.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"
#import "UIView+Nib.h"
#import "SubmitOfferWhatTableViewCell.h"

@interface SubmitOfferWhoCellAdapter()

@property (nonatomic, weak) id <SubmitOfferWhoCellAdapterOutput> output;

@end

@implementation SubmitOfferWhoCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferWhoCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {

    SubmitOfferWhatTableViewCell *cell = (SubmitOfferWhatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferWhatTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    NSString *total = [self.output who];
    if (total.length > 0) {
        cell.optionLabel.text = total;
        cell.optionLabel.textColor = [UIColor textColor];
    } else {
        cell.optionLabel.text = @"Select Total # of People";
        cell.optionLabel.textColor = [UIColor placeholderColor];
    }
    

    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferWhatTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferWhatTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(whoCellDidTap)]) {
        [self.output whoCellDidTap];
    }
}

@end
