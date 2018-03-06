//
//  MapViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController 
@property (nonatomic, retain) UIViewController *vcParent;

@property (nonatomic, strong) NSString *level_filter;
@property (nonatomic, strong) NSString *sport_filter;
@property (nonatomic, strong) NSString *cate_filter;
@property (nonatomic, strong) NSString *distance_limit;

@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;

@end

