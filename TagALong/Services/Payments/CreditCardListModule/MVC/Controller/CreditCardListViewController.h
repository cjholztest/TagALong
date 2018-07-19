//
//  CreditCardListViewController.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardListProtocols.h"

@interface CreditCardListViewController : UIViewController

@property (nonatomic, weak) id <CreditCardListModuleDelegate> moduleDelegate;

@property (nonatomic, assign) CardListType cardListType;

@end
