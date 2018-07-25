//
//  TermsPrivacyTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProSignUpBaseTableViewCell.h"
#import "TermsPrivacyTableViewCellOutput.h"

@interface TermsPrivacyTableViewCell : ProSignUpBaseTableViewCell

@property (nonatomic, weak) IBOutlet UIView *acceptActionView;
@property (nonatomic, weak) IBOutlet UIImageView *checkBoxImageView;

@property (nonatomic, weak) id <TermsPrivacyTableViewCellOutput> output;

@end
