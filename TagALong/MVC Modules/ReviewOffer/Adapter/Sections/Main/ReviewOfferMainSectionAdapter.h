//
//  ReviewOfferMainSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewOfferMainSectionAdapterOutput.h"
#import "ReviewOfferSectionAdapter.h"

@interface ReviewOfferMainSectionAdapter : NSObject

- (instancetype)initWithOutput:(id<ReviewOfferMainSectionAdapterOutput>)output;

@end
