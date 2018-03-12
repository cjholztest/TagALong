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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.blackColor];
    
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
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
    
    if ([_tfFirstName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input first name!"];
        return NO;
    }
    
    if ([_tfLastName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
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
    
    if ([_tfCity.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input city!"];
        return NO;
    }
    
    if ([_tfPhoneNum.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input phone num!"];
        return NO;
    }
    
    if ([_tfPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input password"];
        return NO;
    }
    
    if ([_tfPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length < 5) {
        [Commons showToast:@"The password must be at least 5 symbols length"];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"THANK YOU" message:@"You registered successfully" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Great"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
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
-(void)ReqRegister{
        
        NSString *_email = [_tfEmail.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_nickname = [_tfFirstName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_lastname = [_tfLastName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_city     = [_tfCity.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_phone    = [_tfPhoneNum.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_pwd      = [_tfPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        
        latitude = self.locationManager.location.coordinate.latitude;
        longitude = self.locationManager.location.coordinate.longitude;
        
        //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
        
        [SharedAppDelegate showLoading];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"register"];
        
        NSDictionary *params = @{
                                 API_REQ_KEY_USER_NICKNAME      :   _nickname,
                                 API_REQ_KEY_USER_LAST_NAME     :   _lastname,
                                 API_REQ_KEY_USER_EMAIL         :   _email,
                                 API_REQ_KEY_USER_CITY          :   _city,
                                 API_REQ_KEY_USER_PHONE         :   _phone,
                                 API_REQ_KEY_USER_PWD           :   _pwd,
                                 };
        
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
            NSLog(@"JSON: %@", respObject);
            //NSError* error;
            //        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
            //                                                                       options:kNilOptions
            //                                                                         error:&error];
            [SharedAppDelegate closeLoading];
            
            int res_code = [[respObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
            if (res_code == RESULT_CODE_SUCCESS) {
                
                //            [Commons showToast:@"Congratulations on your joining."];
                //            [self.navigationController popViewControllerAnimated:NO];
                
                [self showSuccessAlert];
                
            } else if (res_code == RESULT_ERROR_EMAIL_DUPLICATE){
                [self showAlert:@"This email is in use"];
                //[Commons showToast:@"This email is in use."];
            } else if (res_code == RESULT_ERROR_PHONE_NUM_DUPLICATE){
                [self showAlert:@"This phone number is in use"];
                //[Commons showToast:@"This Phone has been duplicated"];
            } else if (res_code == RESULT_ERROR_NICKNAME_DUPLICATE){
                [self showAlert:@"This nickname is in use"];
                //[Commons showToast:@"This nickname has been duplicated"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
            [SharedAppDelegate closeLoading];
            [self showAlert:@"Failed to communicate with the server"];
        }];
}

@end
