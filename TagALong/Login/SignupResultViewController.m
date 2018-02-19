//
//  SignupResultViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "SignupResultViewController.h"

@interface SignupResultViewController (){
    
}
@property (strong, nonatomic) IBOutlet UIImageView *vwBlueBg;

@end

@implementation SignupResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [_vwBlueBg setHidden:YES];
    } else {
        [_vwBlueBg setHidden:NO];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user defined functions


#pragma mark - click events


- (IBAction)onClickOk:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate dismiss];
}

- (IBAction)onClickAlarm:(id)sender {

    
}

@end
