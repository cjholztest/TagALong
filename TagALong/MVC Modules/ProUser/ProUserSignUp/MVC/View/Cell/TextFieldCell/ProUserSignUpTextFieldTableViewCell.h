//
//  ProUserSignUpTextFieldTableViewCell.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProSignUpBaseTableViewCell.h"
#import "ProUserSignUpTextFieldTableViewCellOutput.h"

@interface ProUserSignUpTextFieldTableViewCell : ProSignUpBaseTableViewCell

@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, weak) id <ProUserSignUpTextFieldTableViewCellOutput> output;

@end
