//
//  OldPasswordCellAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordCellAdapter.h"
#import "OldPasswordCellAdapterOutput.h"

@interface OldPasswordCellAdapter : NSObject <ChangePasswordCellAdapter>

- (instancetype)initWithOutput:(id<OldPasswordCellAdapterOutput>)output;

@end
