//
//  ProUserEditProfileMainSectionAdapter.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileSectionAdapter.h"
#import "ProUserEditProfileCellAdapter.h"

@interface ProUserEditProfileMainSectionAdapter : NSObject <ProUserEditProfileSectionAdapter>

@property (nonatomic, strong) NSArray <ProUserEditProfileCellAdapter> *cellAdapters;

@end
