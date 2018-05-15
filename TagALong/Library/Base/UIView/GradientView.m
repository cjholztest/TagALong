//
//  GradientView.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "GradientView.h"
#import "UIColor+AppColors.h"

@interface GradientView()

@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer;

@end

@implementation GradientView



- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(self.backgroundGradientLayer.frame, self.bounds)) {
        self.backgroundGradientLayer.frame = self.bounds;
    }
}

#pragma mark - Lazy Init

- (CAGradientLayer*)backgroundGradientLayer {
    if (!_backgroundGradientLayer) {
        _backgroundGradientLayer = [CAGradientLayer new];
//        _backgroundGradientLayer.colors = [UIColor regularUserBackgroundGradientColors];
//        [self.layer insertSublayer:_backgroundGradientLayer atIndex:0];
        self.backgroundColor = [UIColor regularBackgroundColor];
    }
    return _backgroundGradientLayer;
}

@end
