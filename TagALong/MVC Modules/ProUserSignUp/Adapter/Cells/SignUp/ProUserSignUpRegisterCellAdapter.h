//
//  ProUserSignUpRegisterCellAdapter.h
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpRegisterCellAdapterOutput.h"

@interface ProUserSignUpRegisterCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpRegisterCellAdapterOutput>)output;

@end
