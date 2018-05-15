//
//  SubmitOfferAdditionalInfoTableViewCell.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"

@interface SubmitOfferAdditionalInfoTableViewCell : SubmitOfferBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextView *additionalInfoTextView;

@property (nonatomic, weak) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *additionalTextViewLayoutConstraint;

- (void)updateTextViewAppearance;

@end
