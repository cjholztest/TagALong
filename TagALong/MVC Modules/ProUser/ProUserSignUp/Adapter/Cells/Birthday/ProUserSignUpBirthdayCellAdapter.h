//
//  ProUserSignUpBirthdayCellAdapter.h
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpBirthdayCellAdapterOutput.h"

@interface ProUserSignUpBirthdayCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id<ProUserSignUpBirthdayCellAdapterOutput>)output;

@end
