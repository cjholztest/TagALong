//
//  ProUserSignUpTableViewAdapter.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpSectionAdapter.h"
#import "ProUserSignUpTableViewAdapterInput.h"

@interface ProUserSignUpTableViewAdapter : NSObject <ProUserSignUpTableViewAdapterInput>

@property (nonatomic, strong) NSArray<ProUserSignUpSectionAdapter> *sectionAdapters;

@end
