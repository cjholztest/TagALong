//
//  SubmitOfferAmountTableViewCell.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"
#import "SubmitOfferAmountTableViewCellOutput.h"

@interface SubmitOfferAmountTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *amountTextField;

@property (nonatomic, weak) id <SubmitOfferAmountTableViewCellOutput> output;

@end
