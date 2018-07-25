//
//  ChangePasswordTableViewCell.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordTableViewCellOutput.h"

@interface ChangePasswordTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *showPasswordButton;

@property (nonatomic, weak) id <ChangePasswordTableViewCellOutput> output;

- (void)updateApperance;

@end
