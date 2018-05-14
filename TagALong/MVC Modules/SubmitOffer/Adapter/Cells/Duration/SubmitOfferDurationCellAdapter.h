//
//  SubmitOfferDurationCellAdapter.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferCellAdapter.h"
#import "SubmitOfferDurationCellAdapterOutput.h"

@interface SubmitOfferDurationCellAdapter : NSObject <SubmitOfferCellAdapter>

- (instancetype)initWithOutput:(id<SubmitOfferDurationCellAdapterOutput>)output;

@end
