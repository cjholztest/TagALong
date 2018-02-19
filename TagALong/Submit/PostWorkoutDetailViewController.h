//
//  PostWorkoutDetailViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostWorkoutDetailViewControllerDelegate <NSObject>

- (void)dismiss;

@end
@interface PostWorkoutDetailViewController : UIViewController

@property (strong, nonatomic) id<PostWorkoutDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSString *sport_uid;
@end

