//
//  SignupViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "SignupViewController.h"
#import "SignupResultViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SignupViewController ()<UITextFieldDelegate, CLLocationManagerDelegate,SignupResultViewControllerDelegate>{
    double latitude;
    double longitude;
}
@property (strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property (strong, nonatomic) IBOutlet UITextField *tfLastName;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfCity;
@property (strong, nonatomic) IBOutlet UITextField *tfPhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
 
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];

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

//signup result delegate
-(void)dismiss{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - user defined functions
-(void)Background:(UITapGestureRecognizer *)recognizer{
    [_tfFirstName resignFirstResponder];
    [_tfLastName resignFirstResponder];
    [_tfEmail resignFirstResponder];
    [_tfCity resignFirstResponder];
    [_tfPhoneNum resignFirstResponder];
    [_tfPassword resignFirstResponder];
}

-(BOOL)CheckValidForRegister{
    
    if (_tfFirstName.text.length == 0) {
        [Commons showToast:@"Input first name!"];
        return NO;
    }

    if (_tfLastName.text.length == 0) {
        [Commons showToast:@"Input last name!"];
        return NO;
    }
    
    if (_tfEmail.text.length == 0) {
        [Commons showToast:@"Input email!"];
        return NO;
    }

    if (![Commons checkEmail:_tfEmail.text]) {
        [Commons showToast:@"Please enter in email format."];
        return NO;
    }
    
    if (_tfCity.text.length == 0) {
        [Commons showToast:@"Input city!"];
        return NO;
    }
    
    if (_tfPhoneNum.text.length == 0) {
        [Commons showToast:@"Input phone num!"];
        return NO;
    }
    
    if (_tfPassword.text.length == 0) {
        [Commons showToast:@"Input password"];
        return NO;
    }

    return YES;
}


#pragma mark - click events
//submit
- (IBAction)onClickSubmit:(id)sender {

//    SignupResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignupResultViewController"];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
    if ([self CheckValidForRegister]) {
        [self ReqRegister];
    }

}

//go back
- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - Network
-(void)ReqRegister{
    NSString *_email = _tfEmail.text;
    NSString *_nickname = _tfFirstName.text;
    NSString *_lastname = _tfLastName.text;
    NSString *_city     = _tfCity.text;
    NSString *_phone    = _tfPhoneNum.text;
    NSString *_pwd      = _tfPassword.text;
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
//    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_REGISTER,
                             API_REQ_KEY_USER_NICKNAME      :   _nickname,
                             API_REQ_KEY_USER_LAST_NAME     :   _lastname,
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_USER_CITY          :   _city,
                             API_REQ_KEY_USER_PHONE         :   _phone,
                             API_REQ_KEY_USER_PWD           :   _pwd,
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude]
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
            
            [Commons showToast:@"Congratulations on your joining."];
            [self.navigationController popViewControllerAnimated:NO];
            
        } else if (res_code == RESULT_ERROR_EMAIL_DUPLICATE){
            [Commons showToast:@"This email is in use."];
        } else if (res_code == RESULT_ERROR_PHONE_NUM_DUPLICATE){
            [Commons showToast:@"This Phone has been duplicated"];
        } else if (res_code == RESULT_ERROR_NICKNAME_DUPLICATE){
            [Commons showToast:@"This nickname has been duplicated"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

@end
