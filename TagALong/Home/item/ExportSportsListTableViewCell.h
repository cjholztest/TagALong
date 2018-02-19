//
//  ExportSportsListTableViewCell.h
//  TagALong
//
//  Created by PJH on 9/13/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExportSportsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwBG;
@property (weak, nonatomic) IBOutlet UIImageView *ivSport;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSportName;
@property (weak, nonatomic) IBOutlet UIImageView *ivArrow;
@end
