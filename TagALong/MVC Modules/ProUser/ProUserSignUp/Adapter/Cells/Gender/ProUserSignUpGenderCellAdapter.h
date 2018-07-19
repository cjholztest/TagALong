//
//  ProUserSignUpGenderCellAdapter.h
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpGenderCellAdapterOutput.h"

@interface ProUserSignUpGenderCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id<ProUserSignUpGenderCellAdapterOutput>)output;

@end
