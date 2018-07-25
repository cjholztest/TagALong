//
//  TermsPrivacyTableViewCellOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TermsPrivacyTableViewCellOutput <NSObject>

- (void)termsDidTap;
- (void)privacyDidTap;
- (void)iAcceptDidTap;

@end
