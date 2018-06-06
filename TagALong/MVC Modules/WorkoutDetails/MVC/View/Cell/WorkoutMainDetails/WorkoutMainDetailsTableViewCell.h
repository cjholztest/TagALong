//
//  WorkoutMainDetailsTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"

@class WorkoutMainDetailsTableViewCellDisplayModel;

@interface WorkoutMainDetailsTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

- (void)setupWithDisplayModel:(WorkoutMainDetailsTableViewCellDisplayModel*)displayModel;

@end
