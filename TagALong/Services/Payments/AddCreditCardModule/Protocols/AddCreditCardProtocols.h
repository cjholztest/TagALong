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
- (void)createCreditCardForProUserWithCardParams:(STPCardParams*)cardParams;
- (void)passwordDidEnter:(NSString*)password;

- (BOOL)isUserPasswordEntered;

@end

@protocol AddCreditCardModelOutput <NSObject>

- (void)creditCardDidCreateWithError:(NSError*)error;

@end

@protocol AddCreditCardUserInterfaceInput <NSObject>

- (void)addCreditCardDidTap;

@optional
- (void)skipDidTap;

@end

@protocol AddCreditCardUserInterfaceOutput <NSObject>

@end

@protocol AddCreditCardModuleDelegate <NSObject>

@optional
- (void)creditCardDidAdd;
- (void)skipAddCreditCard;

@end
