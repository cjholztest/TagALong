//
//  ProUserEditProfileDebitCellAdapter.h
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileDebitCellAdapterOutput.h"

@interface ProUserEditProfileDebitCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id<ProUserEditProfileDebitCellAdapterOutput>)output;

@end
