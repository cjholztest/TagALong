//
//  SelectLocationView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SelectLocationView : UIView

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) UIView *pinView;

@end
