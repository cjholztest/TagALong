//
//  ClusterAnnotationView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ClusterAnnotationView.h"

@interface ClusterAnnotationView ()

@property (nonatomic) UILabel *countLabel;

@end

@implementation ClusterAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpLabel];
        [self setCount:1];
    }
    return self;
}

- (void)setUpLabel
{
    _countLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _countLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.textColor = [UIColor blackColor];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.adjustsFontSizeToFitWidth = YES;
    _countLabel.minimumScaleFactor = 2;
    _countLabel.numberOfLines = 1;
    _countLabel.font = [UIFont boldSystemFontOfSize:12];
    _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    [self addSubview:_countLabel];
}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    
    self.countLabel.text = [@(count) stringValue];
    self.countLabel.alpha = count > 1 ? 1.0f : 0.0f;
    [self setNeedsLayout];
}

- (void)setBlue:(BOOL)blue
{
    _blue = blue;
    [self setNeedsLayout];
}

- (void)setUniqueLocation:(BOOL)uniqueLocation
{
    _uniqueLocation = uniqueLocation;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    UIImage *image;
    CGPoint centerOffset;
    CGRect countLabelFrame;
    
    if (self.isUniqueLocation) {
        image = [UIImage imageNamed:self.uniqueImageName];
        centerOffset = CGPointMake(0, image.size.height * 0.5);
        CGRect frame = self.bounds;
        frame.origin.y -= 2;
        countLabelFrame = frame;
    } else {
        image = [UIImage imageNamed:self.clusterImageName];
        centerOffset = CGPointZero;
        countLabelFrame = self.bounds;
    }
    self.countLabel.frame = countLabelFrame;
    self.image = image;
    self.centerOffset = centerOffset;
}

@end
