//
//  SubmitOfferWhoTableViewCell.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"
#import "SubmitOfferWhoTableViewCellOutput.h"

@interface SubmitOfferWhoTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *whoTextField;

@property (nonatomic, weak) id <SubmitOfferWhoTableViewCellOutput> output;

@end
