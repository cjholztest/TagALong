//
//  SubmitOfferWhenTableViewCell.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhenTableViewCell.h"

@implementation SubmitOfferWhenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupActions];
}

- (void)setupActions {
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateLabelDidTap)];
    [self.dateLabel addGestureRecognizer:dateTap];
    
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeLabelDidTap)];
    [self.timeLabel addGestureRecognizer:timeTap];
}

#pragma mark - Actions

- (void)dateLabelDidTap {
    if ([self.output respondsToSelector:@selector(dateDidTap)]) {
        [self.output dateDidTap];
    }
}

- (void)timeLabelDidTap {
    if ([self.output respondsToSelector:@selector(timeDidTap)]) {
        [self.output timeDidTap];
    }
}

@end
