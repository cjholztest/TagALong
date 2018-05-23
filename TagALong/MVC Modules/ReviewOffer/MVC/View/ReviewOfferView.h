//
//  ReviewOfferView.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewOfferModuleProtocols.h"

@interface ReviewOfferView : UIView <ReviewOfferViewInput>

@property (nonatomic, weak) IBOutlet UIImageView *userIconImageView;

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic, weak) IBOutlet UIButton *accpetButton;
@property (nonatomic, weak) IBOutlet UIButton *declineButton;

@property (nonatomic, weak) id <ReviewOfferViewOutput> output;

@end
