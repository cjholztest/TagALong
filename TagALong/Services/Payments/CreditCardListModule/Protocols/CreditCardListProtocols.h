//
//  CreditCardListProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CreditCardListModelInput <NSObject>

- (void)loadCardList;

- (NSInteger)cardsCount;
- (id)cardViewModelAtIndex:(NSInteger)index;

@end

@protocol CreditCardListModelOutput <NSObject>

- (void)cardListDidLoad;

@end

@protocol CreditCardListUserInterfaceInput <NSObject>

- (void)addCreditCardDidTap;

@end

@protocol CreditCardListUserInterfaceOutput <NSObject>

@end

@protocol CreditCardListModuleDelegate <NSObject>

@end
