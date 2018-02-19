//
//  PaymentViewController.h
//  TagALong
//
//  Created by PJH on 9/12/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentViewControllerDelegate <NSObject>

- (void)dismiss;

@end

@interface PaymentViewController : UIViewController

@property (strong, nonatomic) id<PaymentViewControllerDelegate> delegate;
@end

