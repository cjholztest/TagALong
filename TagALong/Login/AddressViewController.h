//
//  AddressViewController.h
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressViewControllerDelegate <NSObject>

- (void)PageRefresh;

@end
@interface AddressViewController : UIViewController

@property (strong, nonatomic) id<AddressViewControllerDelegate> delegate;
@end

