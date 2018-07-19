//
//  ProUserEditProfileCreditCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileCreditCellAdapterOutput <NSObject>

- (void)creditDidTap;
- (NSString*)creditData;

- (void)loadCreditInfoWithCompletion:(void(^)(NSString *result))completion;

@end
