//
//  ProUserSignUpModel.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpModuleProtocols.h"

@interface ProUserSignUpModel : NSObject <ProUserSignUpModelInput>

- (instancetype)initWithOutput:(id<ProUserSignUpModelOutput>)output;

@end
