//
//  NoContentSectionAdapter.h
//  TagALong
//
//  Created by User on 6/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoContentSectionAdapterOutput.h"
#import "ProsSectionAdapter.h"

@interface NoContentSectionAdapter : NSObject <ProsSectionAdapter>

- (instancetype)initWithOutput:(id<NoContentSectionAdapterOutput>)output;

@end
