//
//  ProUserEditProfileUserInfoCellAdapter.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileUserInfoCellAdapterOutput.h"

@interface ProUserEditProfileUserInfoCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id <ProUserEditProfileUserInfoCellAdapterOutput>)output;

@end
