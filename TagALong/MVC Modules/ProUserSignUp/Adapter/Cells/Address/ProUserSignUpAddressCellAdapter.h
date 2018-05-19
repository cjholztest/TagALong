//
//  ProUserSignUpAddressCellAdapter.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpAddressCellAdapterOutput.h"

@interface ProUserSignUpAddressCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpAddressCellAdapterOutput>)output;

@end
