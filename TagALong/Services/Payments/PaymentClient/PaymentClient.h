//
//  PaymentClient.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentClient : NSObject

+ (PaymentClient*)shared;

- (void)createCustomerKeyWithApiVersion:(NSString*)apiVersion completion:(void(^)(id object))completion;
- (void)sendCardToken:(NSString*)token completion:(void(^)(id object))completion;

- (void)listOfCrediCardsWithCompletion:(void(^)(id object, NSError *error))completion;

@end
