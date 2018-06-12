//
//  NextWorkoutsView.m
//  TagALong
//
//  Created by User on 6/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NextWorkoutsView.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@implementation NextWorkoutsView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect infoFrame = CGRectZero;
    infoFrame.size.width = 30.0;
    infoFrame.size.height = 30.0;
    infoFrame.origin.x = 15.0f;
    infoFrame.origin.y = self.bounds.size.height / 2.0f - infoFrame.size.height / 2.0f;
    
    CGRect titleFrame = CGRectZero;
    titleFrame.origin.x = infoFrame.origin.x + infoFrame.size.width + 15.0f;
    titleFrame.origin.y = infoFrame.origin.y;
    titleFrame.size.width = self.bounds.size.width - titleFrame.origin.x - 15.0f;
    titleFrame.size.height = infoFrame.size.height;
    
    self.infoNWLabel.frame = infoFrame;
    self.titleNWLabel.frame = titleFrame;
}

- (UILabel*)infoNWLabel {
    if (!_infoNWLabel) {
        _infoNWLabel = [UILabel new];
        _infoNWLabel.layer.cornerRadius = 15.0f;
        _infoNWLabel.clipsToBounds = YES;
        _infoNWLabel.textColor = UIColor.appColor;
        _infoNWLabel.backgroundColor = UIColor.whiteColor;
        _infoNWLabel.font = [UIFont textFont];
        _infoNWLabel.text = @"i";
        _infoNWLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_infoNWLabel];
    }
    return _infoNWLabel;
}

- (UILabel*)titleNWLabel {
    if (!_titleNWLabel) {
        _titleNWLabel = [UILabel new];
        _titleNWLabel.textColor = UIColor.textColor;
        _titleNWLabel.font = [UIFont textFont];
        _titleNWLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleNWLabel];
    }
    return _titleNWLabel;
}

@end
