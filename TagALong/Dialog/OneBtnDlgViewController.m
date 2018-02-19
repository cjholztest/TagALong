//
//  OneBtnDlgViewController.m
//  
//
//  Created by rabit J. on 9/28/17.
//

#import "OneBtnDlgViewController.h"


@interface OneBtnDlgViewController () {

}

@end

@implementation OneBtnDlgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - click events

- (IBAction)onclickConfirm:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - user defined functions
-(void)initUI{
    self.vwBG.layer.cornerRadius = 5;
    _lblMsg.text = self.str;
}


@end
