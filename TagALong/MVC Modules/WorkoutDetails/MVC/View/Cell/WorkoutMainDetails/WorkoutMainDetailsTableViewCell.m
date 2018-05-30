//
//  WorkoutMainDetailsTableViewCell.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutMainDetailsTableViewCell.h"
#import "WorkoutMainDetailsTableViewCellDisplayModel.h"

@implementation WorkoutMainDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Public

- (void)setupWithDisplayModel:(WorkoutMainDetailsTableViewCellDisplayModel*)displayModel {
    
    self.titleLabel.text = displayModel.title;
    self.valueLabel.text = displayModel.text;
}

@end
