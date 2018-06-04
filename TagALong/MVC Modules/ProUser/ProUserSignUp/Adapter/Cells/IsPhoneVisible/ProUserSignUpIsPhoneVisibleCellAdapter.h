//
//  ProUserSignUpIsPhoneVisibleCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpIsPhoneVisibleCellAdapterOutput.h"

@interface ProUserSignUpIsPhoneVisibleCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpIsPhoneVisibleCellAdapterOutput>)output;

@end
