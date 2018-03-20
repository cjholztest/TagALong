//
//  CreditCardListView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardListProtocols.h"

@interface CreditCardListView : UIView <CreditCardListUserInterfaceOutput>

@property (nonatomic, weak) IBOutlet UITableView *tebleView;
@property (nonatomic, weak) IBOutlet UIButton *addCreditCardButton;

@property (nonatomic, weak) id <CreditCardListUserInterfaceInput> eventHandler;

@end
