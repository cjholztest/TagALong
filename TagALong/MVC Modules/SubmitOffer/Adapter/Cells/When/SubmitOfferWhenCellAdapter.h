//
//  SubmitOfferWhenCellAdapter.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferCellAdapter.h"
#import "SubmitOfferWhenCellAdapterOutput.h"

@interface SubmitOfferWhenCellAdapter : NSObject <SubmitOfferCellAdapter>

- (instancetype)initWithOutput:(id<SubmitOfferWhenCellAdapterOutput>)output;

@end
