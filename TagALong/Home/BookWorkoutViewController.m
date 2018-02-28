//
//  BookWorkoutViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "BookWorkoutViewController.h"
#import "PaymentViewController.h"

@interface BookWorkoutViewController ()<PaymentViewControllerDelegate>{
    NSArray *arrSportNM;
    NSArray *arrCateNM;
    NSInteger amount;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UIView *vwLevelBG;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;
@property (weak, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSport;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkType;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnWorkout;
@property (weak, nonatomic) IBOutlet UIImageView *bigArrowIcon;

@end

@implementation BookWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth",  @"Other Sports/Equipment", nil];
    arrCateNM = [NSArray arrayWithObjects: @"Cardio", @"Flexibility", @"Strength", @"High intensity", @"Balance", @"Weights", @"Interval/Circuit", @"Conditioning", nil];

    _ivProfile.layer.cornerRadius = _ivProfile.frame.size.width / 2;
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        if (_bProfile) {
            [_btnWorkout setHidden:YES];
        } else {
            [_btnWorkout setHidden:NO];
        }
    } else {
        [_btnWorkout setHidden:YES];
    }
    [self ReqWorkoutInfo];    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _ivProfile.layer.cornerRadius = _ivProfile.bounds.size.height / 2;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//PaymentViewController delegate
-(void)dismiss{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - user defined functions
-(void)setData:(NSDictionary*)workInfo profile:(NSDictionary*)profileInfo{
    
    //profile info
    NSString *first_name = @"";
    NSString *last_name = @"";
    
    if (![[profileInfo objectForKey:API_RES_KEY_NICKNAME] isEqual:[NSNull null]]) {
        first_name = [profileInfo objectForKey:API_RES_KEY_NICKNAME];
    }
    
    if (![[profileInfo objectForKey:API_RES_KEY_LASTNAME] isEqual:[NSNull null]]) {
        last_name = [profileInfo objectForKey:API_RES_KEY_LASTNAME];
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    //_lblNickName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    _lblAddress.text = [profileInfo objectForKey:API_RES_KEY_USER_LOCATION];
    _lblPhoneNum.text = [profileInfo objectForKey:API_RES_KEY_PHONE_NUM];
    if ([[profileInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [profileInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    NSString *level = [profileInfo objectForKey:API_RES_KEY_LEVEL];
    if ( [level isEqualToString:@"0"] )  { //individual
        _vwLevelBG.backgroundColor = [UIColor whiteColor];
        _lblLevel.text = @"INDIVIDUAL";
        _lblLevel.textColor = [UIColor blackColor];
    } else if ([level isEqualToString:@"1"]) { //gym
        _vwLevelBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblLevel.text = @"GYM";
        _lblLevel.textColor = [UIColor whiteColor];
    } else if ([level isEqualToString:@"2"]) { //pro
        _vwLevelBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
        _lblLevel.text = @"PRO";
        _lblLevel.textColor = [UIColor blackColor];
        
    } else if ( [level isEqualToString:@"3"]) { //trainer
        _vwLevelBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblLevel.text = @"TRAINER";
        _lblLevel.textColor = [UIColor whiteColor];
    }
    
    //workout info
    _lblTitle.text = [workInfo objectForKey:API_RES_KEY_TITLE];
    
    NSInteger sport_uid = [[workInfo objectForKey:API_RES_KEY_SPORT_UID] integerValue];
    _lblWorkType.text = arrSportNM[sport_uid - 1];
    
    _lblLocation.text = [workInfo objectForKey:API_RES_KEY_USER_LOCATION];
    NSInteger duration = [[workInfo objectForKey:API_REQ_KEY_DURATION] integerValue];
    _lblDuration.text = [NSString stringWithFormat:@"%ld Mins", (duration - 1) * 15];
    
    NSInteger time = [[workInfo objectForKey:API_RES_KEY_START_TIME] integerValue];
//    if (time % 4 == 0) {
//        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02d" ,time / 4, 0];
//    } else if (time % 4 == 1) {
//        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02d" ,time / 4, 15];
//    } else if (time % 4 == 2) {
//        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02d" ,time / 4, 30];
//    } else {
//        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02d" ,time / 4, 45];
//    }
//    
    if ((time * 15) / 60 > 12) {
        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02ld pm", (time * 15) / 60 - 12 , (time * 15) % 60];
    } else {
        _lblStartTime.text = [NSString stringWithFormat:@"%02ld:%02ld am", (time * 15) / 60 , (time * 15) % 60];
    }

    
    amount = [[workInfo objectForKey:API_RES_KEY_AMOUNT] intValue];
    _lblPrice.text = [NSString stringWithFormat:@"$%@", [NSString stringWithFormat:@"%ld", (long)amount]];;
    
    //CATEGORY
    NSString *categories = [workInfo objectForKey:API_RES_KEY_CATEGORIES] ;
    NSArray *arrCate = [categories componentsSeparatedByString:@","];
    NSString *category = @"";
    for (int i = 0; i < arrCate.count; i++) {
        NSInteger index = [arrCate[i] integerValue];
        category = [NSString stringWithFormat:@"%@%@, ", category, arrCateNM[index - 1]];
    }
    _lblSport.text = [category stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]];
    
    //date
    NSString *nsdate = [workInfo objectForKey:API_RES_KEY_WORKOUT_DATE] ;
    NSDateFormatter *dateConvertor = [[NSDateFormatter alloc] init];
    [dateConvertor setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    dateformat.dateStyle = kCFDateFormatterFullStyle;
    dateformat.timeStyle = NSDateFormatterNoStyle;
    NSString *result = [dateformat stringFromDate:[dateConvertor dateFromString:nsdate]];
    _lblDate.text = result;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bigArrowIcon.alpha = 1;
    }];
}

#pragma mark - click events

- (IBAction)onClickWorkout:(id)sender {
    [self ReqBookNoew];
//    if ([self.where isEqualToString:@"profile"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExportProfile" object:nil];
//    }
//    [self.navigationController popViewControllerAnimated:NO];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
}

- (IBAction)onClickCancel:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Network
-(void)ReqWorkoutInfo{
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_DETAIL_WORKOUT,
                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%d", Global.g_user.user_uid],
                             API_REQ_KEY_WORKOUT_UID        :   self.workout_id,
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
            
            NSDictionary *workout_info = [responseObject objectForKey:API_RES_KEY_WORKOUT_INFO];
            NSDictionary *profile_info = [responseObject objectForKey:API_RES_KEY_PROFILE_INFO];
            
            [self setData:workout_info profile:profile_info];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

-(void)ReqBookNoew{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_USR_BOOKING,
                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%d", Global.g_user.user_uid],
                             API_REQ_KEY_WORKOUT_UID        :   self.workout_id,
                             API_REQ_KEY_AMOUNT             :   [NSString stringWithFormat:@"%ld", (long)amount],
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
            
//            PaymentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PaymentViewController"];
//            vc.delegate = self;
//            [self.navigationController pushViewController:vc animated:YES];
            if ([self.where isEqualToString:@"profile"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ExportProfile" object:nil];
            }
            [self showSuccessAlert];
            //MARK: Pop up
//            [self.navigationController popViewControllerAnimated:YES];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];

        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }  else if(res_code == RESULT_ERROR_ALREADY_BOOKED){
            [Commons showToast:@"Already booked"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

-(void)showSuccessAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"You booked successfully" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Great"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
