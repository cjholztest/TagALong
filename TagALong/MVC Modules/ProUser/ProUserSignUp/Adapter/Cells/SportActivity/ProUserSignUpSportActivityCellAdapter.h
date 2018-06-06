//
//  ProUserSignUpSportActivityCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/31/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpSportActivityCellAdapterOutput.h"

@interface ProUserSignUpSportActivityCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpSportActivityCellAdapterOutput>)output;

@end
