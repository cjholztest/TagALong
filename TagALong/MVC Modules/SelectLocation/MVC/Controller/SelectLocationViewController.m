//
//  SelectLocationViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "SelectLocationModel.h"
#import "SelectLocationView.h"
#import "Pin.h"

@interface SelectLocationViewController ()

@property (weak, nonatomic) IBOutlet SelectLocationView *contentView;
@property (nonatomic, assign) CLLocationCoordinate2D startLocation;


@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPin:)];
//    recognizer.minimumPressDuration = 0.5;
    [self.contentView.mapView addGestureRecognizer:tap];
    
    if (self.startLocation.latitude != 0.0f && self.startLocation.longitude != 0.0f) {
        [self movePinToLocation:self.startLocation];
    }
}

- (void)addPin:(UIGestureRecognizer *)recognizer {
    
    if (recognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGPoint userTouch = [recognizer locationInView:self.contentView.mapView];
    CLLocationCoordinate2D mapPoint = [self.contentView.mapView convertPoint:userTouch toCoordinateFromView:self.contentView.mapView];
    
    [self movePinToLocation:mapPoint];
    
    if ([self.moduleOutput respondsToSelector:@selector(locationDidSet:)]) {
        [self.moduleOutput locationDidSet:mapPoint];
    }
}

- (void)movePinToLocation:(CLLocationCoordinate2D)location {
    
    id annotation = [self.contentView.mapView.annotations lastObject];
    
    if (annotation) {
        [self.contentView.mapView removeAnnotation:annotation];
    }
    
    Pin *pin = [[Pin alloc] initWithCoordinate:location];
    [self.contentView.mapView addAnnotation:pin];
}

#pragma mark - SelectLocationModuleInput

- (void)setupLocation:(CLLocationCoordinate2D)location {
    self.startLocation = location;
}

@end
