//
//  ListViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "ListViewController.h"
#import "SportsListTableViewCell.h"
#import "BookWorkoutViewController.h"
#import "OtherUserProfileViewController.h"
#import "ODRefreshControl.h"
#import "ExportSportsListTableViewCell.h"
#import "FilterViewController.h"
#import "User1ProfileViewController.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate>{
    OtherUserProfileViewController *vcOtherProfile;
    NSArray *arrSportNM;
    NSArray *arrLevel;
    NSArray *arrSportImg;
    NSString *sort_index;
    
    NSInteger nPage;
    NSInteger count_per_page;
    BOOL isLoding;
    BOOL isMore;
}

@property (nonatomic, strong) NSMutableArray *arrSportList;
@property (strong, nonatomic) IBOutlet UIView *vwFilter;
@property (strong, nonatomic) IBOutlet UITableView *tvSportList;
@property (weak, nonatomic) IBOutlet UIButton *btnDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnDuration;
@property (weak, nonatomic) IBOutlet UIButton *btnTime;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcBottombarHeight;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    sort_index = @"distance";
    _level_filter = @"";
    _sport_filter = @"";
    _cate_filter = @"";
    _distance_limit = @"";
    
    nPage = 1;
    isLoding = NO;
    isMore = NO;

    _arrSportList = [[NSMutableArray alloc]  init];
    
    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth",  @"Other Sports/Equipment", nil];
    arrLevel = [NSArray arrayWithObjects: @"Individual", @"Gym", @"Pro", @"Trainer", nil];
    arrSportImg = [NSArray arrayWithObjects: @"icon_running.png", @"icon_bike.png", @"icon_yoga.png", @"icon_pilates.png",@"icon_crossfit.png", @"icon_arts.png",  @"icon_dance.png", @"icon_combo.png", @"icon_youth.png",@"icon_other.png", nil];

    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        _lcBottombarHeight.constant = 30;
        [_vwFilter setHidden:NO];
    } else {
        _lcBottombarHeight.constant = 0;
        [_vwFilter setHidden:YES];
    }
    
    [self.tvSportList registerNib:[UINib nibWithNibName:@"SportsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SportsListTableViewCell"];
    [self.tvSportList registerNib:[UINib nibWithNibName:@"ExportSportsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExportSportsListTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pageRefresh:)
                                                 name:@"pageRefresh"
                                               object:nil];
    
    self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tvSportList];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self action:@selector(WorkoutListRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tvSportList addSubview:self.refreshControl];

}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(NSString *)startTime:(NSInteger)startTime {
    
    NSString *temp = @"";
    
    if (startTime >= 48) {
        NSInteger hours = ((startTime - 48) * 15) / 60;
        NSInteger mins = ((startTime - 48) * 15) % 60;
        if (hours == 0) hours = 12;
        temp = [NSString stringWithFormat:@"%0ld:%02ld pm", hours, mins];
        return temp;
    } else {
        NSInteger hours = (startTime * 15) / 60;
        NSInteger mins = (startTime * 15) % 60;
        if (hours == 0) hours = 12;
        temp = [NSString stringWithFormat:@"%0ld:%02ld am", hours, mins];
        return temp;
//        if (startTime == 20 || startTime == 24 || startTime == 28 || startTime >= 32) {
//            temp = [NSString stringWithFormat:@"%0ld:%02ld am", (startTime * 15) / 60, (startTime * 15) % 60];
//            return temp;
//        }
    }
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [self changeSort:@"distance"];
    } else {
        [self ReqWorkoutList];
        //[self ReqExportWorkoutList];
    }
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrSportList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
    
        static NSString *CellIdentifier = @"SportsListTableViewCell";
        SportsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        NSDictionary *dic = _arrSportList[indexPath.row];
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        NSInteger sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
        NSString *distance = @"";
        NSInteger startTime = 0;
        NSInteger duration = 0;
        NSString *first_name = @"";
        NSString *last_name = @"";

        if (![[dic objectForKey:API_RES_KEY_DISTANCE] isEqual:[NSNull null]]) {
            distance = [dic objectForKey:API_RES_KEY_DISTANCE];
        }

        if (![[dic objectForKey:API_RES_KEY_START_TIME] isEqual:[NSNull null]]) {
            startTime = [[dic objectForKey:API_RES_KEY_START_TIME] intValue];
        }


        if (![[dic objectForKey:API_RES_KEY_DURATION] isEqual:[NSNull null]]) {
            duration = [[dic objectForKey:API_RES_KEY_DURATION] intValue];
        }

        NSString *post_type = [[dic objectForKey:API_RES_KEY_POST_TYPE] stringValue];
        if ([post_type isEqualToString:@"1"]) {
            if (![[dic objectForKey:@"title"] isEqual:[NSNull null]]) {
                NSString *title = [[dic objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
                //NSSet* badWords = [NSSet setWithObjects:@"(null))", nil];
                first_name = title;
                //first_name = [dic objectForKey:@"title"];
            }
            
            if (![[dic objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_USR_NCK_NM];
            }

            if (![[dic objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_USER_LAST_NAME];
            }

        } else {
            if (![[dic objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_EXPORT_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
            }
        }

        if ( [level isEqual:[NSNull null]] )  { //individual
            cell.vwBG.backgroundColor = [UIColor whiteColor];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[0], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow3"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"1"]) { //gym
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[1], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        } else if ([level isEqualToString:@"2"]) { //pro
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[2], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblSportName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow2"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"3"]) { //trainer
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[3], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        }

        //profile

        if ([post_type isEqualToString:@"1"]) {
            if ([[dic objectForKey:API_RES_KEY_USR_PROFILE] isEqual:[NSNull null]]) {
                cell.ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
            } else {
                NSString *url = [dic objectForKey:API_RES_KEY_USR_PROFILE];
                [cell.ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
            }
        } else {
            if ([[dic objectForKey:API_RES_KEY_EXPORT_PROFILE] isEqual:[NSNull null]]) {
                cell.ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
            } else {
                NSString *url = [dic objectForKey:API_RES_KEY_EXPORT_PROFILE];
                [cell.ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
            }
        }

        cell.ivSport.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
        if ([sort_index isEqualToString:@"distance"]) {
            float len = [distance floatValue];
            if (len >= 8000) {
                cell.lblDistance.text = @"---";
            } else {
                cell.lblDistance.text = [NSString stringWithFormat:@"%.2f Miles", len];
            }
            
        } else if ([sort_index isEqualToString:@"duration"]){
            NSString *temp = [NSString stringWithFormat:@"%ld", duration * 15];
            cell.lblDistance.text = [temp stringByAppendingString:@" Mins"];
        } else if ([sort_index isEqualToString:@"start_time"]){
            NSString *temp = [self startTime:startTime];
            //NSString *temp = [NSString stringWithFormat:@"%02ld:%02ld", (startTime * 15 ) / 60, (startTime * 15 ) % 60];
            cell.lblDistance.text = temp;
        }

        [cell.bnProfile addTarget:self action:@selector(onClickUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        cell.bnProfile.tag = indexPath.row;
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"ExportSportsListTableViewCell";
        ExportSportsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dic = _arrSportList[indexPath.row];
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        NSInteger sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
        NSInteger startTime = 0;
        NSString *first_name = @"";
        NSString *last_name = @"";
        
        if (![[dic objectForKey:API_RES_KEY_START_TIME] isEqual:[NSNull null]]) {
            startTime = [[dic objectForKey:API_RES_KEY_START_TIME] intValue];
        }
        
        NSString *post_type = [[dic objectForKey:API_RES_KEY_POST_TYPE] stringValue];
        if ([post_type isEqualToString:@"1"]) {
            if (![[dic objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_USR_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_USER_LAST_NAME];
            }
            
        } else {
            if (![[dic objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_EXPORT_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
            }
        }
        
        if ( [level isEqual:[NSNull null]] )  { //individual
            cell.vwBG.backgroundColor = [UIColor whiteColor];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[0], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow3"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"1"]) { //gym
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[1], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
        } else if ([level isEqualToString:@"2"]) { //pro
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[2], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblSportName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow2"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"3"]) { //trainer
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[3], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        }
        
        cell.ivSport.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];   
      
        //NSString *temp = [NSString stringWithFormat:@"%02ld:%02ld", (startTime * 15 ) / 60, (startTime * 15 ) % 60];
         NSString *temp = [self startTime:startTime];
        cell.lblDistance.text = temp;
    
        return cell;
    }

    return nil;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 57;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = _arrSportList[indexPath.row];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    [self.vcParent.navigationController pushViewController:vc animated:YES];
}

- (void)onClickUserProfile:(UIButton *)btn{

//    if (vcOtherProfile == nil) {
//    
//        vcOtherProfile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherUserProfileViewController"];
//        vcOtherProfile.view.frame = CGRectMake(0, 0, self.vwMain.bounds.size.width, self.view.bounds.size.height + 50);
//        [self.vwMain addSubview:vcOtherProfile.view];
//        
//    }
    NSDictionary *dic = _arrSportList[btn.tag];
    
    NSString *post_type = [dic objectForKey:API_RES_KEY_POST_TYPE];
    NSString *title = [dic objectForKey:API_RES_KEY_EXPORT_NCK_NM];
    if ([post_type isEqualToString:@"2"]) {
        NSString *export_uid = [dic objectForKey:API_REQ_KEY_EXPERT_UID];
        [self addOtherUserProfile:export_uid type:post_type title:title];
    } else {
        NSString *usr_uid = [dic objectForKey:API_REQ_KEY_USER_UID];
        [self addOtherUserProfile:usr_uid type:post_type title:title];
    }
}

-(void)addOtherUserProfile:(NSString *)_uid type:(NSString *)post_type title:(NSString *)title {
    
    vcOtherProfile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherUserProfileViewController"];
    vcOtherProfile._id = _uid;
    vcOtherProfile.type = post_type;
    vcOtherProfile.title = title;
    vcOtherProfile.vcParent = self.vcParent;
    [self.navigationController pushViewController:vcOtherProfile animated:YES];
}

//fiterview delegate
- (void) setFilter:(NSString *)level sport:(NSString *)sport cat:(NSString *)cat distance:(NSString *)distance{
    _level_filter = level;
    _sport_filter = sport;
    _cate_filter = cat;
    _distance_limit = distance;
    
    [self ReqWorkoutList];
}

- (void)pageRefresh:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"pageRefresh"]) {
        if ([Global.g_user.user_login isEqualToString:@"1"]) {
            nPage = 1;
            [self ReqWorkoutList];
        } else {
            [self ReqWorkoutList];
            //[self ReqExportWorkoutList];
        }
    }
}

#pragma mark - user defined functions
-(void)changeSort:(NSString*)type{
    sort_index = type;
    
    [_btnDistance setAlpha:0.5];
    [_btnDuration setAlpha:0.5];
    [_btnTime setAlpha:0.5];
    
    if ([type isEqualToString:@"distance"]) {
        [_btnDistance setAlpha:1];
    } else if ([type isEqualToString:@"duration"]){
        [_btnDuration setAlpha:1];
    } else if ([type isEqualToString:@"start_time"]){
        [_btnTime setAlpha:1];
    }
    
    [_tvSportList setContentOffset:CGPointMake(0, 0)];
    nPage = 1;
    [self ReqWorkoutList];

}

- (void)WorkoutListRefresh:(ODRefreshControl *)sender
{
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        nPage = 1;
        [self ReqWorkoutList];
    } else {
        [self ReqWorkoutList];
        //[self ReqExportWorkoutList];
    }
    
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.3];
}


#pragma mark - click events
- (IBAction)onClickDistance:(id)sender {
    [self changeSort:@"distance"];
}

- (IBAction)onClickDurtaion:(id)sender {
    [self changeSort:@"duration"];
}

- (IBAction)onClickTime:(id)sender {
    [self changeSort:@"start_time"];
}

- (IBAction)onClickfilter:(id)sender {
    FilterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FilterViewController"];
    vc.delegate = self;
    vc.level_filter = _level_filter;
    vc.sport_filter = _sport_filter;
    vc.cate_filter = _cate_filter;
    vc.distance_limit = _distance_limit;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)ReqWorkoutList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"list_workout"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude,
                             API_REQ_KEY_SORT_TYPE          :   sort_index,
                             API_REQ_KEY_LEVEL_FILTER       :   _level_filter,
                             API_REQ_KEY_SPORTS_FILTER      :   _sport_filter,
                             API_REQ_KEY_CATEGORIES_FILTER  :   _cate_filter,
                             API_REQ_KEY_DISTANCE_limit     :   _distance_limit,
                             API_REQ_KEY_IS_MAP             :   @"0",
                             API_REQ_KEY_PAGE_NUM           :   [NSString stringWithFormat:@"%ld", (long)nPage],
                             };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        NSError* error;
//        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                       options:kNilOptions
//                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            if( nPage == 1 )
            {
                [_arrSportList removeAllObjects];
            }
            
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            count_per_page = [[responseObject objectForKey:API_RES_KEY_COUNT_PER_PAGE] intValue];
            if (count_per_page > arr.count) {
                isMore = YES;
            } else {
                isMore = NO;
            }
            [_arrSportList addObjectsFromArray:arr];
            
            [_tvSportList reloadData];
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

#pragma mark - Network
-(void)ReqOldWorkoutList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_LIST_WORKOUT,
                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%d", Global.g_user.user_uid],
                             API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude,
                             API_REQ_KEY_SORT_TYPE          :   sort_index,
                             API_REQ_KEY_LEVEL_FILTER       :   _level_filter,
                             API_REQ_KEY_SPORTS_FILTER      :   _sport_filter,
                             API_REQ_KEY_CATEGORIES_FILTER  :   _cate_filter,
                             API_REQ_KEY_DISTANCE_limit     :   _distance_limit,
                             API_REQ_KEY_IS_MAP             :   @"0",
                             API_REQ_KEY_PAGE_NUM           :   [NSString stringWithFormat:@"%ld", (long)nPage],
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
            
            if( nPage == 1 )
            {
                [_arrSportList removeAllObjects];
            }
            
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            count_per_page = [[responseObject objectForKey:API_RES_KEY_COUNT_PER_PAGE] intValue];
            if (count_per_page > arr.count) {
                isMore = YES;
            } else {
                isMore = NO;
            }
            [_arrSportList addObjectsFromArray:arr];
            
            [_tvSportList reloadData];
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

-(void)ReqOldExportWorkoutList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_EXPORT_LIST_WORKOUT,
                             API_REQ_KEY_EXPERT_UID         :   [NSString stringWithFormat:@"%d", Global.g_expert.export_uid],
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
            
            if (_arrSportList.count > 0) {
                [_arrSportList removeAllObjects];
            }
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            [_arrSportList addObjectsFromArray:arr];
            
            [_tvSportList reloadData];
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        
        if( scrollView == _tvSportList && scrollView.contentOffset.y > 0 && scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - 20 )
        {

            if (!isMore) {
                nPage++;
                [self ReqWorkoutList];
                
            }
        }
    }
}
@end
