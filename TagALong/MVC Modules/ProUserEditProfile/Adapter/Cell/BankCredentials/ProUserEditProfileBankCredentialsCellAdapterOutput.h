//
//  ProUserEditProfileBankCredentialsCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileBankCredentialsCellAdapterOutput <NSObject>

- (void)bankCredentialsDidTap;
- (NSString*)bankCredentialsData;

- (void)loadBankCredentialsInfoWithComplation:(void(^)(NSString *result))completion;

@end
