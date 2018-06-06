//
//  ProUserProfileViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProUserProfileModuleProtocols.h"

@interface ProUserProfileViewController : UIViewController <ProUserProfileModuleInput>

@property (nonatomic, weak) id <ProUserProfileModuleOutput> output;

@end
