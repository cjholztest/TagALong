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

- (void)loadCardList {
    [self reloadCardListWithResponseCards:nil];
    [self.output cardListDidLoad];
    
    // bellow code will need after backend changes
//    __weak typeof(self)weakSelf = self;
//    [[PaymentClient shared] listOfCrediCardsWithCompletion:^(id object, NSError *error) {
//        if (error) {
//
//        } else {
//
//        }
//        [weakSelf.output cardListDidLoad];
//    }];
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
    NSArray *cardsLastNumbers = @[@"4242", @"4444"];
    NSMutableArray *viewModels = [NSMutableArray array];
    for (NSInteger i = 0; i < cardsLastNumbers.count; i++) {
        CreditCardTableViewCellViewModel *viewModel = [CreditCardTableViewCellViewModel new];
        viewModel.lastNumbers = [NSString stringWithFormat:@"**** %@", cardsLastNumbers[i]];
        viewModel.isSelected = NO;
        [viewModels addObject:viewModel];
    }
    if (viewModels.count > 0) {
        self.cardList = viewModels;
    }
}

@end
