//
//  ChangePasswordTableViewAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordTableViewAdapterInput.h"
#import "ChangePasswordSectionAdapter.h"

@interface ChangePasswordTableViewAdapter : NSObject <ChangePasswordTableViewAdapterInput>

@property (nonatomic, strong) NSArray <ChangePasswordSectionAdapter> *sectionAdapters;

@end
