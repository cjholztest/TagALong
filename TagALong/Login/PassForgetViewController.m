//
//  AddressViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "PassForgetViewController.h"


@interface PassForgetViewController ()<UITextFieldDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UIImageView *ivBackground;

@property (strong, nonatomic) IBOutlet UIView *resetView;

@property (strong, nonatomic) IBOutlet UIView *setPassView;

@property (strong, nonatomic) IBOutlet UITextField *setPassEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *setPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *setPassResCodeTextField;

@end

@implementation PassForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        _ivBackground.image = [UIImage imageNamed:@"bg_login.png"];
    } else {
        _ivBackground.image = [UIImage imageNamed:@"bg_login1.png"];
    }
    
    [self configureTextFields];

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

-(void)configureTextFields {
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"email@email.com" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7] }];
    self.setPassEmailTextField.attributedPlaceholder = str;
    NSAttributedString *pass = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7] }];
    self.setPasswordTextField.attributedPlaceholder = pass;
    NSAttributedString *code = [[NSAttributedString alloc] initWithString:@"Restore code" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7] }];
    self.setPassResCodeTextField.attributedPlaceholder = code;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.clearColor];
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setBackgroundImage: [UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
-(void)Background:(UITapGestureRecognizer *)recognizer{
    [_tfEmail resignFirstResponder];
}

-(BOOL)CheckValidInfo{
    
    if (self.setPassView.isHidden) {
        
        if (_tfEmail.text.length == 0) {
            [Commons showToast:@"Input email!"];
            return NO;
        }
        
        if (![Commons checkEmail:_tfEmail.text]) {
            [Commons showToast:@"Please enter in email format."];
            return NO;
        }
    } else {
        
        if (self.setPasswordTextField.text.length < 5) {
            [Commons showToast:@"The password must be at least 5 symbols length"];
            return NO;
        }
        
        if (self.setPassEmailTextField.text.length == 0) {
            [Commons showToast:@"Input email!"];
            return NO;
        }
        
        if (![Commons checkEmail:self.setPassEmailTextField.text]) {
            [Commons showToast:@"Please enter in email format."];
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - click events

- (IBAction)onClickReset:(id)sender {

   if ([self CheckValidInfo]) {
       [self reqFindPassword];
   }
}

- (IBAction)onClickSet:(id)sender {
    
    if ([self CheckValidInfo]) {
        [self reqSetNewPassword];
    }
}


#pragma mark - Network
-(void)reqFindPassword{
    NSString *_email = _tfEmail.text;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_RESTORE_CODE];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_LOGIN_TYPE         :   Global.g_user.user_login,
                             };
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [self showAlert:@"Restoring key was sent to your email"];
            //[Commons showToast:@"It has been sent out successfully."];
            [self.navigationController popViewControllerAnimated:NO];
            
        }   else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
            [self showAlert:@"User does not exist"];
            //[Commons showToast:@"User does not exist."];
            [_tfEmail becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

-(void)reqSetNewPassword{
    NSString *email = self.setPassEmailTextField.text;
    NSString *password = self.setPasswordTextField.text;
    NSString *code = self.setPassResCodeTextField.text;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_SET_PASSWORD];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_EMAIL         :   email,
                             API_REQ_KEY_LOGIN_TYPE         :   Global.g_user.user_login,
                             API_REQ_KEY_RESTORE_CODE       :   code,
                             API_REQ_KEY_NEW_PASSWORD       :   password
                             };
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [self showSuccessAlert];
            //[Commons showToast:@"It has been sent out successfully."];
            [self.navigationController popViewControllerAnimated:NO];
            
        }   else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
            [self showAlert:@"User does not exist"];
            //[Commons showToast:@"User does not exist."];
            //[_tfEmail becomeFirstResponder];
        } else if (res_code == RESULT_ERROR_CODE_EXPIRED) {
            [self showAlert:@"Invalid code. It's possible that the code has expired"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

-(void)clearSetNewPassView {
    self.setPassResCodeTextField.text = @"";
    self.setPassEmailTextField.text = @"";
    self.setPasswordTextField.text = @"";
    
    [self.setPassResCodeTextField resignFirstResponder];
    [self.setPassEmailTextField resignFirstResponder];
    [self.setPasswordTextField resignFirstResponder];
}

-(void)showAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    if (self.setPassView.isHidden) {
                                        [UIView transitionFromView:self.resetView toView:self.setPassView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
                                            [self.tfEmail resignFirstResponder];
                                            self.tfEmail.text = @"";
                                            [self.setPassView setHidden:NO];
                                            [self.resetView setHidden:YES];
                                        }];
                                    } else {
                                        [UIView transitionFromView:self.setPassView toView:self.resetView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
                                            [self clearSetNewPassView];
                                            [self.tfEmail becomeFirstResponder];
                                            self.tfEmail.text = @"";
                                            [self.setPassView setHidden:YES];
                                            [self.resetView setHidden:NO];
                                        }];
                                    }
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"THANK YOU" message:@"You successfully set new password" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Great"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
