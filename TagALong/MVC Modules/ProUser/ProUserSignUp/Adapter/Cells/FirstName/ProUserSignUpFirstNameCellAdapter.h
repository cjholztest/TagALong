//
//  ProUserSignUpFirstNameCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpFirstNameCellAdapterOutput.h"

@interface ProUserSignUpFirstNameCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpFirstNameCellAdapterOutput>)output;

@end
