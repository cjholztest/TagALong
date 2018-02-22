//
//  ExpertUserProfileViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#include <stdlib.h>
#import "ExpertUserProfileViewController.h"
#import "UserProfilePlanTableViewCell.h"
#import "ExpertUserProfileEditViewController.h"
#import "BookWorkoutViewController.h"

@interface ExpertUserProfileViewController ()<ExpertUserProfileEditViewControllerDelegate>{
    NSString *nickname ;
    NSString *phone ;
    NSString *location ;
    NSString *level;
    NSString *profileurl;
}
@property (weak, nonatomic) IBOutlet UITableView *tvSchedule;
@property (strong, nonatomic) IBOutlet UIImageView *ivProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UIView *vwNoData;
@property (nonatomic, strong) NSMutableArray *arrWorkout;
@end

@implementation ExpertUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *star = [dic objectForKey:@"star_mark"];
    if ([star isEqualToString:@"1"]) {
        [cell.ivStar setHidden:NO];
        NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
        NSString *loc = [dic objectForKey:API_RES_KEY_USER_LOCATION];
        cell.lblTitle.text = [NSString stringWithFormat:@"%@\n%@", title, loc];
        cell.lblTitle.textAlignment = NSTextAlignmentLeft;
    } else {
        [cell.ivStar setHidden:YES];
        cell.lblTitle.text = @"";
        cell.lblTitle.textAlignment = NSTextAlignmentCenter;
    }
    
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
    vc.bProfile = true;
    [self.vcParent.navigationController pushViewController:vc animated:YES];

}

//ExpertUserProfileEditViewController delegate
-(void)setEditDate:(NSMutableDictionary *)dic{

    _lblAddress.text = [dic objectForKey:@"address"];
    _lblPhone.text = [dic objectForKey:@"phone"];
    level = [dic objectForKey:@"level"];
    NSString *url = [dic objectForKey:@"profile"];
    [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];

    if ([level isEqualToString:@"1"]) {
        _lblLevel.text = @"GYM";
    } else if ([level isEqualToString:@"2"]) {
        _lblLevel.text = @"PRO";
    } else if ([level isEqualToString:@"3"]) {
        _lblLevel.text = @"TRAINER";
    } else {
        _lblLevel.text = @"INDIVIDUAL";
    }
}

#pragma mark - user defined functions
- (void)initData{
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

-(void)initUI{
    _arrWorkout = [[NSMutableArray alloc]  init];

    _ivProfile.layer.cornerRadius = _ivProfile.bounds.size.width / 2;

    [self.tvSchedule registerNib:[UINib nibWithNibName:@"UserProfilePlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserProfilePlanTableViewCell"];
    
    [_vwNoData setHidden:YES];
//    [self initData];
    
    NSDate *curdate = [NSDate date];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateformat stringFromDate:curdate];
    [self addEditInfoBarButton];
    [self ReqGetExportUserProfile:today];
}

-(void)addEditInfoBarButton {
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_white"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickEdit:)];
    self.vcParent.navigationItem.rightBarButtonItem = editButton;
    //self.navigationController.navigationItem.rightBarButtonItem = editButton;
}

-(void)setUserInfo:(NSDictionary*)dicInfo{
    NSString *first_name = @"";
    NSString *last_name = @"";
    if (![[dicInfo objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
        first_name = [dicInfo objectForKey:API_RES_KEY_EXPORT_NCK_NM];
    }
    
    if (![[dicInfo objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
        last_name = [dicInfo objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
    }
    nickname = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    
    phone = [dicInfo objectForKey:API_RES_KEY_EXPpRT_PHONE];
    location = [dicInfo objectForKey:API_RES_KEY_USER_LOCATION];
    level = [dicInfo objectForKey:API_RES_KEY_LEVEL];
    
    _lblPhone.text = phone;
    _lblAddress.text = location;
    
    if ([level isEqualToString:@"1"]) {
        _lblLevel.text = @"GYM";
    } else if ([level isEqualToString:@"2"]) {
        _lblLevel.text = @"PRO";
    } else if ([level isEqualToString:@"3"]) {
        _lblLevel.text = @"TRAINER";
    } else {
        _lblLevel.text = @"INDIVIDUAL";
    }
    
    if ([[dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        profileurl = [dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:profileurl] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTitle" object:self userInfo:@{@"title": nickname}];
}

#pragma mark - click events
- (IBAction)onClickEdit:(id)sender {
    ExpertUserProfileEditViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertUserProfileEditViewController"];
    vc.delegate = self;
    vc.phone = phone;
    vc.location = location;
    vc.url = profileurl;
    vc.level = level;
    vc.nickname = nickname;
    vc.arrSchedule = _arrWorkout;
    vc.vcParent = self.vcParent;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Network
-(void)ReqGetExportUserProfile:(NSString*)date{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_EXPERT_GET_PROFILE,
                             API_REQ_KEY_EXPERT_UID         :   [NSString stringWithFormat:@"%d", Global.g_expert.export_uid],
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
            
            [self setUserInfo:[responseObject objectForKey:API_RES_KEY_EXPORT_INFO]];
            
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
//                    [dic_workout setObject:star_mark forKey:API_RES_KEY_START_TIME];
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

@end
