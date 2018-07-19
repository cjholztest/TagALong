//
//  ProUserEditProfileModel.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileModuleProtocols.h"

@interface ProUserEditProfileModel : NSObject <ProUserEditProfileModelInput>

- (instancetype)initWithOutput:(id<ProUserEditProfileModelOutput>)output;

@end
