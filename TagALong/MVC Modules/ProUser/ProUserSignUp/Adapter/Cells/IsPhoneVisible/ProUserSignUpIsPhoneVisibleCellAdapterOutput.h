//
//  ProUserSignUpIsPhoneVisibleCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpIsPhoneVisibleCellAdapterOutput <NSObject>

- (void)isPhoneVisibleStateDidChange:(BOOL)isVisible;
- (BOOL)isPhoneVisible;

@end
