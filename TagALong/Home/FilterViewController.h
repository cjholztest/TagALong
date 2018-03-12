//
//  FilterViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewControllerDelegate <NSObject>

- (void)setFilter:(NSString*)level sport:(NSString*)sport cat:(NSString*)cat distance:(NSString*)distance startDate:(NSTimeInterval)startDate endDate:(NSTimeInterval)endDate;

@end

@interface FilterViewController : UIViewController

@property (nonatomic, strong) NSString *level_filter;
@property (nonatomic, strong) NSString *sport_filter;
@property (nonatomic, strong) NSString *cate_filter;
@property (nonatomic, strong) NSString *distance_limit;

@property (nonatomic) NSTimeInterval startDate;
@property (nonatomic) NSTimeInterval endDate;

@property (strong, nonatomic) id<FilterViewControllerDelegate> delegate;
@end

