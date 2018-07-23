//
//  ProsFilterModel.h
//  TagALong
//
//  Created by User on 7/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProsFilterModuleProtocols.h"

@interface ProsFilterModel : NSObject <ProsFilterModelInput>

- (instancetype)initWithOutput:(id<ProsFilterModelOutput>)output;

@end
