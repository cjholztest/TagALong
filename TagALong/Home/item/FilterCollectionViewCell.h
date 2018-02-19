//
//  FilterCollectionViewCell.h
//  TagALong
//
//  Created by PJH on 8/9/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *ivCheck;
@property (weak, nonatomic) IBOutlet UIView *vwBG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcNameLeft;
@property (weak, nonatomic) IBOutlet UIButton *bnBG;

@end
