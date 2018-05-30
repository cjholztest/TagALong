//
//  WorkoutProfileInfoDataModel.h
//  TagALong
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutProfileInfoDataModel : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *profileIconURL;

@end
