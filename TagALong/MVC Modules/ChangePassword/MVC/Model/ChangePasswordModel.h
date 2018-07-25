//
//  ChangePasswordModel.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordModuleProtocols.h"

@interface ChangePasswordModel : NSObject <ChangePasswordModelInput>

- (instancetype)initWithOutput:(id<ChangePasswordModelOutput>)output;

@end
