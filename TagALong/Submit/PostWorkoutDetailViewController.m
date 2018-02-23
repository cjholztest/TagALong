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

@interface PostWorkoutDetailViewController ()<UITextFieldDelegate, UITextViewDelegate>{
    NSString *title;
    NSString *location;
    NSString *date;
    NSString *startTime;
    NSString *duration;
    NSString *content;
    NSString *amount;
    NSInteger nPicType; // 1:starttime, 2:duration
    NSInteger startindex; //time picer start idnex
    NSInteger startTimeindex;
    NSInteger durationindex;
    NSMutableArray *arrStartTime;
    NSMutableArray *arrDuration;
    NSArray *arrSportNM;
}
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

@end

@implementation PostWorkoutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
//    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth",  @"Other Sports/Equipment", nil];
    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    
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
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    startTime = [NSString stringWithFormat:@"%02ld:%02ld", (row * 30) / 60, (row * 30) % 60];
    if (nPicType == 1) {
        startTime = arrStartTime[row];
        startTimeindex = startindex + row ;
    } else {
        duration = arrDuration[row];
        durationindex = row + 1;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (nPicType == 1) {
        return arrStartTime.count;
    } else {
        return arrDuration.count;
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
    } else {
        strTitle = arrDuration[row];
    }
    
    return strTitle;
}


- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    if (keyboardFrameBeginRect.size.height > 0) {
        //_lcsvBottomHeight.constant = keyboardFrameBeginRect.size.height;
        _lcbnBottomHeight.constant = keyboardFrameBeginRect.size.height;
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
        
    }
}

- (void)keyboardDidHide: (NSNotification *) notif{
//    _lcsvBottomHeight.constant = 0;
    _lcbnBottomHeight.constant = 0;
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.view layoutIfNeeded];
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
    title = @"";
    location = @"";
    date = @"";
    startTime = @"";
    duration = @"";
    content = @"";
    amount = @"";
    startTimeindex = 0;
    durationindex = 0;
    
    arrStartTime = [[NSMutableArray alloc] init];
    arrDuration = [[NSMutableArray alloc] init];
    
    _btnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnStartTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDuration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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

#pragma mark - click events

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)onClickPostworkout:(id)sender {
    [self ReqReqWorkout];
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
        startTime = @"00:00";
        startTimeindex= 0;
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
    
    
    //현재 시간 얻기
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:[NSDate date]];
//    
//    NSInteger hour = [components hour];
//    NSInteger min = [components minute];
    
    [arrStartTime removeAllObjects];
    
    //현재 시간을 가지고 조합
    NSInteger index = 0;

//    if (min < 15) {
//        index = hour * 4 + 1;
//    } else if (min >= 15 && min < 30){
//        index = hour * 4 + 2;
//    } else if (min >= 30 && min < 45){
//        index = hour * 4 + 3;
//    } else if (min >= 45 ){
//        index = (hour + 1) * 4;
//    }
    
    for (NSInteger i = index; i < 96; i++) {
        NSString *temp = @"";
        if (i >= 48) {
            temp = [NSString stringWithFormat:@"%0ld:%02ld pm", ((i - 48) * 15) / 60 , ((i - 48) * 15) % 60];
        } else {
            temp = [NSString stringWithFormat:@"%0ld:%02ld am", (i * 15) / 60, (i * 15) % 60];
        }
        
        [arrStartTime addObject:temp];
    }
    startindex = index;
    [_picStartTime reloadAllComponents];

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
    
    for (NSInteger i = 1; i < (96 - startTimeindex); i++) {
        NSString *temp = @"";
        if ((i * 15) / 60 == 0) {
            temp = [NSString stringWithFormat:@"%0ld min", (i  * 15) % 60];
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
        duration = @"00:00";
        durationindex= 0;
    }

    [_btnDuration setTitle:duration forState:UIControlStateNormal];
}

-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"You posted your workout successfully" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated: NO];
                                    [self.delegate dismiss];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
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
        title = [NSString stringWithFormat:@"%@ with %@ %@", arrSportNM[index - 1], Global.g_user.user_nck, Global.g_user.user_last_nm];
    } else {
        _uid = [NSString stringWithFormat:@"%d", Global.g_expert.export_uid];
        index = [_sport_uid intValue];
        title = [NSString stringWithFormat:@"%@ with %@ %@", arrSportNM[index - 1], Global.g_expert.export_nck, Global.g_expert.export_last_nm];
    }
    
    CLLocationCoordinate2D code = [Commons geoCodeUsingAddress:location];
    double latitude = code.latitude;
    double longitude = code.longitude;
    
    NSString *sport_uid = self.sport_uid;
    NSString *categories = self.categories;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_REGISTER_WORKOUT,
                             API_REQ_KEY_USER_UID           :   _uid,
                             API_REQ_KEY_LOGIN_TYPE         :   Global.g_user.user_login,
                             API_REQ_KEY_SPORT_UID          :   sport_uid,
                             API_REQ_KEY_CATEGORIES         :   categories,
                             API_REQ_KEY_TITLE              :   title,
                             API_REQ_KEY_WORKOUT_DATE       :   date,
                             API_REQ_KEY_START_TIME         :   [NSString stringWithFormat:@"%ld", (long)startTimeindex],
                             API_REQ_KEY_DURATION           :   [NSString stringWithFormat:@"%ld", (long)durationindex],
                             API_REQ_KEY_AMOUNT             :   amount,
                             API_REQ_KEY_ADDITION           :   content,
                             API_REQ_KEY_USER_LOCATION      :   location,
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude],
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
            
            [self showSuccessAlert];
            
            //[Commons showToast:@"Register workout success!"];
            
            //[self.navigationController popViewControllerAnimated:NO];
            //[self.delegate dismiss];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
            
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
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

@end
