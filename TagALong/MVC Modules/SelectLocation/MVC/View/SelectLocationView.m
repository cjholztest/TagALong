//
//  SelectLocationView.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SelectLocationView.h"

@implementation SelectLocationView

- (UIView*)pinView {
    if (!_pinView) {
        _pinView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _pinView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        _pinView.layer.cornerRadius = 12.0f;
        [self.mapView addSubview:_pinView];
    }
    return _pinView;
}

@end
