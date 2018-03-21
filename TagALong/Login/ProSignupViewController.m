//
//  ProSignupViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "ProSignupViewController.h"
#import "SignupResultViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ProSignupViewController ()<UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate, SignupResultViewControllerDelegate>{
    double latitude;
    double longitude;
    NSString *SelSportNM;
    NSInteger nSelSportID;
    UITextField *activeField;
    UITextView *activeTextView;
}
@property (nonatomic, strong) NSMutableArray *arrSport;
@property (strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property (strong, nonatomic) IBOutlet UITextField *tfLastName;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfPhone;
@property (strong, nonatomic) IBOutlet UITextField *tfCommunication;
@property (strong, nonatomic) IBOutlet UITextView *tfInfo;
@property (strong, nonatomic) IBOutlet UITextField *tfPass;
@property (weak, nonatomic) IBOutlet UIButton *bnsport;

@property (weak, nonatomic) IBOutlet UIView *vwSportSelect;
@property (weak, nonatomic) IBOutlet UIPickerView *picSport;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcsvbottomHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ProSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_vwSportSelect setHidden:YES];
    _arrSport = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [self ReqGetSportList];
    [self setupTextFieldsDelegate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
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

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)setupTextFieldsDelegate {
    self.tfPass.delegate = self;
    self.tfEmail.delegate = self;
    self.tfPhone.delegate = self;
    self.tfLastName.delegate = self;
    self.tfFirstName.delegate = self;
    self.tfCommunication.delegate = self;
    self.tfInfo.delegate = self;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    if (activeField != nil) {
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    } else if (activeTextView != nil) {
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height + kbSize.height);
        [self.scrollView setContentOffset:bottomOffset animated:YES];
    }

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    activeTextView = textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    activeTextView = nil;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height) animated:YES];
}

//signup result delegate
-(void)dismiss{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"THANK YOU" message:@"Due to the qualification and approval process someone from TAG-A-LONG will contact you within next 24 hours" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Great"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - user defined functions
-(void)hideKeyboard {
    [_tfFirstName resignFirstResponder];
    [_tfLastName resignFirstResponder];
    [_tfEmail resignFirstResponder];
    [_tfPhone resignFirstResponder];
    [_tfCommunication resignFirstResponder];
    [_tfPass resignFirstResponder];
    [_tfInfo resignFirstResponder];
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
    
    if ([_tfPhone.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input phone number!"];
        return NO;
    }
    
    if (![Commons checkPhoneNumber:_tfPhone.text]) {
        [Commons showToast:@"The phone number should be in format +XXXXXXXXXXXX"];
        return NO;
    }
    
    if ([_tfPass.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length == 0) {
        [Commons showToast:@"Input password"];
        return NO;
    }
    
    if ([_tfPass.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length < 5) {
        [Commons showToast:@"The password must be at least 5 symbols length"];
        return NO;
    }
    return YES;
}


#pragma mark - click events
- (IBAction)onClickSubmit:(id)sender {
    
    [self hideKeyboard];
    if ([self CheckValidForRegister]) {
        [self ReqExpertRegister];
    }
    
}

- (IBAction)onClickback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickSport:(id)sender {
    [self hideKeyboard];
    [_vwSportSelect setHidden:NO];
}

- (IBAction)onclickSportSelconfirm:(id)sender {
    [_vwSportSelect setHidden:YES];
    if (SelSportNM == nil) {
        NSDictionary *dic = _arrSport[0];
        SelSportNM = [dic objectForKey:API_RES_KEY_SPORT_NAME];
    }
    [_bnsport setTitle:SelSportNM forState:UIControlStateNormal];
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDictionary *dic = _arrSport[row];
    SelSportNM = [dic objectForKey:API_RES_KEY_SPORT_NAME];
    nSelSportID = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _arrSport.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rowSize.width, rowSize.height)];
    }
    
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    UIFont *font = [ UIFont fontWithName:@"Apple SD Gothic Neo"  size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.1;
    
    label.textColor = [UIColor colorWithRed:(0 / 255.f) green:(0/ 255.f) blue:(0/ 255.f) alpha:1.0];
    
    return label;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *strTitle = nil;
    NSDictionary *dic = _arrSport[row];
    strTitle = [dic objectForKey:API_RES_KEY_SPORT_NAME];
    
    return strTitle;
}

-(void)showAlert:(NSString *)message needToClose:(BOOL)needToClose {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    if (needToClose) {
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Network
-(void)ReqExpertRegister{
        
        NSString *_email = [_tfEmail.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_name = [_tfFirstName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_lastname = [_tfLastName.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_phone    = [_tfPhone.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_pwd      = [_tfPass.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_sport     = [NSString stringWithFormat:@"%ld", (long)nSelSportID];
        NSString *_communication     = [_tfCommunication.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSString *_info     = [_tfInfo.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        
        [SharedAppDelegate showLoading];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"export_register"];
        
        NSDictionary *params = @{
                                 API_REQ_KEY_USER_NICKNAME      :   _name,
                                 API_REQ_KEY_USER_LAST_NAME     :   _lastname,
                                 API_REQ_KEY_USER_EMAIL         :   _email,
                                 API_REQ_KEY_USER_PHONE         :   _phone,
                                 API_REQ_KEY_USER_PWD           :   _pwd,
                                 API_REQ_KEY_COMMUNICATION      :   _communication,
                                 API_REQ_KEY_SPORT_UID          :   _sport,
                                 API_REQ_KEY_CONTENT            :   _info,
                                 };
        
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
            NSLog(@"JSON: %@", respObject);
            
            [SharedAppDelegate closeLoading];
            
            int res_code = [[respObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
            if (res_code == RESULT_CODE_SUCCESS) {
                
                //            [Commons showToast:@"Congratulations on your joining."];
                //            [self.navigationController popViewControllerAnimated:NO];
                
                [self showSuccessAlert];
                
            } else if (res_code == RESULT_ERROR_EMAIL_DUPLICATE){
                [self showAlert:@"This email is in use" needToClose:NO];
                //[Commons showToast:@"This email is in use."];
            } else if (res_code == RESULT_ERROR_PHONE_NUM_DUPLICATE){
                [self showAlert:@"This phone number is in use" needToClose:NO];
                //[Commons showToast:@"This Phone has been duplicated"];
            } else if (res_code == RESULT_ERROR_NICKNAME_DUPLICATE){
                [self showAlert:@"This nickname is in use" needToClose:NO];
                //[Commons showToast:@"This nickname has been duplicated"];
            } else if (res_code == RESULT_ERROR_PARAMETER) {
                [self showAlert:@"Please input personal info in correct format" needToClose:NO];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
            [SharedAppDelegate closeLoading];
            [self showAlert:@"Failed to communicate with the server" needToClose:NO];
        }];
}

-(void)ReqGetSportList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_GET_SPORT];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        NSLog(@"sdfasdf: %@", responseObject);
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            _arrSport = [responseObject objectForKey:API_RES_KEY_SPORT_LIST];
            [_picSport reloadAllComponents];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [self showAlert:@"Failed to communicate with the server" needToClose:YES];
    }];
}
@end
