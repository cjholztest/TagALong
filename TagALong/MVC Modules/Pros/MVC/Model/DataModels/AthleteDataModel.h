//
//  AthleteDataModel.h
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpModel.h"

@interface AthleteDataModel : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSNumber *userUID;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *sportIndex;

@property (nonatomic, strong) NSString *profileImage;

@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSNumber *level;

@property (nonatomic, strong) NSString *awards;
@property (nonatomic, strong) NSString *additionalInfo;

- (CLLocationCoordinate2D)locatoinCoordinate;

@end