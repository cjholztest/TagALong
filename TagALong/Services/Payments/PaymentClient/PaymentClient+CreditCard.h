//
//  PaymentClient+CreditCard.h
//  TagALong
//
//  Created by User on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"

@interface PaymentClient (CreditCard)

+ (void)sendCardToken:(NSString*)token password:(NSString*)password completion:(PaymentCompletion)paymentCompletion;
+ (void)listOfCrediCardsWithCompletion:(PaymentCompletion)paymentCompletion;

@end
