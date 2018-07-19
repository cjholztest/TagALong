//
//  ProUserEditProfilePhoneNumberCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfilePhoneNumberCellAdapterOutput <NSObject>

- (void)phoneNumberDidChange:(NSString*)phone;
- (NSString*)phoneNumber;

@end
