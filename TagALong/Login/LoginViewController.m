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

@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];

}

//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
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
    [_tfPassword resignFirstResponder];
}

-(BOOL)CheckValidForLogin{
    
    if (_tfEmail.text.length == 0) {
//        [Commons showToast:@"Input email!"];
        [Commons showOneBtnDlg:@"Input email!" id:self];
        //[_tfEmail becomeFirstResponder];
        return NO;
    }
    
    if (![Commons checkEmail:_tfEmail.text]) {
//        [Commons showToast:@"Please enter in email format."];
        [Commons showOneBtnDlg:@"Please enter in email format." id:self];
//        [_tfEmail becomeFirstResponder];
        return NO;
    }
    
    if (_tfPassword.text.length == 0) {
//        [Commons showToast:@"Input password"];
        [Commons showOneBtnDlg:@"Input password!." id:self];
//        [_tfPassword becomeFirstResponder];
        return NO;
    }
    
    return YES;
}


-(void)goStartedPage{
    StartedViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartedViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - click events
- (IBAction)onClickLogin:(id)sender {
    
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];

    if ([self CheckValidForLogin]) {
        [self ReqLogin];
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

#pragma mark - Network
-(void)ReqLogin{
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
                             API_REQ_KEY_TOKEN              :   Global.g_token,
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
