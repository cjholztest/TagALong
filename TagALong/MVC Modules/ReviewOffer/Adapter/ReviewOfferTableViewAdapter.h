//
//  ReviewOfferTableViewAdapter.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewOfferTableViewAdapterInput.h"
#import "SubmitOfferSectionAdapter.h"

@interface ReviewOfferTableViewAdapter : NSObject <ReviewOfferTableViewAdapterInput>

@property (nonatomic, strong) NSMutableArray <SubmitOfferSectionAdapter> *sectionAdapters;

@end
