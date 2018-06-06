//
//  SubmitOfferMainSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferSectionAdapter.h"
#import "SubmitOfferCellAdapter.h"

@interface SubmitOfferMainSectionAdapter : NSObject <SubmitOfferSectionAdapter>

@property (nonatomic, strong) NSArray <SubmitOfferCellAdapter> *cellAdapters;

@end
