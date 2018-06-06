//
//  ReviewOfferMapper.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReviewOfferDataModel;

@interface ReviewOfferMapper : NSObject

+ (ReviewOfferDataModel*)reviewOfferFromJSON:(NSDictionary*)json;

@end
