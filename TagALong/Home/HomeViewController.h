//
//  HomeViewController.h
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PAGE_MENU_PROFILE       0
#define PAGE_MENU_MAP           1
#define PAGE_MENU_LIST          2

#define BUTTON_PROFILE          10
#define BUTTON_SEARDCH          20
#define BUTTON_SUBMIT           30
#define BUTTON_PROS             40

@interface HomeViewController : UIViewController

@property (nonatomic) NSInteger nCurPageIdx;
@property (nonatomic) NSInteger nCurButtonIdx;
@end

