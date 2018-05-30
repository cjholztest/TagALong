//
//  WorkoutAdditionalDetailsTableViewCell.h
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"

@class WorkoutAdditionalDetailsTableViewCellDisplayModel;

@interface WorkoutAdditionalDetailsTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

- (void)setupWithDisplayModel:(WorkoutAdditionalDetailsTableViewCellDisplayModel*)displayModel;

@end
