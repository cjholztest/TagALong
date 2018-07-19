//
//  ProUserEditProfileTableVIewAdapter.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileTableVIewAdapterInput.h"
#import "ProUserEditProfileSectionAdapter.h"

@interface ProUserEditProfileTableVIewAdapter : NSObject <ProUserEditProfileTableVIewAdapterInput>

@property (nonatomic, strong) NSArray <ProUserEditProfileSectionAdapter> *sectionAdapters;

@end
