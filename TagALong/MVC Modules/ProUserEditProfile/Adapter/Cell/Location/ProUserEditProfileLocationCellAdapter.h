//
//  ProUserEditProfileLocationCellAdapter.h
//  TagALong
//
//  Created by Nikita Vintonovich on 7/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileLocationCellAdapterOutput.h"

@interface ProUserEditProfileLocationCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id<ProUserEditProfileLocationCellAdapterOutput>)output;

@end
