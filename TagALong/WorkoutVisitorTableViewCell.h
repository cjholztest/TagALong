//
//  WorkoutVisitorTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"

@interface WorkoutVisitorTableViewCell : SubmitOfferBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *isPaidLabel;

@end
