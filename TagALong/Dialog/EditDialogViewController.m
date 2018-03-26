//
//  EditDialogViewController.m
//  
//
//  Created by rabit J. on 8/15/17.
//

#import "EditDialogViewController.h"


@interface EditDialogViewController () <UITextFieldDelegate>{

}
@property (strong, nonatomic) IBOutlet UITextField *tfEdit;
@property (strong, nonatomic) IBOutlet UIView *vwBG;

@end

@implementation EditDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vwBG.layer.cornerRadius = 5;
    
    _tfEdit.text = self.content;
    //padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _tfEdit.leftView = paddingView;
    _tfEdit.leftViewMode = UITextFieldViewModeAlways;

    if ([self.type isEqualToString:@"area"]) {
        _tfEdit.placeholder = @"Please enter area.";
    } else if ([self.type isEqualToString:@"phone"]) {
        _tfEdit.placeholder = @"Please enter a phone number.";
    }
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];

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


#pragma mark - user defined functions

- (IBAction)onClickConfirm:(id)sender {
    NSString *temp = _tfEdit.text;
    if ([temp isEqualToString:@""]) {
        if ([self.type isEqualToString:@"area"]) {
            [_tfEdit resignFirstResponder];
            [Commons showToast:@"Please enter area."];
            return;
        } else if ([self.type isEqualToString:@"phone"]) {
            [_tfEdit resignFirstResponder];
            [Commons showToast:@"Please enter a phone number."];
            return;
        } else if
    }
    
    [self.delegate setContent:self.type msg:_tfEdit.text];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)Background:(UITapGestureRecognizer *)recognizer{
    [_tfEdit resignFirstResponder];
    
}
@end
