//
//  ProUserSignUpViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"
#import "ProUserSignUpModuleProtocols.h"

@interface ProUserSignUpViewController : BaseViewController <ProUserSignUpModuleInput>

@property (nonatomic, weak) id <ProUserSignUpModuleOutput> moduleOutput;

@end
