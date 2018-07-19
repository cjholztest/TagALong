//
//  ProUserEditProfileLogoInfoTableViewCell.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProUserEditProfileLogoInfoTableViewCellOutput.h"

@interface ProUserEditProfileLogoInfoTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *lineView;
@property (nonatomic, weak) IBOutlet UILabel *typeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *userIconImageView;

@property (nonatomic, weak) id <ProUserEditProfileLogoInfoTableViewCellOutput> output;

@end
