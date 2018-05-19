//
//  ProUserSignUpSportCellAdapter.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpSportCellAdapterOutput.h"

@interface ProUserSignUpSportCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpSportCellAdapterOutput>)output;

@end
