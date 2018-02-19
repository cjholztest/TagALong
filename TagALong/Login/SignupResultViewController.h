//
//  SignupResultViewController.h
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SignupResultViewControllerDelegate <NSObject>

- (void)dismiss;

@end
@interface SignupResultViewController : UIViewController

@property (strong, nonatomic) id<SignupResultViewControllerDelegate> delegate;
@end

