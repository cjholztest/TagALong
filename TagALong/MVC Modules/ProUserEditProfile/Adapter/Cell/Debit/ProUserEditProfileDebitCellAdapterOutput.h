//
//  ProUserEditProfileDebitCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileDebitCellAdapterOutput <NSObject>

- (void)debitDidTap;
- (NSString*)debitData;

- (void)loadDebitInfoWithCompletion:(void(^)(NSString *result))completion;

@end
