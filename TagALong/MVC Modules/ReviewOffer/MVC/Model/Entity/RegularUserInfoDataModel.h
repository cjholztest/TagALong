//
//  RegularUserInfoDataModel.h
//  TagALong
//
//  Created by User on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularUserInfoDataModel : NSObject

@property (nonatomic, strong) NSNumber *userUID;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *profileIconURL;
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, assign) BOOL hidePhone;

@end
