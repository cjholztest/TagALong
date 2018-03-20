//
//  AddCreditCardViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCreditCardProtocols.h"

@interface AddCreditCardViewController : UIViewController

@property (nonatomic, weak) id <AddCreditCardModuleDelegate> moduleDelegate;

@end
