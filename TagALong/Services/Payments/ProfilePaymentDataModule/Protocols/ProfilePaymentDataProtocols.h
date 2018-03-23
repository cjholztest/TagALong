//
//  ProfilePaymentDataProtocols.h
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfilePaymentDataModelInput <NSObject>

- (void)updateValue:(NSString*)value forType:(NSInteger)type;

@end

@protocol ProfilePaymentDataModelOutput <NSObject>

@end

@protocol ProfilePaymentDataUserInterfaceInput <NSObject>

- (void)skipButtonDidTap;
- (void)sendDataButtonDidTap;

@end

@protocol ProfilePaymentDataUserInterfaceOutput <NSObject>

@end

@protocol ProfilePaymentDataModuleDelegate <NSObject>

@end
