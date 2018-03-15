//
//  ClusterAnnotationView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ClusterAnnotationView : MKAnnotationView

@property (nonatomic) NSUInteger count;
@property (nonatomic, getter = isBlue) BOOL blue;
@property (nonatomic, getter = isUniqueLocation) BOOL uniqueLocation;

@property (nonatomic, strong) NSString *uniqueImageName;
@property (nonatomic, strong) NSString *clusterImageName;

@end
