//
//  SubmitOfferWhenTableViewCell.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"
#import "SubmitOfferWhenTableViewCellOutput.h"

@interface SubmitOfferWhenTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) id <SubmitOfferWhenTableViewCellOutput> output;

@end
