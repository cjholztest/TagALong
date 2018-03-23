//
//  PaymentClient+CreditCard.h
//  TagALong
//
//  Created by User on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"

@interface PaymentClient (CreditCard)

+ (void)sendCardToken:(NSString*)token isExpertUser:(BOOL)isExpertUser completion:(PaymentCompletion)paymentCompletion;
+ (void)listOfCrediCardsForUser:(BOOL)isExpertUser completion:(PaymentCompletion)paymentCompletion;

@end
