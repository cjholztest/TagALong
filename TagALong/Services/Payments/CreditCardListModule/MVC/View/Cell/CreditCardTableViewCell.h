//
//  CreditCardTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditCardTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *cardNumberLabel;

- (void)updateWithModel:(id)model;

@end
