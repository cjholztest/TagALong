//
//  ProUserSignUpAddressCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpAddressCellAdapterOutput <NSObject>

- (void)addressDidChange:(NSString*)address;
- (NSString*)address;

@end
