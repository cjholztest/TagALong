//
//  CreditCardListModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CreditCardListModel.h"
#import "CreditCardTableViewCellViewModel.h"
#import "PaymentClient+CreditCard.h"

@interface CreditCardListModel ()

@property (nonatomic, strong) NSArray *cardList;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation CreditCardListModel

#pragma mark - CreditCardListModelInput

- (NSInteger)cardsCount {
    return self.cardList.count;
}

- (CreditCardTableViewCellViewModel*)cardViewModelAtIndex:(NSInteger)index {
    return self.cardList[index];
}

- (void)loadCreditCardList {
    __weak typeof(self)weakSelf = self;
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        if (error) {
            [weakSelf.output cardListDidLoadWithError:error.localizedDescription];
        } else {
            [weakSelf reloadCardListWithResponseCards:responseObject];
            [weakSelf.output cardListDidLoad];
        }
    }];
}

- (void)loadDebitCardList {
    __weak typeof(self)weakSelf = self;
    [PaymentClient proUserCreditCardsWithCompletion:^(id responseObject, NSError *error) {
        if (error) {
            [weakSelf.output cardListDidLoadWithError:error.localizedDescription];
        } else {
            [weakSelf reloadCardListWithResponseCards:responseObject];
            [weakSelf.output cardListDidLoad];
        }
    }];
}

- (void)loadRegularUserCreditCardList {
    __weak typeof(self)weakSelf = self;
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        if (error) {
            [weakSelf.output cardListDidLoadWithError:error.localizedDescription];
        } else {
            [weakSelf reloadCardListWithResponseCards:responseObject];
            [weakSelf.output cardListDidLoad];
        }
    }];
}

- (void)loadProUserCreditCardList {
    __weak typeof(self)weakSelf = self;
    [PaymentClient proUserCreditCardsWithCompletion:^(id responseObject, NSError *error) {
        if (error) {
            [weakSelf.output cardListDidLoadWithError:error.localizedDescription];
        } else {
            [weakSelf reloadCardListWithResponseCards:responseObject];
            [weakSelf.output cardListDidLoad];
        }
    }];
}

- (void)loadProUserDebittCardList {
    __weak typeof(self)weakSelf = self;
    [PaymentClient proUserDebitCardsWithCompletion:^(id responseObject, NSError *error) {
        if (error) {
            [weakSelf.output cardListDidLoadWithError:error.localizedDescription];
        } else {
            [weakSelf reloadCardListWithResponseCards:responseObject];
            [weakSelf.output cardListDidLoad];
        }
    }];
}

- (void)cardSetSelected:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath {
    CreditCardTableViewCellViewModel *viewModel = self.cardList[indexPath.row];
    viewModel.isSelected = isSelected;
    if (isSelected) {
        self.lastSelectedIndexPath = indexPath;
    }
}

- (NSIndexPath*)selectedIndexPath {
    return self.lastSelectedIndexPath;
}

#pragma mark - Private

- (void)reloadCardListWithResponseCards:(NSArray*)respponseCards {
    // temp imitate respnse cards
    NSMutableArray *viewModels = [NSMutableArray array];
    for (NSInteger i = 0; i < respponseCards.count; i++) {
        NSDictionary *card = respponseCards[i];
        CreditCardTableViewCellViewModel *viewModel = [CreditCardTableViewCellViewModel new];
        viewModel.lastNumbers = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
        viewModel.isSelected = (i == 0);
        [viewModels addObject:viewModel];
    }
    if (viewModels.count > 0) {
        self.cardList = viewModels;
    }
}

@end
