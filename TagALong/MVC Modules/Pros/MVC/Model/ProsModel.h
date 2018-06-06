//
//  ProsModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProsModuleProtocols.h"

@interface ProsModel : NSObject <ProsModelInput, ProsModelDataSource>

- (instancetype)initWithOutput:(id<ProsModelOutput>)output;

@end
