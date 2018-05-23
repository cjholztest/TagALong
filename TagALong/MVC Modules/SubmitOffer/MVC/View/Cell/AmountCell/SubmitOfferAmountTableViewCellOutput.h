//
//  SubmitOfferAmountTableViewCellOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferAmountTableViewCellOutput <NSObject>

- (void)amountValueDidChange:(NSString*)amount;

@end
