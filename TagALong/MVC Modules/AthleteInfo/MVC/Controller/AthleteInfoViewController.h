//
//  AthleteInfoViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthleteInfoProtocols.h"

@interface AthleteInfoViewController : UIViewController <AthleteInfoModuleInput>

@property (nonatomic, weak) id <AthleteInfoModuleOutput> moduleOutput;

@end
