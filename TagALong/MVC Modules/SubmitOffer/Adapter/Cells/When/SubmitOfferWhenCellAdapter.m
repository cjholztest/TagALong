//
//  SubmitOfferWhenCellAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhenCellAdapter.h"
#import "SubmitOfferWhenTableViewCell.h"
#import "UIColor+AppColors.h"
#import "UIView+Nib.h"

@interface SubmitOfferWhenCellAdapter() <SubmitOfferWhenTableViewCellOutput>

@property (nonatomic, weak) id <SubmitOfferWhenCellAdapterOutput> output;

@end

@implementation SubmitOfferWhenCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferWhenCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferWhenTableViewCell *cell = (SubmitOfferWhenTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferWhenTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    NSDate *date = [self.output date];
    NSString *time = [self.output time];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    if (date) {
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        cell.dateLabel.text = [dateFormatter stringFromDate:date];
        cell.dateLabel.textColor = [UIColor textColor];
    } else {
        cell.dateLabel.text = @"Date";
        cell.dateLabel.textColor = [UIColor placeholderColor];
    }
    
    if (time) {
        cell.timeLabel.text = time;
        cell.timeLabel.textColor = [UIColor textColor];
    } else {
        cell.timeLabel.text = @"Time";
        cell.timeLabel.textColor = [UIColor placeholderColor];
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
    [tableView registerNib:SubmitOfferWhenTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferWhenTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(whenCellDidTap)]) {
        [self.output whenCellDidTap];
    }
}

#pragma mark - SubmitOfferWhenTableViewCellOutput

- (void)dateDidTap {
    if ([self.output respondsToSelector:@selector(dateDidTap)]) {
        [self.output dateDidTap];
    }
}

- (void)timeDidTap {
    if ([self.output respondsToSelector:@selector(timeDidTap)]) {
        [self.output timeDidTap];
    }
}

@end
