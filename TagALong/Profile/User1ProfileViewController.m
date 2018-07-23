//
//  User1ProfileViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "User1ProfileViewController.h"
#import "Daysquare.h"
#import "BookWorkoutViewController.h"
#import "UserProfilePlanTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "BSImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "BookWorkoutViewController.h"
#import "FSCalendar.h"
#import <Photos/Photos.h>
#import "ExpertUserProfileEditViewController.h"
#import "SimpleUserEditProfileViewController.h"
#import "UIViewController+Storyboard.h"
#import "WorkoutDetailsViewController.h"
#import "UIColor+AppColors.h"
#import "NextWorkoutsView.h"
#import "UIFont+HelveticaNeue.h"
#import "SimpleUserProfileMapper.h"
#import "SimpleUserProfile.h"

@interface User1ProfileViewController ()<UIImagePickerControllerDelegate, FSCalendarDataSource, FSCalendarDelegate, ExpertUserProfileEditViewControllerDelegate>{
    NSString *file_url;
    NSString *file_name;
    NSString *nickname;
    NSString *phone;
    NSData *imgData;
    NSDateFormatter *formatter;
    NSCalendar *gregorian;
    NSInteger miles;
    NSString *iconURL;
}

@property (weak, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UIView *vwLevel;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *prevButton;

@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tvSchedule;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lctvScheduleHeight;

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) BSImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIView *vwNoData;
@property (nonatomic, strong) NSMutableArray *arM_Photo;
@property (nonatomic, strong) NSMutableArray *arrWorkout;

@property (nonatomic, strong) NextWorkoutsView *nextWorkoutsContainerView;
@property (nonatomic, strong) SimpleUserProfile *profile;

@end

static const NSInteger kMaxImageCnt = 1;
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define IS_IOS8_OR_ABOVE                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation User1ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter = [[NSDateFormatter alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addEditInfoBarButton];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addEditInfoBarButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect nextWorkotsFrame = CGRectZero;
    nextWorkotsFrame.size.height = 44.0f;
    nextWorkotsFrame.size.width = self.view.bounds.size.width;
    nextWorkotsFrame.origin.y = self.view.bounds.size.height - nextWorkotsFrame.size.height;
    
    self.nextWorkoutsContainerView.frame = nextWorkotsFrame;
}

- (NextWorkoutsView*)nextWorkoutsContainerView {
    if (!_nextWorkoutsContainerView) {
        _nextWorkoutsContainerView = [NextWorkoutsView new];
        _nextWorkoutsContainerView.backgroundColor = UIColor.appColor;
        [_nextWorkoutsContainerView setHidden:YES];
        [self.view insertSubview:_nextWorkoutsContainerView aboveSubview:self.vwNoData];
    }
    return _nextWorkoutsContainerView;
}

-(void)addEditInfoBarButton {
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onClickEdit:)];
    self.vcParent.navigationItem.rightBarButtonItem = editButton;
    //self.navigationController.navigationItem.rightBarButtonItem = editButton;
}

#pragma mark - click events
- (void)onClickEdit:(id)sender {
    SimpleUserEditProfileViewController *vc = (SimpleUserEditProfileViewController*)SimpleUserEditProfileViewController.fromStoryboard;
    [vc setupProfile:self.profile];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setEditDate:(NSMutableDictionary *)dic {
    
}

- (void)calendarViewDidChange:(id)sender {
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"YYYY-MM-dd";
//    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
//
//    NSString *seldate = [formatter stringFromDate:self.calendarView.selectedDate];
    
    NSDate *seldate = self.calendarView.selectedDate;
    
    [_tvSchedule setContentOffset:CGPointMake(0, 0) animated:YES];
    //[self ReqOldGetUserProfile:seldate];
    [self ReqGetUserProfile:seldate];
}

- (NSDate*)nextDayDateFromDate:(NSDate*)date {
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    NSTimeInterval newTimeInterval = dateTimeInterval + 86400;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:newTimeInterval];
    return newDate;
}

- (void)updateNextWorkoutsForDate:(NSDate*)date {
    
    [SharedAppDelegate showLoading];
    
    __weak typeof(self)weakSelf = self;
    [weakSelf.nextWorkoutsContainerView setHidden:YES];
    
    NSDate *firstDate = [self nextDayDateFromDate:date];
    NSDate *secondDate = [self nextDayDateFromDate:firstDate];
    NSDate *thirdDate = [self nextDayDateFromDate:secondDate];
    
    __block NSError *firsttDayError = nil;
    __block NSError *secondDayError = nil;
    __block NSError *thirdDayError = nil;
    
    __block BOOL firstDayWorkoutExists = NO;
    __block BOOL secondDayWorkoutExists = NO;
    __block BOOL thirdDayWorkoutExists = NO;
    
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    dispatch_group_enter(serviceGroup);
    
    [self reqUserProfile:firstDate withCompletion:^(BOOL workoutsExist, NSError *error) {
        firstDayWorkoutExists = workoutsExist;
        firsttDayError = error;
        dispatch_group_leave(serviceGroup);
    }];
    
    dispatch_group_enter(serviceGroup);
    
    [self reqUserProfile:secondDate withCompletion:^(BOOL workoutsExist, NSError *error) {
        secondDayWorkoutExists = workoutsExist;
        secondDayError = error;
        dispatch_group_leave(serviceGroup);
    }];
    
    dispatch_group_enter(serviceGroup);
    
    [self reqUserProfile:thirdDate withCompletion:^(BOOL workoutsExist, NSError *error) {
        thirdDayWorkoutExists = workoutsExist;
        thirdDayError = error;
        dispatch_group_leave(serviceGroup);
    }];
    
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        
        NSDate *visibleDate = nil;
        
        if (firstDayWorkoutExists) {
            visibleDate = firstDate;
        } else if (secondDayWorkoutExists) {
            visibleDate = secondDate;
        } else if (thirdDayWorkoutExists) {
            visibleDate = thirdDate;
        }
        
        if (visibleDate) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"E, d";
            
            [weakSelf.nextWorkoutsContainerView setHidden:NO];
            
            NSString *titleText = @"Next workouts will be on ";
            NSString *valueText = [dateFormatter stringFromDate:visibleDate];
            
            NSString *textToDisplay = [NSString stringWithFormat:@"%@%@", titleText, valueText];
            
            NSDictionary *titleAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor, NSFontAttributeName : UIFont.textFont};
            NSDictionary *valueAttributes = @{NSForegroundColorAttributeName : UIColor.proBackgroundColor, NSFontAttributeName : UIFont.textBoldFont};
            
            NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:textToDisplay];
            [resultString setAttributes:titleAttributes range:[textToDisplay rangeOfString:titleText]];
            [resultString setAttributes:valueAttributes range:[textToDisplay rangeOfString:valueText]];
            
            weakSelf.nextWorkoutsContainerView.titleNWLabel.attributedText = resultString;
        }
        
        [SharedAppDelegate closeLoading];
    });
    
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrWorkout.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"UserProfilePlanTableViewCell";
    UserProfilePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic  = _arrWorkout[indexPath.row];
    
//    cell.lblTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (indexPath.row * 15 ) / 60, (indexPath.row * 15 ) % 60];
    cell.lblTime.text = [dic objectForKey:API_RES_KEY_START_TIME];
    
//    NSString *workout = [dic objectForKey:@"workout"];
//    
//    if ([workout isEqualToString:@"1"]) {
//        cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
//    } else {
//        cell.vwBG.backgroundColor = [UIColor whiteColor];
//    }

    cell.vwBG.backgroundColor = [UIColor whiteColor];
    
    NSString *star = [dic objectForKey:@"star_mark"];
    
    BOOL isStarVisible = [star isEqualToString:@"1"];
    
    [cell.ivStar setHidden:!isStarVisible];
    [cell.durationLabel setHidden:isStarVisible];
    
    if (dic[@"duration"]) {
        cell.durationLabel.text = [NSString stringWithFormat:@"duration\n%@", dic[@"duration"]];
    }
    
    if (dic[API_RES_KEY_TITLE]) {
        cell.lblTitle.numberOfLines = 2;
        cell.lblTitle.text = dic[API_RES_KEY_TITLE];
    }
   
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 46;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = _arrWorkout[indexPath.row];
//    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
//    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
//    vc.bProfile = YES;
    WorkoutDetailsViewController *vc = (WorkoutDetailsViewController*)WorkoutDetailsViewController.fromStoryboard;
    [vc setupWorkout:[dic objectForKey:API_RES_KEY_WORKOUT_UID]];
    [self.vcParent.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - user defined functions
-(void)initUI{
    [self.nextWorkoutsContainerView setHidden:YES];
    _arrWorkout = [[NSMutableArray alloc]  init];
    _ivProfile.layer.cornerRadius = _ivProfile.bounds.size.width / 2;
    
    self.calendar.scope = FSCalendarScopeWeek;
    [self.calendar bringSubviewToFront:self.nextButton];
    [self.calendar bringSubviewToFront:self.prevButton];
    //[self initData];
    [_vwNoData setHidden:YES];
    
   // [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.tvSchedule registerNib:[UINib nibWithNibName:@"UserProfilePlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserProfilePlanTableViewCell"];
    
    NSDate *curdate = [NSDate date];
//    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
//    [dateformat setDateFormat:@"yyyy-MM-dd"];
//    NSString *today = [dateformat stringFromDate:curdate];

    //[self ReqOldGetUserProfile:today];
    [self ReqGetUserProfile:curdate];
}

- (void)initData{
    
    for (NSInteger i = 0; i < 96; i++) {
        NSString *temp = @"";
        if (i >= 48) {
            NSInteger hours = ((i - 48) * 15) / 60;
            NSInteger mins = ((i - 48) * 15) % 60;
            if (hours == 0) hours = 12;
            temp = [NSString stringWithFormat:@"%0ld:%02ld pm", hours, mins];
            
        } else {
            if (i == 20 || i == 24 || i == 28 || i >= 32) {
                temp = [NSString stringWithFormat:@"%0ld:%02ld am", (i * 15) / 60, (i * 15) % 60];
                
            }
        }
    }
    
    for (int i = 0; i < 96 ; i++) {
        NSMutableDictionary *dics = [NSMutableDictionary dictionary];
        [dics setObject:@"" forKey:@"workout_uid"];
        [dics setObject:@"0" forKey:@"star_mark"];
        [dics setObject:@"" forKey:@"start_time"];
        [dics setObject:@"" forKey:@"duration"];
        [dics setObject:@"" forKey:@"title"];
        [dics setObject:@"0" forKey:@"workout"];
        [dics setObject:@"" forKey:@"location"];
        
        [_arrWorkout addObject:dics];
    }
}

-(void)setUserInfo:(NSDictionary*)dicInfo{
    NSString *first_name = @"";
    NSString *last_name = @"";
    if (![[dicInfo objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
        first_name = [dicInfo objectForKey:API_RES_KEY_USR_NCK_NM];
    }
    
    if (![[dicInfo objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
        last_name = [dicInfo objectForKey:API_RES_KEY_USER_LAST_NAME];
    }
    
    nickname = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    NSString *age = [dicInfo objectForKey:API_RES_KEY_USER_AGE];
    NSString *location = [dicInfo objectForKey:API_RES_KEY_USER_LOCATION];
    phone = [dicInfo objectForKey:API_RES_KEY_USR_PHONE];
    //_lblAge.text = [NSString stringWithFormat:@"%@ years old   %@", age, location];
    _lblAge.text = location;
    
    NSMutableString *fullName = [NSMutableString string];
    
    if (dicInfo[@"usr_nck_nm"]) {
        [fullName appendString:dicInfo[@"usr_nck_nm"]];
    }
    
    if (dicInfo[@"usr_last_name"]) {
        [fullName appendString:[NSString stringWithFormat:@" %@", dicInfo[@"usr_last_name"]]];
    }
    _lblLevel.text = fullName;
    
    miles = [dicInfo[@"pro_search_radius"] integerValue];
    
    if ([[dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        iconURL = url;
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTitle" object:self userInfo:@{@"title": nickname}];

}

- (UIImage *)compressForUpload:(UIImage *)original scale:(CGFloat)scale
{
    // Calculate new size given scale factor.
    CGSize originalSize = original.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

- (IBAction)previousClicked:(id)sender {
    
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [gregorian dateByAddingUnit:NSCalendarUnitWeekOfMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (IBAction)nextClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [gregorian dateByAddingUnit:NSCalendarUnitWeekOfMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (IBAction)onClickProfile:(id)sender {
    
    NSString *myuid = [NSString stringWithFormat:@"%d", Global.g_user.user_uid];
    
    if (![myuid isEqualToString:self.user_id]) {
        return;
    }
    
    [OHActionSheet showSheetInView:self.view
                             title:nil
                 cancelButtonTitle:@"Cancel"
            destructiveButtonTitle:nil
                 otherButtonTitles:@[@"Photo shoot", @"Album"]
                        completion:^(OHActionSheet* sheet, NSInteger buttonIndex)
     {
         //         if( kMaxImageCnt <= self.arM_Photo.count )
         //         {
         //             NSString *str_Msg = [NSString stringWithFormat:@"최대 %ld장의 이미지 등록이 가능합니다", kMaxImageCnt];
         //             [self.navigationController.view makeToast:str_Msg withPosition:kPositionCenter];
         //             return;
         //         }
         
         
         if( buttonIndex == 0 ) {
             UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
             imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
             imagePickerController.delegate = self;
             imagePickerController.allowsEditing = YES;
             
             if(IS_IOS8_OR_ABOVE)
             {
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     [self presentViewController:imagePickerController animated:YES completion:nil];
                 }];
             }
             else
             {
                 [self presentViewController:imagePickerController animated:YES completion:nil];
             }
         }
         else if( buttonIndex == 1 ) {
             UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
             imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
             imagePickerController.delegate = self;
             imagePickerController.allowsEditing = YES;
             imagePickerController.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
             [self presentViewController:imagePickerController animated:YES completion:nil];
         }
     }];

}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"]) {
        self.videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        //        UIImage *compressimage = [self compressForUpload:thumb scale:0.5];
        imgData = UIImageJPEGRepresentation(thumb, 0.5);
        CGImageRelease(image);
        
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     
                                 }];
        [self uploadImage:thumb scale:0.5];
    }
    else
    {
        //        NSMutableArray *arrData = [NSMutableArray array];
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //UIImage *resizeImage = [Util imageWithImage:outputImage convertToWidth:self.ivImage.frame.size.width];
        //UIImage *compressimage = [self compressForUpload:outputImage scale:0.5];
        imgData = UIImageJPEGRepresentation(outputImage, 0.5);
        
//        _ivProfile.image = [UIImage imageWithData:imageData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self uploadImage:outputImage scale:0.5];
    }
}

#pragma mark - Network

-(void)ReqGetUserProfile:(NSDate*)date {
    
    __weak typeof(self)weakSelf = self;
    
    __block NSDate *selectedDate = date;
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    __block NSString *dateStr = [dateformat stringFromDate:date];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_GET_PROFILE];
    
    NSDictionary *params = @{ API_REQ_KEY_TARGET_DATE: dateStr,};
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [self setUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];
            
            NSDictionary *userInfoJSON = [responseObject objectForKey:API_RES_KEY_USER_INFO];
            weakSelf.profile = [SimpleUserProfileMapper simpleUserProfileFromJSON:userInfoJSON];
            
            NSArray *arrData = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            
            if (_arrWorkout.count > 0) {
                [_arrWorkout removeAllObjects];
            }
            
            //            [self initData];
            
            for (int i = 0; i < arrData.count; i++) {
                NSDictionary *dic = arrData[i];
                NSString *startTime = [dic objectForKey:API_REQ_KEY_START_TIME];
                //NSInteger starttime = [[dic objectForKey:API_REQ_KEY_START_TIME] intValue];
                NSString *duration = [dic objectForKey:API_REQ_KEY_DURATION];

                NSMutableDictionary *dic_workout = [[NSMutableDictionary alloc] init];

                NSString *workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
                //NSString *star_mark = [[dic objectForKey:API_RES_KEY_STAR_MARK] stringValue];
                NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
                NSString *location = [dic objectForKey:API_RES_KEY_USER_LOCATION];

                [dic_workout setObject:workout_id forKey:API_RES_KEY_WORKOUT_UID];
            
                //[dic_workout setObject:@"1" forKey:API_RES_KEY_START_TIME];

                [dic_workout setObject:location forKey:API_RES_KEY_USER_LOCATION];
                [dic_workout setObject:@"0" forKey:@"star_mark"];
                [dic_workout setObject:title forKey:API_RES_KEY_TITLE];
                [dic_workout setObject:startTime forKey:API_RES_KEY_START_TIME];
                [dic_workout setObject:duration forKey:API_REQ_KEY_DURATION];

                [dic_workout setObject:@"1" forKey:@"workout"];

                [_arrWorkout addObject:dic_workout];
           
            }
            
            if (arrData.count > 0) {
                [_vwNoData setHidden:YES];
            } else {
                [_vwNoData setHidden:NO];
            }
            
            [_tvSchedule reloadData];
            
            [weakSelf updateNextWorkoutsForDate:selectedDate];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

-(void)ReqOldGetUserProfile:(NSString*)date{

    [SharedAppDelegate showLoading];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_USER_GET_PROFILE,
                             API_REQ_KEY_USER_UID           :   self.user_id,
                             API_REQ_KEY_TARGET_DATE        :   date,
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

            [self setUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];

            NSArray *arrData = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];

            if (_arrWorkout.count > 0) {
                [_arrWorkout removeAllObjects];
            }

//            [self initData];

            for (int i = 0; i < arrData.count; i++) {
                NSDictionary *dic = arrData[i];
                NSInteger starttime = [[dic objectForKey:API_REQ_KEY_START_TIME] intValue];
                NSInteger duration = [[dic objectForKey:API_REQ_KEY_DURATION] intValue];

                for (int k = 0; k < duration; k++) {
                    //NSMutableDictionary *dic_workout = [_arrWorkout[starttime + k] mutableCopy];
                    NSMutableDictionary *dic_workout = [[NSMutableDictionary alloc] init];

                    NSString *workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
                    NSString *star_mark = [dic objectForKey:API_RES_KEY_STAR_MARK];
                    NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
                    NSString *location = [dic objectForKey:API_RES_KEY_USER_LOCATION];

                    [dic_workout setObject:workout_id forKey:API_RES_KEY_WORKOUT_UID];
                    [dic_workout setObject:star_mark forKey:API_RES_KEY_START_TIME];
                    if (k == 0) {
                        [dic_workout setObject:location forKey:API_RES_KEY_USER_LOCATION];
                        [dic_workout setObject:@"1" forKey:@"star_mark"];
                        [dic_workout setObject:title forKey:API_RES_KEY_TITLE];
                    } else {
                        [dic_workout setObject:@"" forKey:API_RES_KEY_USER_LOCATION];
                        [dic_workout setObject:@"0" forKey:@"star_mark"];
                        [dic_workout setObject:@"" forKey:API_RES_KEY_TITLE];
                    }

                    if ((starttime * 15) / 60 > 12) {
                        [dic_workout setObject:[NSString stringWithFormat:@"%02ld:%02ld pm", ((starttime + k) * 15 ) / 60 - 12, ((starttime + k) * 15 ) % 60] forKey:API_RES_KEY_START_TIME];
                    } else {
                        [dic_workout setObject:[NSString stringWithFormat:@"%02ld:%02ld am", ((starttime + k) * 15 ) / 60, ((starttime + k) * 15 ) % 60] forKey:API_RES_KEY_START_TIME];
                    }

                    [dic_workout setObject:@"1" forKey:@"workout"];

//                    [_arrWorkout removeObjectAtIndex:starttime + k];
//                    [_arrWorkout insertObject:dic_workout atIndex:starttime + k];
                    [_arrWorkout addObject:dic_workout];
                }
            }

            if (arrData.count > 0) {
                [_vwNoData setHidden:YES];
            } else {
                [_vwNoData setHidden:NO];
            }

            [_tvSchedule reloadData];

        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];

        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

- (void)reqUserProfile:(NSDate*)date withCompletion:(void(^)(BOOL workoutsExist, NSError *error))completion {
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateformat stringFromDate:date];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_GET_PROFILE];
    
    NSDictionary *params = @{ API_REQ_KEY_TARGET_DATE: dateStr,};
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        BOOL workoutsExist = NO;
        NSError *err = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            NSArray *arrData = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            workoutsExist = arrData.count > 0;
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
        
        if (completion) {
            completion(workoutsExist, err);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        if (completion) {
            completion(NO, error);
        }
    }];
}

- (void)uploadImage:(UIImage*)image scale:(float)scale {
    if (image == nil)
        return;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_FILE_UPLOAD];
    
    NSData *fileData = image? UIImageJPEGRepresentation(image, scale):nil;
    
    [manager POST:url parameters:nil  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:API_REQ_KEY_UPFILE
                                    fileName:@"img.png"
                                    mimeType:@"multipart/form-data"];
        }
    }
         progress: nil success:^(NSURLSessionTask *task, id responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
//             NSError* error;
//             NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                            options:kNilOptions
//                                                                              error:&error];
             [SharedAppDelegate closeLoading];
             
             int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
             if (res_code == RESULT_CODE_SUCCESS) {
                 
//                 _ivProfile.image = [UIImage imageWithData:fileData];
                 file_url = [responseObject objectForKey:API_RES_KEY_FILE_URL];
                 [_ivProfile sd_setImageWithURL:[NSURL URLWithString:file_url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
                 
                 file_name = [responseObject objectForKey:API_RES_KEY_FILE_NAME];
                 
                 [self ReqUpdateInfo];
             } else if (res_code == RESULT_ERROR_PARAMETER){
                 [Commons showToast:@"parameter error"];
             } else if (res_code == RESULT_ERROR_FILE_UPLOAD){
                 [Commons showToast:@"Failed file upload"];
             } else {
                 
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [SharedAppDelegate closeLoading];
             [Commons showToast:@"Failed to communicate with the server"];
         }];
}

-(void)ReqUpdateInfo{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_PROFILE_UPDATE];
    
    NSDictionary *params = @{
                             //API_RES_KEY_USR_NCK_NM         :   nickname,
                             //API_RES_KEY_USER_LAST_NAME     :   nickname,
                             API_RES_KEY_USR_PHONE          :   phone,
                             API_REQ_KEY_USER_PROFILE_IMG   :   file_url
                             };
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            _ivProfile.image = [UIImage imageWithData:imgData];
            [Commons showToast:@"Your profile was changed"];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
//    formatter.dateFormat = @"YYYY-MM-dd";
//
//    NSString *seldate = [formatter stringFromDate:date];
    [_tvSchedule setContentOffset:CGPointMake(0, 0) animated:YES];
    //[self ReqOldGetUserProfile:seldate];
    [self ReqGetUserProfile:date];
}

@end
