//
//  ProUserSignUpLastNameCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpLastNameCellAdapterOutput <NSObject>

- (void)lastNameDidChange:(NSString*)lastName;
- (NSString*)lastName;

@end
