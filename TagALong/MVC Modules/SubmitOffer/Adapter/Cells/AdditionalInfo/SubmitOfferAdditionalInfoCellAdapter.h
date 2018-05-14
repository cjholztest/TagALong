//
//  SubmitOfferAdditionalInfoCellAdapter.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferCellAdapter.h"
#import "SubmitOfferAdditionalInfoCellAdapterOutput.h"

@interface SubmitOfferAdditionalInfoCellAdapter : NSObject <SubmitOfferCellAdapter>

- (instancetype)initWithOutput:(id<SubmitOfferAdditionalInfoCellAdapterOutput>)output;

@end
