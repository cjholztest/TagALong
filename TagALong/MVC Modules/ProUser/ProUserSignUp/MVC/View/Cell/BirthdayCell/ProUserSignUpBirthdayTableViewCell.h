//
//  ProUserSignUpBirthdayTableViewCell.h
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProSignUpBaseTableViewCell.h"
#import "ProUserSignUpBirthdayTableViewCellOutput.h"

@interface ProUserSignUpBirthdayTableViewCell : ProSignUpBaseTableViewCell

@property (nonatomic, weak) IBOutlet UIButton *monthButton;
@property (nonatomic, weak) IBOutlet UIButton *yearButton;

@property (nonatomic, weak) id <ProUserSignUpBirthdayTableViewCellOutput> output;

@end
