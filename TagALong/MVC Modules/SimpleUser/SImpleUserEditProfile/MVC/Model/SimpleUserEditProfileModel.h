//
//  SImpleUserEditProfileModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SImpleUserEditProfileModuleProtocols.h"

@interface SimpleUserEditProfileModel : NSObject <SimpleUserEditProfileModelInput>

- (instancetype)initWithOutput:(id<SimpleUserEditProfileModelOutput>)output;

@end
