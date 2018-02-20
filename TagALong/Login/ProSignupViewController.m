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
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [self ReqGetSportList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

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

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    if (keyboardFrameBeginRect.size.height > 0) {
        _lcsvbottomHeight.constant = keyboardFrameBeginRect.size.height;
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
        
    }
}

- (void)keyboardDidHide: (NSNotification *) notif{
    _lcsvbottomHeight.constant = 0;
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
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
    [_tfPhone resignFirstResponder];
    [_tfCommunication resignFirstResponder];
    [_tfPass resignFirstResponder];
    [_tfInfo resignFirstResponder];
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

    if (_tfPhone.text.length == 0) {
        [Commons showToast:@"Input phone num!"];
        return NO;
    }
    
    if (_tfPass.text.length == 0) {
        [Commons showToast:@"Input password"];
        return NO;
    }
    
   
    return YES;
}


#pragma mark - click events
- (IBAction)onClickSubmit:(id)sender {
    
    if ([self CheckValidForRegister]) {
        [self ReqExpertRegister];
    }
  
}

- (IBAction)onClickback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickSport:(id)sender {
    
    [_vwSportSelect setHidden:NO];
}

- (IBAction)onclickSportSelconfirm:(id)sender {
    [_vwSportSelect setHidden:YES];
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

#pragma mark - Network
-(void)ReqExpertRegister{
    NSString *_email = _tfEmail.text;
    NSString *_name = _tfFirstName.text;
    NSString *_lastname = _tfLastName.text;
    NSString *_phone    = _tfPhone.text;
    NSString *_pwd      = _tfPass.text;
    NSString *_sport     = [NSString stringWithFormat:@"%ld", (long)nSelSportID];
    NSString *_communication     = _tfCommunication.text;
    NSString *_info     = _tfInfo.text;
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_EXPoRT_REGISTER,
                             API_REQ_KEY_USER_NICKNAME      :   _name,
                             API_REQ_KEY_USER_LAST_NAME     :   _lastname,
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_USER_PHONE         :   _phone,
                             API_REQ_KEY_USER_PWD           :   _pwd,
                             API_REQ_KEY_COMMUNICATION      :   _communication,
                             API_REQ_KEY_SPORT_UID          :   _sport,
                             API_REQ_KEY_CONTENT            :   _info,
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
            
            SignupResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignupResultViewController"];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (res_code == RESULT_ERROR_PHONE_NUM_DUPLICATE){
            [Commons showToast:@"This Phone has been duplicated"];
        } else if (res_code == RESULT_ERROR_NICKNAME_DUPLICATE){
            [Commons showToast:@"This nickname has been duplicated"];
        } else if (res_code == RESULT_ERROR_EMAIL_DUPLICATE){
            [Commons showToast:@"This email has been duplicated"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];

}

-(void)ReqGetSportList{

    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_GET_SPORT
                             };
    
    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
        NSLog(@"JSON: %@", respObject);
        NSError* error;
        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
                                                                       options:kNilOptions
                                                                         error:&error];
        
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
    }];
    
}
@end
