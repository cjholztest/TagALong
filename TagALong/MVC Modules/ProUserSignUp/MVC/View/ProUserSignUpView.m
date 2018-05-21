//
//  ProUserSignUpView.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpView.h"
#import "UIColor+AppColors.h"

@interface ProUserSignUpView()

@property (nonatomic, strong) CAGradientLayer *topGradientLayer;
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;

@end

@implementation ProUserSignUpView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect topGradientFrame = CGRectMake(0, 0, self.tableView.bounds.size.width, 15.0f);
    if (!CGRectEqualToRect(self.topGradientLayer.frame, topGradientFrame)) {
        self.topGradientLayer.frame = topGradientFrame;
    }
    
    CGRect bottomGradientFrame = CGRectMake(0, (self.tableView.bounds.size.height - 30.0f), self.tableView.bounds.size.width, 30.0f);
    if (!CGRectEqualToRect(self.bottomGradientLayer.frame, bottomGradientFrame)) {
        self.bottomGradientLayer.frame = bottomGradientFrame;
    }
}

#pragma mark - Lazy Init

- (CAGradientLayer*)topGradientLayer {
    if (!_topGradientLayer) {
        _topGradientLayer = [CAGradientLayer new];
        _topGradientLayer.frame = CGRectZero;
        _topGradientLayer.colors = [UIColor topGradientColors];
        [self.layer insertSublayer:_topGradientLayer above:self.tableView.layer];
    }
    return _topGradientLayer;
}

- (CAGradientLayer*)bottomGradientLayer {
    if (!_bottomGradientLayer) {
        _bottomGradientLayer = [CAGradientLayer new];
        _bottomGradientLayer.frame = CGRectZero;
        _bottomGradientLayer.colors = [UIColor bottomGradientColors];
        [self.layer insertSublayer:_bottomGradientLayer above:self.tableView.layer];
    }
    return _bottomGradientLayer;
}

#pragma mark - Actions

- (IBAction)registerButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(signUpButtonDidTap)]) {
        [self.output signUpButtonDidTap];
    }
}

@end
