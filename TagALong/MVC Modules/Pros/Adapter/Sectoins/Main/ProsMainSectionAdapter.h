//
//  ProsMainSectionAdapter.h
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProsMainSectionAdapterOutput.h"
#import "ProsSectionAdapter.h"

@interface ProsMainSectionAdapter : NSObject <ProsSectionAdapter>

- (instancetype)initWithOutput:(id<ProsMainSectionAdapterOutput>)output;

@end
