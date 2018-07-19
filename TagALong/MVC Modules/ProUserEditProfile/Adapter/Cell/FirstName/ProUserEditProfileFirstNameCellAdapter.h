//
//  ProUserEditProfileFirstNameCellAdapter.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileFirstNameCellAdapterOutput.h"

@interface ProUserEditProfileFirstNameCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id<ProUserEditProfileFirstNameCellAdapterOutput>)output;

@end
