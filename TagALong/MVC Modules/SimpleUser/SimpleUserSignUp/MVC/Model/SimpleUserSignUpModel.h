//
//  SimpleUserSignUpModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleUserSignUpModuleProtocols.h"

@interface SimpleUserSignUpModel : NSObject <SimpleUserSignUpModelInput>

- (instancetype)initWithOutput:(id<SimpleUserSignUpModelOutput>)output;

@end
