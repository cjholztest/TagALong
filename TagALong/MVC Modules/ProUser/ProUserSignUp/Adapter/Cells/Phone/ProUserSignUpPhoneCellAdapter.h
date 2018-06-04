//
//  ProUserSignUpPhoneCellAdapter.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpPhoneCellAdapterOutput.h"

@interface ProUserSignUpPhoneCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpPhoneCellAdapterOutput>)output;

@end
