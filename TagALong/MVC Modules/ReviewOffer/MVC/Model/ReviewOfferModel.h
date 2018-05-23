//
//  ReviewOfferModel.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewOfferModuleProtocols.h"

@interface ReviewOfferModel : NSObject <ReviewOfferModelInput>

- (instancetype)initWithOutput:(id<ReviewOfferModelOutput>)output;

@end
