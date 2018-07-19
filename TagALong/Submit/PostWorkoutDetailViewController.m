//
//  PostWorkoutDetailViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "PostWorkoutDetailViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "ProfilePaymentDataViewController.h"
#import "EditDialogViewController.h"
#import "PaymentClient+Customer.h"
#import "PaymentClient+CreditCard.h"
#import "UIColor+AppColors.h"
#import "AddCreditCardViewController.h"
#import "NSObject+CheckEmpty.h"

static const NSInteger kPostWorkoutDefaultTag = 234;
static const NSInteger kPostWorkoutPaymentAccountTag = 254;
static const NSInteger kPostWorkoutPaymentCreditTag = 274;
static const NSInteger kAddtitonalInfoTextViewTag = 289;

@interface PostWorkoutDetailViewController ()<UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate, ProfilePaymentDataModuleDelegate, EditDialogViewControllerDelegate, AddCreditCardModuleDelegate>{
    NSString *title;
    NSString *location;
    NSString *date;
    NSString *startTime;
    NSString *duration;
    NSString *content;
    NSString *amount;
    NSInteger nPicType; // 1:starttime, 2:duration, 3:frequency
    NSInteger startindex; //time picer start idnex
    NSInteger startTimeindex;
    NSInteger durationindex;
    NSMutableArray *arrStartTime;
    NSMutableArray *arrDuration;
    NSArray *arrSportNM;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *userLocation;
    
    NSArray *frequencies;
    NSInteger frequencyIndex;
    NSString *enteredPassword;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btnDuration;

@property (strong, nonatomic) IBOutlet UITextView *tvContent;
@property (strong, nonatomic) IBOutlet UIImageView *vwBlueBG;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lcvwAmountHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lcvwAmountBottom;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;

//Date View
@property (weak, nonatomic) IBOutlet UIView *vwDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *picDate;
//Time view
@property (weak, nonatomic) IBOutlet UIView *vwStartTime;
@property (weak, nonatomic) IBOutlet UIPickerView *picStartTime;
//Duration View
@property (weak, nonatomic) IBOutlet UIView *vwDuration;
@property (weak, nonatomic) IBOutlet UIPickerView *picDuration;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcsvBottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcbnBottomHeight;
@property (weak, nonatomic) IBOutlet UIButton *postWorkoutButton;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIView *vwFrequency;
@property (weak, nonatomic) IBOutlet UIButton *btnFrequency;
@property (weak, nonatomic) IBOutlet UIPickerView *picFrequency;

@property (strong, nonatomic) UITextView *activeTextView;

@end

@implementation PostWorkoutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initUI];
//    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth",  @"Other Sports/Equipment", nil];
    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    
    frequencies = [NSArray arrayWithObjects:@{@"title": @"Just This One", @"id": @"0"}, @{@"title": @"Every day", @"id": @"1"}, @{@"title": @"Every week", @"id": @"7"}, nil];

    
//    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(showLoctionPopup)];
//    [self.tfLocation addGestureRecognizer:tapRecog];

    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    self.tfAmount.keyboardType = UIKeyboardTypeDecimalPad;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    startTime = [NSString stringWithFormat:@"%02ld:%02ld", (row * 30) / 60, (row * 30) % 60];
    if (nPicType == 1) {
        startTime = arrStartTime[row];
        startTimeindex = startindex + row;
    } else if (nPicType == 2) {
        duration = arrDuration[row];
        durationindex = row + 1;
    } else {
        frequencyIndex = row;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (nPicType == 1) {
        return arrStartTime.count;
    } else if (nPicType == 2) {
       return arrDuration.count;
    } else {
        return frequencies.count;
    }
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
    if (nPicType == 1) {
        strTitle = arrStartTime[row];
    } else if (nPicType == 2) {
        strTitle = arrDuration[row];
    } else {
        strTitle = [frequencies[row] objectForKey:@"title"];
    }
    
    return strTitle;
}


- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.bottom = keyboardFrameBeginRect.size.height;
    self.scrollView.contentInset = insets;
    
    if (self.activeTextView.tag == kAddtitonalInfoTextViewTag) {
        CGRect infoViewFrame = self.infoView.frame;
        [self.scrollView scrollRectToVisible:infoViewFrame animated:YES];
    }
}

- (void)keyboardDidHide: (NSNotification *) notif {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         UIEdgeInsets insets = self.scrollView.contentInset;
                         insets.bottom = 0.0f;
                         self.scrollView.contentInset = insets;
                     }];
}


#pragma mark - user defined functions
-(void)initUI{
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [_vwBlueBG setHidden:YES];
        _lcvwAmountHeight.constant = 0;
        _lcvwAmountBottom.constant = 0;
    } else {
        [_vwBlueBG setHidden:NO];
        _lcvwAmountHeight.constant = 51;
        _lcvwAmountBottom.constant = 10;
    }
    
    nPicType = 1;
    [_vwDate setHidden:YES];
    [_vwStartTime setHidden:YES];
    [_vwDuration setHidden:YES];
    [_vwFrequency setHidden:YES];
    title = @"";
    location = @"";
    date = @"";
    startTime = @"";
    duration = @"";
    content = @"";
    amount = @"";
    startTimeindex = 0;
    durationindex = 0;
    frequencyIndex = 0;
    
    arrStartTime = [[NSMutableArray alloc] init];
    arrDuration = [[NSMutableArray alloc] init];
    
    _btnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnStartTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDuration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnFrequency.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.postWorkoutButton.tag = kPostWorkoutDefaultTag;
    self.tvContent.delegate = self;
    self.tvContent.tag = kAddtitonalInfoTextViewTag;
}

-(void)Background:(UITapGestureRecognizer *)recognizer{
    [self downkeyboard];
}

- (void)downkeyboard{
    [_tvContent resignFirstResponder];
    [_tfLocation resignFirstResponder];
    [_tfTitle resignFirstResponder];
    [_tfAmount resignFirstResponder];
    
}

-(BOOL)isEmptyValue{
    BOOL result = TRUE;
    
    amount = _tfAmount.text;
//    if ([title isEqualToString:@""]) {
//        [Commons showToast:@"Input title!"];
//        result = NO;
//    }
    
    location = _tfLocation.text;
    if ([location isEqualToString:@""]) {
        [Commons showToast:@"Input location!"];
        result = NO;
    }
    
    if ([date isEqualToString:@""]) {
        [Commons showToast:@"Select date!"];
        result = NO;
    }
    
    if ([startTime isEqualToString:@""]) {
        [Commons showToast:@"Select time!"];
        result = NO;
    }
    
    
    if ([duration isEqualToString:@""]) {
        [Commons showToast:@"Select duration!"];
        result = NO;
    }
    
    if ([Global.g_user.user_login isEqualToString:@"2"]) {
        if ([amount isEqualToString:@""]) {
            [Commons showToast:@"input amount!"];
            result = NO;
        }
    }
    
    return result;
}

- (void)showPaymentCredentialsRegistration {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    ProfilePaymentDataViewController *profilePaymentVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(ProfilePaymentDataViewController.class)];
    profilePaymentVC.modeType = ProfilPaymentModeTypePostWorkout;
    profilePaymentVC.moduleDelegate = self;
    [self.navigationController pushViewController:profilePaymentVC animated:YES];
}

- (void)showAddCreditCard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    addCreditCardVC.modeType = ProfilPaymentModeTypePostWorkout;
    [self.navigationController pushViewController:addCreditCardVC animated:YES];
}

- (void)showEnterPasswordDialog {
    
    EditDialogViewController *dlgDialog = [[EditDialogViewController alloc] initWithNibName:@"EditDialogViewController" bundle:nil];
    dlgDialog.providesPresentationContextTransitionStyle = YES;
    dlgDialog.definesPresentationContext = YES;
    [dlgDialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDialog.delegate = self;
    
    dlgDialog.type = @"password";
    dlgDialog.content = @"";
    [self presentViewController:dlgDialog animated:NO completion:nil];
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.activeTextView = textView;
    self.activeTextView.tag = kAddtitonalInfoTextViewTag;
    
    if (textView.tag == kAddtitonalInfoTextViewTag) {
        CGRect rectToScroll = self.infoView.frame;
        [self.scrollView scrollRectToVisible:rectToScroll animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeTextView.tag = -1;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    const NSInteger maxCharactersCount = 120;
    
    if (textView.text.length + text.length > maxCharactersCount) {
        return NO;
    }
    
    return YES;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.activeTextView.tag = -1;
    return YES;
}

#pragma mark - EditDialogViewControllerDelegate

- (void)setContent:(NSString*)type msg:(NSString*)content {
    if ([type isEqualToString:@"password"]) {
        enteredPassword = content;
        [self ReqReqWorkout];
    }
}

#pragma mark - click events

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)onClickPostworkout:(id)sender {
    
    BOOL isAmountEmpty = ([amount isEqualToString:@""] || [amount floatValue] == 0.0f);
    
    if ([Global.g_user.user_login isEqualToString:@"2"] && !isAmountEmpty) {
        __weak typeof(self)weakSelf = self;
        [self checkPaymentAccountCredentialsWithCompletion:^(BOOL isPaymentAccountExists, BOOL isCreditCradExists) {
            if (isPaymentAccountExists && isCreditCradExists) {
                [weakSelf ReqReqWorkout];
            } else if (!isPaymentAccountExists && !isCreditCradExists) {
                [weakSelf showPaymentCredentialsRegistration];
            } else if (isPaymentAccountExists && !isCreditCradExists) {
                [weakSelf showAddCreditCard];
            }
        }];
    } else {
        [self ReqReqWorkout];
    }
}

//날자선택 대화창에서 확인단추 클릭
- (IBAction)onClickDateConfirm:(id)sender {
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSString *pickerDate = [dateFormatter stringFromDate:[_picDate date]];
    
    NSString *curdate = [dateFormatter stringFromDate:[NSDate date]];
    
//    NSInteger difference = [pickerDate timeIntervalSinceDate:curdate];
//    if (difference < 0) {
//        [Commons showToast:@"You can not set the time before the current time"];
//        return;
//    }
    NSInteger ncurdate = [curdate integerValue];
    NSInteger npicdate = [pickerDate integerValue];
    
    if ( (npicdate - ncurdate ) < 0) {
        [Commons showToast:@"You can not set the time before the current time"];
        return;
    }

    NSDateFormatter *dateformat1 = [[NSDateFormatter alloc] init];
    [dateformat1 setDateFormat:@"yyyy-MM-dd"];
    date = [dateformat1 stringFromDate:[_picDate date]];

    [_vwDate setHidden:YES];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
    formatter1.dateStyle = kCFDateFormatterLongStyle;
    formatter1.timeStyle = NSDateFormatterNoStyle;
    [_btnDate setTitle:[formatter1 stringFromDate:[_picDate date] ] forState:UIControlStateNormal];
}

- (IBAction)onClickStartTimeConfirm:(id)sender {
    if ([startTime isEqualToString:@""]) {
        startTime = @"8:00 am";
        startTimeindex = startindex + [_picStartTime selectedRowInComponent:0];
        //startTimeindex= 0;
    }

    [_btnStartTime setTitle:startTime forState:UIControlStateNormal];
    [_btnDuration setTitle:@"" forState:UIControlStateNormal];
    [_vwStartTime setHidden:YES];
}

- (IBAction)onClickDate:(id)sender {
    [self downkeyboard];
    [_vwDate setHidden:NO];
    
 }

- (IBAction)onClickStartTime:(id)sender {
    [self downkeyboard];
    nPicType = 1;
    [_vwStartTime setHidden:NO];
    
    [arrStartTime removeAllObjects];
    
    //현재 시간을 가지고 조합
    NSInteger index = 0;
    
    for (NSInteger i = index; i < 96; i++) {
        NSString *temp = @"";
        if (i >= 48) {
            NSInteger hours = ((i - 48) * 15) / 60;
            NSInteger mins = ((i - 48) * 15) % 60;
            if (hours == 0) hours = 12;
            temp = [NSString stringWithFormat:@"%0ld:%02ld pm", hours, mins];
            [arrStartTime addObject:temp];
        } else {
//            if (i == 20 || i == 24 || i == 28 || i >= 32) {
            if (i == 20 || i == 24 || i == 28 || i >= 20) {
                temp = [NSString stringWithFormat:@"%0ld:%02ld am", (i * 15) / 60, (i * 15) % 60];
                [arrStartTime addObject:temp];
            }
        }
    }
    startindex = index;
    [_picStartTime reloadAllComponents];
    [_picStartTime selectRow:3 inComponent:0 animated:YES];
}

- (IBAction)onClickFrequency:(id)sender {
    [self downkeyboard];
    
    if ([duration isEqualToString:@""]) {
        [Commons showToast:@"Please select the duration first"];
        return;
    }
    
    nPicType = 3;
    
    [_vwFrequency setHidden:NO];
    [_picFrequency reloadAllComponents];
}

- (IBAction)onClickFrequencyConfirm:(id)sender {
    [_vwFrequency setHidden:YES];
    
    NSString *title = [frequencies[frequencyIndex] objectForKey:@"title"];
    [_btnFrequency setTitle:title forState:UIControlStateNormal];
}

- (IBAction)onClickDuration:(id)sender {
    [self downkeyboard];
    if ([startTime isEqualToString:@""]) {
        [Commons showToast:@"Please select the start time first"];
        return;
    }
    nPicType = 2;
    [_vwDuration setHidden:NO];
    
    [arrDuration removeAllObjects];
    
    for (NSInteger i = 1; i < 13; i++) {
        NSString *temp = @"";
        if ((i * 15) / 60 == 0) {
            temp = [NSString stringWithFormat:@"%0ldmin", (i  * 15) % 60];
        } else if ((i  * 15) % 60 == 0) {
            temp = [NSString stringWithFormat:@"%0ldh", (i * 15) / 60];
        } else {
            temp = [NSString stringWithFormat:@"%0ldh %0ldmin", (i * 15) / 60, (i  * 15) % 60];
        }
        [arrDuration addObject:temp];
    }
    [_picDuration reloadAllComponents];
}
- (IBAction)onClickDurationConfirm:(id)sender {
    [_vwDuration setHidden:YES];
    
    if ([duration isEqualToString:@""]) {
        duration = @"15min";
        durationindex= 0;
    }

    [_btnDuration setTitle:duration forState:UIControlStateNormal];
}

- (void)showLoctionPopup {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n" message:@"Use Current Location or Input Manually?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *locationAction = [UIAlertAction actionWithTitle:@"Current" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [SharedAppDelegate showLoading];
        locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }];
    UIAlertAction *manualyAction = [UIAlertAction actionWithTitle:@"Input" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tfLocation becomeFirstResponder];
    }];
    
    [alertVC addAction:manualyAction];
    [alertVC addAction:locationAction];
    
    if (!self.tfLocation.isEditing) {
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"You posted your workout successfully" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Great"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated: NO];
                                    [self.delegate dismiss];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSString *)generateWorkoutTitle {
    NSMutableString *tempTitle = [NSMutableString new];
    
    NSString * newString = [_sport_uid stringByReplacingOccurrencesOfString:@"," withString:@""];
 
    for (int i = 0; i < newString.length; i++) {
        char value = [newString characterAtIndex:i];
        
        NSString *workoutName = arrSportNM[[[NSString stringWithFormat:@"%c", value] intValue] - 1];
        
        [tempTitle appendString:workoutName];
        [tempTitle appendString:@", "];
    }
    
    return [tempTitle substringToIndex:tempTitle.length - 2];
}

#pragma mark - Network
-(void)ReqReqWorkout{
    
    if (![self isEmptyValue]) {
        return;
    }
    
    NSString *_uid = @"";
    int index = 0;
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        _uid = [NSString stringWithFormat:@"%d", Global.g_user.user_uid];
        index = [_sport_uid intValue];
        
        title = [NSString stringWithFormat:@"%@ with %@ %@", [self generateWorkoutTitle], Global.g_user.user_nck, Global.g_user.user_last_nm];
    } else {
        _uid = [NSString stringWithFormat:@"%d", Global.g_expert.export_uid];
        index = [_sport_uid intValue];
        title = [NSString stringWithFormat:@"%@ with %@ %@", [self generateWorkoutTitle], Global.g_expert.export_nck, Global.g_expert.export_last_nm];
    }
    
    content = _tvContent.text;
    
    double latitude;
    double longitude;
    
    if (userLocation != nil) {
        latitude = userLocation.coordinate.latitude;
        longitude = userLocation.coordinate.longitude;
    } else {
        CLLocationCoordinate2D code = [Commons geoCodeUsingAddress:location];
        latitude = code.latitude;
        longitude = code.longitude;
    }
    
    NSNumber *price = [NSNumber numberWithInteger:0];
    if (amount != nil && ![amount  isEqual: @""]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        price = [formatter numberFromString:amount];
    } else {
        price = [NSNumber numberWithInteger:0];
    }
    
    NSString *sport_uid = self.sport_uid;
    NSString *categories = self.categories;
    NSString *freqIndex = [frequencies[frequencyIndex] objectForKey:@"id"];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_REGISTER_WORKOUT];
    
    NSDictionary *params = @{API_REQ_KEY_LOGIN_TYPE         :   Global.g_user.user_login,
                             API_REQ_KEY_SPORT_UID          :   sport_uid,
                             API_REQ_KEY_CATEGORIES         :   categories,
                             API_REQ_KEY_TITLE              :   title,
                             API_REQ_KEY_WORKOUT_DATE       :   date,
                             API_REQ_KEY_START_TIME         :   startTime,
                             API_REQ_KEY_DURATION           :   duration,
                             API_REQ_KEY_FREQUENCY          :   freqIndex,
                             API_REQ_KEY_AMOUNT             :   price,
                             API_REQ_KEY_ADDITION           :   content,
                             API_REQ_KEY_USER_LOCATION      :   location,
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude]};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [self showSuccessAlert];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:[responseObject objectForKey:API_RES_KEY_MSG]];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:[responseObject objectForKey:API_RES_KEY_MSG]];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:[responseObject objectForKey:API_RES_KEY_MSG]];
        }  else if(res_code == RESULT_ERROR_WORKOUT_DUPLICATE){
            [Commons showToast:[responseObject objectForKey:API_RES_KEY_MSG]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError *jsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        
        NSString *resultMessage = dict[@"error"][@"message"];
        if (!resultMessage) {
            resultMessage = error.localizedDescription ? error.localizedDescription : @"Failed to communicate with the server";
        }
        [SharedAppDelegate closeLoading];
        [Commons showToast:resultMessage];
    }];
}

- (void)checkPaymentAccountCredentialsWithCompletion:(void(^)(BOOL isPaymentAccountExists, BOOL isCreditCradExists))completion {
    [SharedAppDelegate showLoading];
    
    __block BOOL isAccountExists = NO;
    __block BOOL isCreditExists = NO;
    
    [PaymentClient expertPaymentDataWithCompletion:^(id responseObject, NSError *error) {
        BOOL isDataExists = [responseObject[@"exist"] boolValue];
        if (isDataExists) {
            isAccountExists = YES;
            [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
                [SharedAppDelegate closeLoading];
                NSArray *cards = responseObject;
                if (cards.count != 0) {
                    isCreditExists = YES;
                }
                if (completion) {
                    completion(isAccountExists, isCreditExists);
                }
            }];
        } else {
            [SharedAppDelegate closeLoading];
            if (completion) {
                completion(isAccountExists, isCreditExists);
            }
        }
    }];
}

//MARK: CLLocationManager

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                
                NSMutableString *address = [NSMutableString string];
                
                if ([placemark.subThoroughfare isNotEmpty]) {
                    [address appendString:placemark.subThoroughfare];
                }
                
                if ([placemark.thoroughfare isNotEmpty]) {
                    if (address.length > 0) {
                        [address appendString:@" "];
                    }
                    [address appendString:placemark.thoroughfare];
                }
                
                if ([placemark.locality isNotEmpty]) {
                    if (address.length > 0) {
                        [address appendString:@"\n"];
                    }
                    [address appendString:placemark.locality];
                }
                
                location = address;
                self.tfLocation.text = address;
                userLocation = currentLocation;
                
                [SharedAppDelegate closeLoading];

            } else {
                NSLog(@"%@", error.debugDescription);
            }
        }];
    }
}

#pragma mark - ProfilePaymentDataModuleDelegate

- (void)paymentCredentialsDidSend {
    [self.navigationController popToViewController:self animated:YES];
    [self onClickPostworkout:nil];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self onClickPostworkout:nil];
}

@end
