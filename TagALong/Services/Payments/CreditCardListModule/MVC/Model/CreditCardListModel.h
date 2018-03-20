//
//  CreditCardListModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditCardListProtocols.h"

@interface CreditCardListModel : NSObject <CreditCardListModelInput>

@property (nonatomic, weak) id <CreditCardListModelOutput> output;

@end
