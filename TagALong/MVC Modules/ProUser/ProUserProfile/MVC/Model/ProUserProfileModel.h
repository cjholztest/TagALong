//
//  ProUserProfileModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserProfileModuleProtocols.h"

@interface ProUserProfileModel : NSObject <ProUserProfileModelInput>

- (instancetype)initWithOutput:(id<ProUserProfileModelOutput>)output;

@end
