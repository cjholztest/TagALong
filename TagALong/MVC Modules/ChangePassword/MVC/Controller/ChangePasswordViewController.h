//
//  ChangePasswordViewController.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "BaseViewController.h"
#import "ChangePasswordModuleProtocols.h"

@interface ChangePasswordViewController : BaseViewController <ChangePasswordModuleInput>

@property (nonatomic, weak) id <ChangePasswordModelOutput> moduleOutput;

@end
