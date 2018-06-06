//
//  ProUserSignUpView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProUserSignUpModuleProtocols.h"

@interface ProUserSignUpView : UIView <ProUserSignUpViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *registerButton;

@property (nonatomic, weak) id <ProUserSignUpViewOutput> output;

@end
