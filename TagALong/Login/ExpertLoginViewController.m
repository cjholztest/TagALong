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
#import "ProfilePaymentDataViewController.h"
#import "PaymentClient+Customer.h"
#import "PaymentClient+CreditCard.h"

#import "UIViewController+Storyboard.h"
#import "ProUserSignUpViewController.h"
#import "UIFont+HelveticaNeue.h"
#import "UIColor+AppColors.h"

#import <MessageUI/MessageUI.h>

@interface ExpertLoginViewController ()<MFMailComposeViewControllerDelegate, UITextFieldDelegate, CLLocationManagerDelegate, ProfilePaymentDataModuleDelegate>{
    float latitude;
    float longitude;
}
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *logoButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic,retain) CLLocationManager *locationManager;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end

@implementation ExpertLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"Professional Athletes\nLogin/Sign Up Here";
    
    NSArray *buttons = @[self.logoButton, self.loginButton, self.signUpButton, self.forgetPasswordButton, self.backButton];
    for (UIButton *button in buttons) {
        [button setExclusiveTouch:YES];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7], NSFontAttributeName : [UIFont pickerBoldFont] }];
    _tfEmail.attributedPlaceholder = str;
    NSAttributedString *pass = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.7], NSFontAttributeName : [UIFont pickerBoldFont] }];
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
    self.scrollView.contentInset = UIEdgeInsetsZero;
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
    [_tfPassword resignFirstResponder];
}

-(BOOL)CheckValidForLogin{
    
    if (_tfEmail.text.length == 0) {
        [self showAlert:@"Input email!"];
        return NO;
    }
    
    if (![Commons checkEmail:_tfEmail.text]) {
        [self showAlert:@"Please enter in email format."];
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


-(void)goHome{
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"add_device_token"];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    
    if (deviceToken) {
        NSDictionary *params = @{@"token" : deviceToken};
        
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
            NSLog(@"JSON: %@", respObject);
            int res_code = [[respObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
            if (res_code == RESULT_CODE_SUCCESS) {
                NSLog(@"device token was registered successfully");
            }
            [weakSelf showHomeScreen];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
            NSLog(@"device token was not registered");
            [weakSelf showHomeScreen];
        }];
    } else {
        [self showHomeScreen];
    }
}

- (void)showHomeScreen {
    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showPaymentRegistration {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    ProfilePaymentDataViewController *profilePaymentVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(ProfilePaymentDataViewController.class)];
    profilePaymentVC.modeType = ProfilPaymentModeTypeRegistration;
    profilePaymentVC.moduleDelegate = self;
    [self presentViewController:profilePaymentVC animated:YES completion:nil];
}

- (void)showProUserRegistrationScreen {
    ProUserSignUpViewController *vc = (ProUserSignUpViewController*)ProUserSignUpViewController.fromStoryboard;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showEnterTagALongCodeAlert {
    
    [self unsubscribeForKeyboardNotification];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"TagALong"
                                                                              message: @"Input Pro Code. If you don’t have one, contact Pro.Tagalong@tagalong.pro"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"type validation code";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        textField.secureTextEntry = YES;
    }];
    
    __weak typeof(self)weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
        NSArray *textfields = alertController.textFields;
        UITextField *codeTextField = textfields.firstObject;

                                                              NSString *textCode = codeTextField.text;
                                                              
                                                              [weakSelf subscribeForKeyboardNotification];
                                                              if ([weakSelf isEnteredCodeValid:textCode]) {
                                                                  [weakSelf showProUserRegistrationScreen];
                                                              }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [weakSelf subscribeForKeyboardNotification];
                                                         }];
    
    UIAlertAction *contactAction = [UIAlertAction actionWithTitle:@"Contact Pro.Tagalong@tagalong.pro"
                                                           style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [weakSelf subscribeForKeyboardNotification];
                                                              [weakSelf showMailScreen];
                                                          }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:contactAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - ProfilePaymentDataModuleDelegate

- (void)paymentCredentialsDidSend {
    __weak typeof(self)weakSelf = self;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf goHome];
    }];
}

- (void)skipSendingPaymentCredentials {
    __weak typeof(self)weakSelf = self;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf goHome];
    }];
}

#pragma mark - click events
- (IBAction)onClickLogin:(id)sender {

    if ([self CheckValidForLogin]) {
        [self ReqLogin];
    }
}

- (IBAction)onClickSignUp:(id)sender {
//    ProSignupViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProSignupViewController"];
    
    [self showEnterTagALongCodeAlert];
    
//    ProUserSignUpViewController *vc = (ProUserSignUpViewController*)ProUserSignUpViewController.fromStoryboard;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickPassForget:(id)sender {
    PassForgetViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PassForgetViewController"];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (BOOL)isEnteredCodeValid:(NSString*)codeHash {
    
    BOOL isValid = NO;
    
    NSArray *hashes = @[@"kFjUT#R985",
                        @"oIReW#W476",
                        @"PoldC#M503",
                        @"mNjkX#U984",
                        @"jhFGV#A760"];
    
    for (NSInteger i = 0; i < hashes.count; i++) {
        NSString *currentHash = hashes[i];
        if ([currentHash isEqualToString:codeHash]) {
            isValid = YES;
            break;
        }
    }
    
    return isValid;
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
                             API_REQ_KEY_LOGIN_TYPE         :   @"2",
                             };
    
    __weak typeof(self)weakSelf = self;
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            _tfEmail.text = @"";
            _tfPassword.text   = @"";
            [Commons parseAndSaveExpertUserInfo:responseObject pwd:_pwd];
//            [self goHome];
//            [self showPaymentRegistration];
            [weakSelf checkPaymentAccountCredentialsWithCompletion:^(BOOL isPaymentAccountExists) {
                if (isPaymentAccountExists) {
                    [weakSelf goHome];
                } else {
                    [weakSelf showPaymentRegistration];
                }
            }];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [self showAlert:@"The password is incorrect"];
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [self showAlert:@"User does not exist"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [self showAlert:@"Failed to communicate with the server"];
    }];
}

- (void)checkPaymentAccountCredentialsWithCompletion:(void(^)(BOOL isPaymentAccountExists))completion {
    [SharedAppDelegate showLoading];
    [PaymentClient expertPaymentDataWithCompletion:^(id responseObject, NSError *error) {
        [SharedAppDelegate closeLoading];
        BOOL isAccountExists = [responseObject[@"exist"] boolValue];
        if (completion) {
            completion(isAccountExists);
        }
    }];
}

- (void)showMailScreen {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setToRecipients:@[@"Pro.Tagalong@tagalong.pro"]];
        [self presentViewController:mail animated:YES completion:NULL];
    } else {
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard Notifications

- (void)keyboardDidAppear:(NSNotification*)notification {
        
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.bottom  = keyboardHeight;
        self.scrollView.contentInset = inset;
    } completion:^(BOOL finished) {
        if (finished) {
            [self shiftFields];
        }
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

- (void)keyboardDidChange:(NSNotification*)notification {

    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.bottom  = keyboardHeight;
        self.scrollView.contentInset = inset;
    }];
}

#pragma mark - Helpers

- (void)shiftFields {
    
    CGRect rect = [self.scrollView convertRect:self.loginButton.frame fromView:self.loginButton];
    rect.size.height += rect.size.height;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
