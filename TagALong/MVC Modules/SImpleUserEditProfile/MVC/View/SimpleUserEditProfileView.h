//
//  SImpleUserEditProfileView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleUserEditProfileModuleProtocols.h"

@interface SimpleUserEditProfileView : UIView

@property (nonatomic, weak) IBOutlet UILabel *creditCardLabel;
@property (nonatomic, weak) IBOutlet UIButton *creditCardEditButton;

@property (nonatomic, weak) IBOutlet UISwitch *limitSwithch;
@property (nonatomic, weak) IBOutlet UIView *areaContentView;
@property (nonatomic, weak) IBOutlet UILabel *areaRadiusLabel;

@property (nonatomic, weak) IBOutlet UIImageView *profileIconImageView;

@property (nonatomic, weak) id <SimpleUserEditProfileViewOutput> output;

@end
