//
//  SImpleUserEditProfileViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"
#import "SImpleUserEditProfileModuleProtocols.h"

@interface SimpleUserEditProfileViewController : BaseViewController <SimpleUserEditProfileModuleInput>

@property (nonatomic, weak) id <SimpleUserEditProfileModuleOutput> moduleOutput;

@end
