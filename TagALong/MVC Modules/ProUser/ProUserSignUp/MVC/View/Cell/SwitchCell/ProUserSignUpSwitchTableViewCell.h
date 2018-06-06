//
//  ProUserSignUpSwitchTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProSignUpBaseTableViewCell.h"
#import "ProUserSignUpSwitchTableViewCellOutput.h"

@interface ProUserSignUpSwitchTableViewCell : ProSignUpBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UISwitch *switcher;

@property (nonatomic, weak) id <ProUserSignUpSwitchTableViewCellOutput> output;

@end
