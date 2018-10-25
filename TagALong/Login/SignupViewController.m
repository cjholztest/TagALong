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
#import <QuickLook/QuickLook.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface SignupViewController ()<UITextFieldDelegate, CLLocationManagerDelegate, QLPreviewControllerDelegate, QLPreviewControllerDataSource, SignupResultViewControllerDelegate>{
    double latitude;
    double longitude;
}
@property (strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property (strong, nonatomic) IBOutlet UITextField *tfLastName;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfCity;
@property (strong, nonatomic) IBOutlet UITextField *tfPhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain) CLLocationManager *locationManager;

@property (assign, nonatomic) BOOL isPrivacyActive;

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
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
-(void)hideKeyboard {
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
        [Commons showToast:@"Input phone number!"];
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
    
    if ([_tfConfirmPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input confirm password"];
        return NO;
    }
    
    NSString *password = [_tfPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *confirmPassword = [_tfConfirmPassword.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];

    if (password.length != 0 && confirmPassword != 0) {
        if (![password isEqualToString:confirmPassword]) {
            [Commons showToast:@"Confirm password doesn't match the password"];
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - click events
//submit
- (IBAction)onClickSubmit:(id)sender {
    
    [self hideKeyboard];
    if ([self CheckValidForRegister]) {
        [self ReqRegister];
    }
    
}

- (IBAction)showPasswordAction:(UIButton *)sender {
    UITextField *passTextField = sender.tag == 0 ? self.tfPassword : self.tfConfirmPassword;
    [passTextField setSecureTextEntry:!passTextField.secureTextEntry];
    NSString *imageName = passTextField.secureTextEntry ? @"show_password" : @"hide_password";
    UIImage *image = [UIImage imageNamed:imageName];
    [sender setImage:image forState:UIControlStateNormal];
    [sender setImage:image forState:UIControlStateSelected];
    [sender setImage:image forState:UIControlStateHighlighted];
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

- (IBAction)onClickTerms:(UIButton *)sender {
    self.isPrivacyActive = NO;
    [self showPreview];
}

- (IBAction)onClickPrivacy:(id)sender {
    self.isPrivacyActive = YES;
    [self showPreview];
}

#pragma mark - Preview

- (void)showPreview {
    QLPreviewController *previewVC = [QLPreviewController new];
    previewVC.delegate = self;
    previewVC.dataSource = self;
    [self presentViewController:previewVC animated:YES completion:nil];
}

#pragma mark - QLPreviewController

- (id <QLPreviewItem>)previewController:(QLPreviewController*)controller previewItemAtIndex:(NSInteger)index {
    NSString *fileName = self.isPrivacyActive ? @"TagAlong - Privacy Policy" : @"TagAlong - Terms";
    NSURL *URL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"docx"];
    return URL;
}

- (NSInteger) numberOfPreviewItemsInPreviewController:(QLPreviewController*)controller {
    return 1;
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
                                 @"latitude"   : @(0.0),
                                 @"longitude"   : @(0.0),
                                 @"hide_phone" : @(NO)
                                 };
    
        NSDictionary *fb_params = @{
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_USER_CITY          :   _city,
                             API_REQ_KEY_USER_PHONE         :   _phone,
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
                [self logCompletedRegistrationEvent:@"app":fb_params];
                
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

/**
 * For more details, please take a look at:
 * developers.facebook.com/docs/reference/ios/current/class/FBSDKAppEvents
 */
- (void)logCompletedRegistrationEvent:(NSString *)registrationMethod :(NSDictionary *)pre_params {
    NSDictionary *params =
    @{FBSDKAppEventParameterNameRegistrationMethod : registrationMethod,
      @"USER_INFO" : pre_params
    };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameCompletedRegistration
     parameters:params];
}

#pragma mark - Keyboar Notifications

- (void)keyboardDidShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = keyboardFrameBeginRect.size.height;
        self.scrollView.contentInset = insets;
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = 0.0f;
        self.scrollView.contentInset = insets;
    }];
}

@end
