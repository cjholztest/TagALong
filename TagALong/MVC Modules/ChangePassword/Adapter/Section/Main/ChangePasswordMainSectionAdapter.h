//
//  ChangePasswordMainSectionAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordSectionAdapter.h"
#import "ChangePasswordCellAdapter.h"

@interface ChangePasswordMainSectionAdapter : NSObject <ChangePasswordSectionAdapter>

@property (nonatomic, strong) NSArray <ChangePasswordCellAdapter> *cellAdapters;

@end
