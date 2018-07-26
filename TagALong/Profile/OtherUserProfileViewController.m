//
//  OtherUserProfileViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "OtherUserProfileViewController.h"
#import "Daysquare.h"
#import "OtherUserProfilePlanTableViewCell.h"
#import "BookWorkoutViewController.h"
#import "FSCalendar.h"

@interface OtherUserProfileViewController ()<FSCalendarDataSource, FSCalendarDelegate> {
    NSDateFormatter *formatter;
    NSCalendar *gregorian;
}
@property (weak, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tvSchedule;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lctvScheduleHeight;

@property (weak, nonatomic) IBOutlet UIView *vwNoData;
@property (nonatomic, strong) NSMutableArray *arrWorkout;

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;
@end


@implementation OtherUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title;
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter = [[NSDateFormatter alloc] init];
    [_vwNoData setHidden:YES];
    
    _ivProfile.layer.cornerRadius = _ivProfile.frame.size.width / 2;
    _arrWorkout = [[NSMutableArray alloc]  init];

    self.calendar.scope = FSCalendarScopeWeek;
    [self.calendar bringSubviewToFront:self.nextButton];
    [self.calendar bringSubviewToFront:self.prevButton];
    
    [self.tvSchedule registerNib:[UINib nibWithNibName:@"OtherUserProfilePlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"OtherUserProfilePlanTableViewCell"];
    
    NSDate *curdate = [NSDate date];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateformat stringFromDate:curdate];

    [self ReqExportWorkoutList:today];
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrWorkout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"OtherUserProfilePlanTableViewCell";
    OtherUserProfilePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = _arrWorkout[indexPath.row];
    
    NSString *starttime = [dic objectForKey:API_RES_KEY_START_TIME];
    
    cell.lblTime.text = starttime;
    
    cell.lblTitle.text = [dic objectForKey:API_RES_KEY_TITLE];
    [cell.btnBookNow addTarget:self action:@selector(onClickBookNow:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnBookNow.tag = indexPath.row;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = _arrWorkout[indexPath.row];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    vc.where = @"profile";
    [self.vcParent.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - user defined functions
-(void)setExportUserInfo:(NSDictionary*)dicInfo{
    
    NSString *first_name = @"";
    NSString *last_name = @"";
    if (![[dicInfo objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
        first_name = [dicInfo objectForKey:API_RES_KEY_EXPORT_NCK_NM];
    }
    
    if (![[dicInfo objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
        last_name = [dicInfo objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
    }
    NSString *nickname = [NSString stringWithFormat:@"%@ %@", first_name, last_name];

    NSString *phone = [dicInfo objectForKey:API_RES_KEY_EXPpRT_PHONE];
    NSString *location = [dicInfo objectForKey:API_RES_KEY_USER_LOCATION];
    
    _lblPhone.text = [NSString stringWithFormat:@"%@   %@", location, phone];
    
    if ([[dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTitle" object:self userInfo:@{@"title": nickname}];

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
    
    NSString *nickname = [NSString stringWithFormat:@"%@ %@", first_name, last_name];

    
    NSString *phone = [dicInfo objectForKey:API_RES_KEY_USR_PHONE];
    NSString *location = [dicInfo objectForKey:API_RES_KEY_USER_LOCATION];
    
    _lblPhone.text = [NSString stringWithFormat:@"%@   %@", location, phone];
    
    if ([[dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTitle" object:self userInfo:@{@"title": nickname}];
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickBookNow:(UIButton *)btn{
    //go BOOKNOW PAGE
    
    NSDictionary *dic = _arrWorkout[btn.tag];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    vc.where = @"profile";
    [self.vcParent.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Network

-(void)ReqExportWorkoutList:(NSString*)date{
    
    NSString *_uid = self._id;
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url;
    
    NSDictionary *params = [[NSDictionary alloc] init];
    if ([self.type isEqualToString:@"1"]) {
        url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_OTHER_GET_PROFILE];
        params = @{ API_REQ_KEY_USER_UID: _uid,
                    API_REQ_KEY_TARGET_DATE: date };
        
    } else {
        url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_EXPERT_GET_PROFILE];
        params = @{ API_REQ_KEY_EXPERT_UID: _uid,
                    API_REQ_KEY_TARGET_DATE: date };
    }

    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            if ([self.type isEqualToString:@"1"]) {
                [self setUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];
            } else {
                [self setExportUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];
            }
            
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            if (arr.count > 0) {
                [_vwNoData setHidden:YES];
                [_arrWorkout removeAllObjects];
            } else {
                [_vwNoData setHidden:NO];
            }
            [_arrWorkout addObjectsFromArray:arr];
            
            [_tvSchedule reloadData];
            [_tvSchedule setContentOffset:CGPointZero animated:YES];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect"];
            
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


//-(void)ReqExportWorkoutList:(NSString*)date{
//
//    NSString *_uid = self._id;
//    [SharedAppDelegate showLoading];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//
//    NSDictionary *params = [[NSDictionary alloc] init];
//    if ([self.type isEqualToString:@"1"]) {
//        params = @{
//                                 API_RES_KEY_TYPE               :   API_TYPE_USER_OTHER_GET_PROFILE,
//                                 API_REQ_KEY_USER_UID           :   _uid,
//                                 API_REQ_KEY_TARGET_DATE        :   date,
//                                 };
//
//    } else {
//        params = @{
//                                 API_RES_KEY_TYPE               :   API_TYPE_EXPERT_GET_PROFILE,
//                                 API_REQ_KEY_EXPERT_UID         :   _uid,
//                                 API_REQ_KEY_TARGET_DATE        :   date,
//                                 };
//    }
//
//
//    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
//        NSLog(@"JSON: %@", respObject);
//        NSError* error;
//        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                       options:kNilOptions
//                                                                         error:&error];
//        [SharedAppDelegate closeLoading];
//
//        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
//        if (res_code == RESULT_CODE_SUCCESS) {
//
//            if ([self.type isEqualToString:@"1"]) {
//                [self setUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];
//            } else {
//                [self setExportUserInfo:[responseObject objectForKey:API_RES_KEY_EXPORT_INFO]];
//            }
//
//            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
//            if (arr.count > 0) {
//                [_vwNoData setHidden:YES];
//                [_arrWorkout removeAllObjects];
//            } else {
//                [_vwNoData setHidden:NO];
//            }
//            [_arrWorkout addObjectsFromArray:arr];
//
//            [_tvSchedule reloadData];
//            [_tvSchedule setContentOffset:CGPointZero animated:YES];
//
//        }  else if(res_code == RESULT_ERROR_PASSWORD){
//            [Commons showToast:@"The password is incorrect."];
//
//        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
//            [Commons showToast:@"User does not exist."];
//        }  else if(res_code == RESULT_ERROR_PARAMETER){
//            [Commons showToast:@"The request parameters are incorrect."];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error: %@", error);
//        [SharedAppDelegate closeLoading];
//        [Commons showToast:@"Failed to communicate with the server"];
//    }];
//}

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

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *seldate = [formatter stringFromDate:date];
    [_tvSchedule setContentOffset:CGPointMake(0, 0) animated:YES];
    [self ReqExportWorkoutList:seldate];
}

@end
