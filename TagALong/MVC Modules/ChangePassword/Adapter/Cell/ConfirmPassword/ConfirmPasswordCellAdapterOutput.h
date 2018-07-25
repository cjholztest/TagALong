//
//  ConfirmPasswordCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfirmPasswordCellAdapterOutput <NSObject>

- (void)cofirmPasswordDidChange:(NSString*)confirmPassword;
- (NSString*)confirmPassword;

@end
