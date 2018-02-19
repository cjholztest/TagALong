//
//  SportsListTableViewCell.h
//  TagALong
//
//  Created by PJH on 9/13/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIControl *vwBG;
@property (weak, nonatomic) IBOutlet UIImageView *ivSport;
@property (weak, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSportName;
@property (strong, nonatomic) IBOutlet UIButton *bnProfile;
@property (weak, nonatomic) IBOutlet UIImageView *ivArrow;
@end
