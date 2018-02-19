//
//  ExpertLoginViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "ExpertLoginViewController.h"
#import "StartedViewController.h"
#import "HomeViewController.h"
#import "PassForgetViewController.h"
#import "ProSignupViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ExpertLoginViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>{
    float latitude;
    float longitude;
}
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation ExpertLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"email@email.com" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:0 alpha:0.4] }];
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
//        [_tfEmail becomeFirstResponder];
        [Commons showOneBtnDlg:@"Input email!" id:self];
        return NO;
    }
    
    if (![Commons checkEmail:_tfEmail.text]) {
//        [Commons showToast:@"Please enter in email format."];
//        [_tfEmail becomeFirstResponder];
        [Commons showOneBtnDlg:@"Please enter in email format." id:self];
        return NO;
    }
    
    if (_tfPassword.text.length == 0) {
//        [Commons showToast:@"Input password"];
//        [_tfPassword becomeFirstResponder];
        [Commons showOneBtnDlg:@"Input password!." id:self];
        return NO;
    }
    
    return YES;
}


-(void)goHome{
    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
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
    ProSignupViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProSignupViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickPassForget:(id)sender {
    PassForgetViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PassForgetViewController"];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
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
                             API_REQ_KEY_LOGIN_TYPE         :   @"2",//expert
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
            
            [Commons parseAndSaveExpertUserInfo:responseObject pwd:_pwd];
            [self goHome];
        } else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
//            [_tfEmail becomeFirstResponder];
        } else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
//            [_tfPassword becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
    
}


@end
