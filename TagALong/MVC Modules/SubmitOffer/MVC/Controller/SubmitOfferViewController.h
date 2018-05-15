//
//  SubmitOfferViewController.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"
#import "SubmitOfferProtocols.h"

@interface SubmitOfferViewController : BaseViewController <SubmitOfferModuleInput>

@property (nonatomic, weak) id <SubmitOfferModuleOutput> moduleOutput;

@end
