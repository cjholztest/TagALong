//
//  ProUserSignUpMainSectionAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpSectionAdapter.h"
#import "ProUserSignUpCellAdapter.h"

@interface ProUserSignUpMainSectionAdapter : NSObject <ProUserSignUpSectionAdapter>

@property (nonatomic, strong) NSArray <ProUserSignUpCellAdapter> *cellAdapters;

@end
