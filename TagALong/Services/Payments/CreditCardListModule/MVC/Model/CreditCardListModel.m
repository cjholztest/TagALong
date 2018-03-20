//
//  CreditCardListModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CreditCardListModel.h"
#import "CreditCardTableViewCellViewModel.h"
#import "PaymentClient.h"

@interface CreditCardListModel ()

@property (nonatomic, strong) NSMutableArray *cardList;

@end

@implementation CreditCardListModel

#pragma mark - CreditCardListModelInput

- (NSInteger)cardsCount {
    return self.cardList.count;
}

- (CreditCardTableViewCellViewModel*)cardViewModelAtIndex:(NSInteger)index {
    return self.cardList[index];
}

- (void)loadCardList {
    __weak typeof(self)weakSelf = self;
    [[PaymentClient shared] listOfCrediCardsWithCompletion:^(id object, NSError *error) {
        if (error) {
            
        } else {
            
        }
        [weakSelf.output cardListDidLoad];
    }];
}

@end
