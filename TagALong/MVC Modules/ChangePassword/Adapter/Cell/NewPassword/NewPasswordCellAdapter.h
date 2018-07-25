//
//  NewPasswordCellAdapter.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordCellAdapter.h"
#import "NewPasswordCellAdapterOutput.h"

@interface NewPasswordCellAdapter : NSObject <ChangePasswordCellAdapter>

- (instancetype)initWithOutput:(id<NewPasswordCellAdapterOutput>)output;

@end
