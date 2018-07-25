//
//  ProUserEditProfileChangePasswordCellAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileChangePasswordCellAdapterOutput.h"

@interface ProUserEditProfileChangePasswordCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id<ProUserEditProfileChangePasswordCellAdapterOutput>)output;

@end
