//
//  SubmitOfferViewController.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitOfferProtocols.h"

@interface SubmitOfferViewController : UIViewController <SubmitOfferModuleInput>

@property (nonatomic, weak) id <SubmitOfferModuleOutput> moduleOutput;

@end
