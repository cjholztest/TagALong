//
//  OldPasswordCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OldPasswordCellAdapterOutput <NSObject>

- (void)oldPasswordDidChange:(NSString*)oldPassword;
- (NSString*)oldPassword;

@end
