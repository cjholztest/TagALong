//
//  ProUserEditProfileSportCellAdapter.h
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserEditProfileCellAdapter.h"
#import "ProUserEditProfileSportCellAdapterOutput.h"

@interface ProUserEditProfileSportCellAdapter : NSObject <ProUserEditProfileCellAdapter>

- (instancetype)initWithOutput:(id<ProUserEditProfileSportCellAdapterOutput>)output;

@end
