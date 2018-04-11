//
//  BookWorkoutViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "BookWorkoutViewController.h"
#import "PaymentViewController.h"
#import "PaymentClient.h"
#import "CreditCardListViewController.h"
#import "ListOfWorkoutVisitorsViewController.h"
#import "PaymentClient+Pay.h"
#import "EditDialogViewController.h"
#import "PaymentClient+CreditCard.h"
#import "UIViewController+Alert.h"
#import "AddCreditCardViewController.h"

@interface BookWorkoutViewController ()<PaymentViewControllerDelegate, EditDialogViewControllerDelegate, AddCreditCardModuleDelegate>{
    NSArray *arrSportNM;
    NSArray *arrCateNM;
    NSInteger amount;
    NSString *enteredPassword;
    NSString *creditCardID;
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
@property (weak, nonatomic) IBOutlet UIButton *btnShowVisitors;
@property (weak, nonatomic) IBOutlet UIImageView *bigArrowIcon;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberImageView;
@property (weak, nonatomic) IBOutlet UIView *additionalNoteView;
@property (weak, nonatomic) IBOutlet UILabel *additionalNotesLabel;

@end

@implementation BookWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneNumberDidTap)];
    [self.lblPhoneNum addGestureRecognizer:phoneTap];
    [self.lblPhoneNum setUserInteractionEnabled:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
    arrSportNM = [NSArray arrayWithObjects:@"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    arrCateNM = [NSArray arrayWithObjects:@"Cardio", @"Strength", @"High Intensity", @"Balance", @"Weights", @"Intervals", nil];

    _ivProfile.layer.cornerRadius = _ivProfile.frame.size.width / 2;
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        if (_bProfile) {
            [_btnWorkout setHidden:YES];
        } else {
            [_btnWorkout setHidden:NO];
        }
    } else {
        [_btnWorkout setHidden:YES];
        [self.btnShowVisitors setHidden:NO];
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
    _lblAddress.text = [workInfo objectForKey:API_RES_KEY_USER_LOCATION];
    _lblPhoneNum.text = [profileInfo objectForKey:API_RES_KEY_PHONE_NUM];
    self.additionalNotesLabel.text = [workInfo objectForKey:API_REQ_KEY_ADDITION];
    
    self.locationImageView.alpha = _lblAddress.text.length > 0 ? 1.0f : 0.0f;
    self.phoneNumberImageView.alpha = _lblPhoneNum.text.length > 0 ? 1.0f : 0.0f;
    [self.additionalNoteView setHidden:(self.additionalNotesLabel.text.length > 0) ? NO : YES];
    
    if ([[profileInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [profileInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    NSString *level = [[profileInfo objectForKey:API_RES_KEY_LEVEL] stringValue];
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
    
    _lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _lblTitle.numberOfLines = 0;
    
    //workout info
    _lblTitle.text = [workInfo objectForKey:API_RES_KEY_TITLE];

    //NSInteger sport_uid = [[workInfo objectForKey:API_RES_KEY_SPORT_UID] integerValue];
    NSArray *sports = [[NSArray alloc] initWithObjects:[workInfo objectForKey:API_RES_KEY_SPORT_UID], nil];
    int sport_uid = [sports.firstObject intValue];
    _lblWorkType.text = arrSportNM[sport_uid - 1];
    
    _lblLocation.text = [workInfo objectForKey:API_RES_KEY_USER_LOCATION];
    NSString *duration = [workInfo objectForKey:API_REQ_KEY_DURATION];
    _lblDuration.text = duration;
    
    NSString *time = [workInfo objectForKey:API_RES_KEY_START_TIME];

    _lblStartTime.text = time;
    
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
    //_lblSport.text = @"asdjfjdskljfklajsafkldasjflksdnvsjdnfavlskdjflaksvdjfklvsd;jflaksvdfnjl;kdvjflsdknvkjsdfsdafasdfasdfdsfsdafdsafdsafasdfdsafadsfdsafasdfsdf";
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
    
    if ((long)amount == 0.0f) {
        [self ReqBookNoew];
    } else {
        __weak typeof(self)weakSelf = self;
        [self requestCardInfoWithCompletion:^(NSString *cardID) {
            if (cardID) {
                creditCardID = cardID;
                [weakSelf showConfirmBookPayWorkoutAlert];
            } else {
                [weakSelf showAddCreditCard];
            }
        }];
    }
}

- (IBAction)onClickCancel:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)onClickShowVisitors:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListOfWorkoutVisitorsViewController *visitorsVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ListOfWorkoutVisitorsViewController class])];
    visitorsVC.workoutID = self.workout_id;
    [self.navigationController pushViewController:visitorsVC animated:YES];
}

- (void)phoneNumberDidTap {
    [self.lblPhoneNum setUserInteractionEnabled:NO];
    [self performSelector:@selector(enablePhoneLabel) withObject:nil afterDelay:3.0];
    if (self.lblPhoneNum.text.length > 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.lblPhoneNum.text]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)enablePhoneLabel {
    [self.lblPhoneNum setUserInteractionEnabled:YES];
}

#pragma mark - Network
-(void)ReqWorkoutInfo{
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"detail_workout"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_WORKOUT_UID: self.workout_id,
                             };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    
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
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USR_BOOKING];
    
    NSDictionary *params = @{
                             API_REQ_KEY_WORKOUT_UID        :   [NSString stringWithFormat:@"%@", self.workout_id],
                             API_REQ_KEY_AMOUNT             :   [NSString stringWithFormat:@"%ld", (long)amount],
                             };
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        NSError* error;
//        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                       options:kNilOptions
//                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
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

- (void)requestCardInfoWithCompletion:(void(^)(NSString *cardID))completion {
    
    __weak typeof(self)weakSelf = self;
    [SharedAppDelegate showLoading];
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        [SharedAppDelegate closeLoading];
        if (error) {
            [weakSelf showAlert:error.localizedDescription];
        } else {
            NSArray *cardList = responseObject;
            NSString *ccUIID = nil;
            
            if (cardList.count > 0) {
                NSDictionary *card = cardList.firstObject;
//                creditCardID = card[@"card_uid"];
                ccUIID = card[@"card_uid"];
                //                [weakSelf showEnterPasswordDialog];
//                [weakSelf bookPayWorkout];
            }
            
            if (completion) {
                completion(ccUIID);
            }
            
//            else {
//                [weakSelf showAddCreditCard];
//            }
            
        }
    }];
}

- (void)bookPayWorkout {
    
    NSNumber *workoutID = (NSNumber*)self.workout_id;
    NSDictionary *params = @{@"workout_uid" : [workoutID stringValue],
                             @"amount" : @(amount),
                             @"user_card_uid" : creditCardID};
    
    __weak typeof(self)weakSelf = self;
    [SharedAppDelegate showLoading];
    
    [PaymentClient payForWorkoutWithParams:params withCompletion:^(id responseObject, NSError *error) {
        [SharedAppDelegate closeLoading];
        if (error) {
            [weakSelf showAlert:error.localizedDescription];
        } else {
            if ([responseObject[@"status"] boolValue]) {
                [weakSelf showSuccessAlert];
            } else {
                [weakSelf showAlert:@"Failure payment process"];
            }
        }
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

- (void)showConfirmBookPayWorkoutAlert {
    
    CGFloat price = (CGFloat)amount;
    
    NSString *title = @"BOOK CONFIRMATION";
    NSString *message = [NSString stringWithFormat:@"Your card will be charged $%.2f for booking a workout. Confirm withdrawal of funds?", price];
    
    __weak typeof(self)weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [weakSelf bookPayWorkout];
                                }];
    UIAlertAction* canceButton = [UIAlertAction actionWithTitle:@"No"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:nil];
    
    [alert addAction:yesButton];
    [alert addAction:canceButton];
    [self presentViewController:alert animated:YES completion:nil];
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

- (void)showAddCreditCard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    addCreditCardVC.modeType = AddCreditCardtModeTypePostWorkout;
    [self.navigationController pushViewController:addCreditCardVC animated:YES];
}

#pragma mark - EditDialogViewControllerDelegate

- (void)setContent:(NSString*)type msg:(NSString*)content {
    if ([type isEqualToString:@"password"]) {
        enteredPassword = content;
        NSNumber *workoutID = (NSNumber*)self.workout_id;
        NSDictionary *params = @{@"workout_uid" : [workoutID stringValue],
                                 @"amount" : @(amount),
                                 @"user_card_uid" : creditCardID,
                                 @"password" : enteredPassword};
        __weak typeof(self)weakSelf = self;
        [SharedAppDelegate showLoading];
        [PaymentClient payForWorkoutWithParams:params withCompletion:^(id responseObject, NSError *error) {
            [SharedAppDelegate closeLoading];
            if (error) {
                [weakSelf showAlert:error.localizedDescription];
            } else {
                if ([responseObject[@"status"] boolValue]) {
                    [weakSelf showSuccessAlert];
                } else {
                    [weakSelf showAlert:@"Failure payment process"];
                }
            }
        }];
    }
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self onClickWorkout:nil];
}

@end
