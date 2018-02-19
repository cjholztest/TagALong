//
//  BookWorkoutViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookWorkoutViewController : UIViewController
@property (nonatomic, retain) UIViewController *vcParent;
@property (nonatomic, strong) NSString *workout_id;
@property (nonatomic, strong) NSString *where;  //어느 페지에서 왔는가?

@property (nonatomic, assign) BOOL bProfile;  //프로필 페지에서 넘어왔는가
@end

