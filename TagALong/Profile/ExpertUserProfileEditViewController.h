//
//  ExpertUserProfileEditViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpertUserProfileEditViewControllerDelegate <NSObject>

- (void)setEditDate:(NSMutableDictionary*)dic;

@end

@interface ExpertUserProfileEditViewController : UIViewController

@property (strong, nonatomic) id<ExpertUserProfileEditViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSMutableArray *arrSchedule;
@property (nonatomic, retain) UIViewController *vcParent;
@end

