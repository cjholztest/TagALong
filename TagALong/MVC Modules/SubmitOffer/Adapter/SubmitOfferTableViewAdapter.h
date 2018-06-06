//
//  SubmitOfferTableViewAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmitOfferTableViewAdapterInput.h"
#import "SubmitOfferSectionAdapter.h"

@interface SubmitOfferTableViewAdapter : NSObject <SubmitOfferTableViewAdapterInput>

@property (nonatomic, strong) NSMutableArray <SubmitOfferSectionAdapter> *sectionAdapters;

@end
