//
//  AthleteInfoView.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthleteInfoProtocols.h"

@interface AthleteInfoView : UIView <AthleteInfoViewInput>

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic, weak) IBOutlet UIButton *tagALongLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, weak) id <AthleteInfoViewOutput> output;

@end