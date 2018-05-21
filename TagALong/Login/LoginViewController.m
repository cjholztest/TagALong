//
//  LoginViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "LoginViewController.h"
#import "ExpertLoginViewController.h"
#import "StartedViewController.h"
#import "PassForgetViewController.h"
#import "SignupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface LoginViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>{
    float latitude;
    float longitude;
}
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UIButton *expertLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;

@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *buttons = @[self.expertLoginButton, self.signUpButton, self.loginButton, self.forgetPasswordButton];
    for (UIButton *button in buttons) {
        [button setExclusiveTouch:YES];
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    Global.g_user.user_login = @"1";
    
    //lable shadow
    _lblMsg.shadowColor = [UIColor blackColor];
    _lblMsg.shadowOffset = CGSizeMake(0.0, -0.5);
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    _lblMsg.layer.shadowRadius = 3.0;
    _lblMsg.layer.shadowOpacity = 0.5;
    _lblMsg.layer.masksToBounds = NO;
    _lblMsg.layer.shouldRasterize = YES;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"email@email.com" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7] }];
    _tfEmail.attributedPlaceholder = str;
    NSAttributedString *pass = [[NSAttributedString alloc] initWithString:@"password" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7] }];
    _tfPassword.attributedPlaceholder = pass;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.clearColor];
    [self.navigationController.navigationBar setBackgroundImage: [UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    
    self.tfEmail.text = @"";
    self.tfPassword.text = @"";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self hideKeyboard];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyboard {
    [self.tfEmail resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}

#pragma mark - user defined functions
-(void)Background:(UITapGestureRecognizer *)recognizer{
    [self hideKeyboard];
}

-(BOOL)CheckValidForLogin{
    
    if (_tfEmail.text.length == 0) {
        [self showAlert:@"Input email!"];
        return NO;
    }
    
    if (![Commons checkEmail:_tfEmail.text]) {
        [self showAlert:@"Please enter in email format"];
        return NO;
    }
    
    if (_tfPassword.text.length == 0) {
        [self showAlert:@"Input password!"];
        return NO;
    }
    
    if (_tfPassword.text.length < 5) {
        [self showAlert:@"The password must be at least 5 symbols length"];
        return NO;
    }
    
    return YES;
}

-(void)goStartedPage{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"add_device_token"];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    NSDictionary *params = @{@"token" : deviceToken};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
        NSLog(@"JSON: %@", respObject);
        int res_code = [[respObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            NSLog(@"device token was registered successfully");
        }
        StartedViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartedViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        NSLog(@"device token was not registered");
        StartedViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartedViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
}

#pragma mark - click events
- (IBAction)onClickLogin:(id)sender {
    
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
    
    if ([self CheckValidForLogin]) {
        [self ReqLogin];
        //[self ReqOldLogin];
    }
}

- (IBAction)onClickSignUp:(id)sender {
    
    SignupViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickPassForget:(id)sender {
    
    PassForgetViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PassForgetViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickexpertLogin:(id)sender {
    Global.g_user.user_login = @"2";
    
    ExpertLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertLoginViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {}];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Network
-(void)ReqLogin{
    
    NSString *_email = _tfEmail.text;
    NSString *_pwd   = _tfPassword.text;
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"login"];
    //NSString *url = [NSString stringWithFormat:SERVER_URL, @"login"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_USER_PWD           :   _pwd,
                             API_REQ_KEY_LOGIN_TYPE         :   @"1",
                             };
    
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            _tfEmail.text = @"";
            _tfPassword.text   = @"";
            [Commons parseAndSaveUserInfo:responseObject pwd:_pwd];
            [self goStartedPage];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [self showAlert:@"The password is incorrects"];
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [self showAlert:@"User does not exist"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [self showAlert:@"Failed to communicate with the server"];
    }];
}


//TODO: Remove
-(void)ReqOldLogin{
    NSString *_email = _tfEmail.text;
    NSString *_pwd   = _tfPassword.text;
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_LOGIN,
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_USER_PWD           :   _pwd,
                             API_REQ_KEY_LOGIN_TYPE         :   @"1",
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude],
                             API_REQ_KEY_TOKEN              :   @"P",
                             };
    
    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
        NSLog(@"JSON: %@", respObject);
        NSError* error;
        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
                                                                       options:kNilOptions
                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            _tfEmail.text = @"";
            _tfPassword.text   = @"";
            [Commons parseAndSaveUserInfo:responseObject pwd:_pwd];
            [self goStartedPage];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            //            [_tfPassword becomeFirstResponder];
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            //            [_tfEmail becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

@end
