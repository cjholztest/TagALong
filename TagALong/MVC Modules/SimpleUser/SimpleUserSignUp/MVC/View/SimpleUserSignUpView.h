//
//  SimpleUserSignUpView.h
//  TagALong
//
//  Created by User on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleUserSignUpModuleProtocols.h"

@interface SimpleUserSignUpView : UIView <SimpleUserSignUpViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *signUpButton;

@property (nonatomic, weak) id <SimpleUserSignUpViewOutput> output;

@end
