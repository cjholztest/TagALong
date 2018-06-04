//
//  SimpleUserSignUpViewController.h
//  TagALong
//
//  Created by User on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleUserSignUpModuleProtocols.h"

@interface SimpleUserSignUpViewController : UIViewController <SimpleUserSignUpModuleInput>

@property (nonatomic, weak) id <SimpleUserSignUpModuleOutput> moduleOutput;

@end
