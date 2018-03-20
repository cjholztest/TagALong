//
//  AddCreditCardModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddCreditCardProtocols.h"

@interface AddCreditCardModel : NSObject <AddCreditCardModelInput>

@property (nonatomic, weak) id <AddCreditCardModelOutput> output;

@end
