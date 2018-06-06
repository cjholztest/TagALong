//
//  ProUserSignUpEmailCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpEmailCellAdapterOutput.h"

@interface ProUserSignUpEmailCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (id<ProUserSignUpCellAdapter>)initWithOutput:(id <ProUserSignUpEmailCellAdapterOutput>)output;

@end
