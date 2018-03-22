//
//  AddCreditCardProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Stripe/Stripe.h>

@protocol AddCreditCardModelInput <NSObject>

- (void)createCreditCardWithCardParams:(STPCardParams*)cardParams;

@end

@protocol AddCreditCardModelOutput <NSObject>

- (void)creditCardDidCreateWithError:(NSError*)error;

@end

@protocol AddCreditCardUserInterfaceInput <NSObject>

- (void)addCreditCardDidTap;

@end

@protocol AddCreditCardUserInterfaceOutput <NSObject>

@end

@protocol AddCreditCardModuleDelegate <NSObject>

@end
