//
//  ListViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListViewControllerDelegate <NSObject>

- (void)addOtherUserProfile:(NSString*)_uid type:(NSString*)post_type;

@end

@interface ListViewController : UIViewController
@property (nonatomic, retain) UIViewController *vcParent;
@property (strong, nonatomic) id<ListViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *level_filter;
@property (nonatomic, strong) NSString *sport_filter;
@property (nonatomic, strong) NSString *cate_filter;
@property (nonatomic, strong) NSString *distance_limit;

@end

