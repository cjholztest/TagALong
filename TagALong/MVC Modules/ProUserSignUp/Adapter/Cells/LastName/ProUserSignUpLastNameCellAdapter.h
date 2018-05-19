//
//  ProUserSignUpLastNameCellAdapter.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpLastNameCellAdapterOutput.h"

@interface ProUserSignUpLastNameCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpLastNameCellAdapterOutput>)output;

@end
