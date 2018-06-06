//
//  SubmitOfferModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferProtocols.h"

@interface SubmitOfferModel : NSObject <SubmitOfferModelInput>

- (instancetype)initWithOutput:(id<SubmitOfferModelOutput>)output;

@end
