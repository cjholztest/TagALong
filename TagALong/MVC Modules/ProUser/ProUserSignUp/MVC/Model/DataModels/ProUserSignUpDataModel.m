//
//  ProUserSignUpDataModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpDataModel.h"

@interface ProUserSignUpDataModel()

@end

@implementation ProUserSignUpDataModel

#pragma mark - Lazy Init

- (Birthday*)birthday {
    if (!_birthday) {
        _birthday = [Birthday new];
    }
    return _birthday;
}

@end
