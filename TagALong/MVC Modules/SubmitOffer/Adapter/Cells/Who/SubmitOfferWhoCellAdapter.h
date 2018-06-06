//
//  SubmitOfferWhoCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferCellAdapter.h"
#import "SubmitOfferWhoCellAdapterOutput.h"

@interface SubmitOfferWhoCellAdapter : NSObject <SubmitOfferCellAdapter>

- (instancetype)initWithOutput:(id<SubmitOfferWhoCellAdapterOutput>)output;

@end
