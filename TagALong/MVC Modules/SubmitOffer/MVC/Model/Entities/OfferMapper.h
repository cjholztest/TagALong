//
//  OfferMapper.h
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OfferDataModel, AthleteDataModel;

@interface OfferMapper : NSObject

+ (NSDictionary*)jsonFromOffer:(OfferDataModel*)offer;

@end
