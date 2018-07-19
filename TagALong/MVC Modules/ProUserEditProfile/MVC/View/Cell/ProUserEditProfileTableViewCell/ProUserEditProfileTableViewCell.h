//
//  ProUserEditProfileTableViewCell.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProUserEditProfileTableViewCellOutput.h"

@interface ProUserEditProfileTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, weak) id <ProUserEditProfileTableViewCellOutput> output;

@end
