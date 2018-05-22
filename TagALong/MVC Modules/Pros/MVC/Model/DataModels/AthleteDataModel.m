//
//  AthleteDataModel.m
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteDataModel.h"

@implementation AthleteDataModel

- (CLLocationCoordinate2D)locatoinCoordinate {
    
    CLLocationDegrees latitude = [self.latitude floatValue];
    CLLocationDegrees longitude = [self.longitude floatValue];
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

@end
