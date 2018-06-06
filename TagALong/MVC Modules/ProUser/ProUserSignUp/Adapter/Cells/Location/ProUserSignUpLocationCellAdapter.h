//
//  ProUserSignUpLocationCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpLocationCellAdapterOutput.h"

@interface ProUserSignUpLocationCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpLocationCellAdapterOutput>)output;

@end
