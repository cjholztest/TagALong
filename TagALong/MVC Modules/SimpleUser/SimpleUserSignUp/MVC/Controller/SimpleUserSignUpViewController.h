//
//  SimpleUserSignUpViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"
#import "SimpleUserSignUpModuleProtocols.h"

@interface SimpleUserSignUpViewController : BaseViewController <SimpleUserSignUpModuleInput>

@property (nonatomic, weak) id <SimpleUserSignUpModuleOutput> moduleOutput;

@end
