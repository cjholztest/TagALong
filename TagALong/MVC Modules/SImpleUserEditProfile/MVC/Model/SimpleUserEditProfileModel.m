//
//  SImpleUserEditProfileModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileModel.h"
#import "PaymentClient+CreditCard.h"

@interface SimpleUserEditProfileModel()

@property (nonatomic, weak) id <SimpleUserEditProfileModelOutput> output;

@end

@implementation SimpleUserEditProfileModel

- (instancetype)initWithOutput:(id<SimpleUserEditProfileModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SimpleUserEditProfileModelInput

- (void)loadCrediCardsWithCompletion:(void(^)(NSArray *cards))completion {
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        
        if (completion) {
            completion(cards);
        }
        
    }];
}

- (void)loadCrediCards {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        NSString *cardInfo = @"no debit";
        
        if (cards.count != 0) {
            NSDictionary *card = cards.firstObject;
            cardInfo = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
        }
        
        [weakSelf.output creditCardsDidLoadSuccess:(error == nil) cardInfo:cardInfo];        
    }];
}

#pragma mark - Private

@end
