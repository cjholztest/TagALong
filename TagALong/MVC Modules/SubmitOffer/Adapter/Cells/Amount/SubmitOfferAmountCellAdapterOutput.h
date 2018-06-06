//
//  SubmitOfferAmountCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferAmountCellAdapterOutput <NSObject>

- (void)amountCellDidTap;
- (void)amountDidChange:(NSString*)amount;
- (NSString*)amount;

@end
