//
//  CreditCardListProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NoneCardListType,
    RegularUserCreditCardListType,
    ProUserCreditCardListType,
    ProUserDebitCardListType
} CardListType;

@protocol CreditCardListModelInput <NSObject>

- (void)loadRegularUserCreditCardList;
- (void)loadProUserCreditCardList;
- (void)loadProUserDebittCardList;

- (void)cardSetSelected:(BOOL)isSelected atIndexPath:(NSIndexPath*)indexPath;

- (NSInteger)cardsCount;
- (id)cardViewModelAtIndex:(NSInteger)index;
- (NSIndexPath*)selectedIndexPath;

@end

@protocol CreditCardListModelOutput <NSObject>

- (void)cardListDidLoad;
- (void)cardListDidLoadWithError:(NSString*)errorMessage;

@end

@protocol CreditCardListUserInterfaceInput <NSObject>

- (void)addCreditCardDidTap;

@end

@protocol CreditCardListUserInterfaceOutput <NSObject>

@end

@protocol CreditCardListModuleDelegate <NSObject>

@end
