//
//  ReviewOfferViewController.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewOfferModuleProtocols.h"

@interface ReviewOfferViewController : UIViewController <ReviewOfferModuleInput>

@property (nonatomic, weak) id <ReviewOfferModuleOutput> moduleOutput;

@end
