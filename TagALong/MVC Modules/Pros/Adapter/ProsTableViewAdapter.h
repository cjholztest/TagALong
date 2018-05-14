//
//  ProsTableViewAdapter.h
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProsTableViewAdapterInput.h"
#import "ProsSectionAdapter.h"

@interface ProsTableViewAdapter : NSObject <ProsTableViewAdapterInput>

@property (nonatomic, strong) NSMutableArray<ProsSectionAdapter> *sectionAdapters;

@end
