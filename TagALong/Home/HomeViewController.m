//
//  HomeViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"
#import "ListViewController.h"
#import "FilterViewController.h"
#import "OtherUserProfileViewController.h"
#import "UserProfileViewController.h"
#import "User1ProfileViewController.h"
#import "WorkoutSelectViewController.h"
#import "ExpertUserProfileViewController.h"
#import "StartedViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate, ListViewControllerDelegate>{

    MapViewController *vcMap;
    ListViewController *vcList;
    UserProfileViewController *vcUserProfile;
    User1ProfileViewController *vcUser1Profile;
    ExpertUserProfileViewController *vcExpertUserProfile;
    OtherUserProfileViewController *vcOtherProfile;
    NSInteger nCurPageIdx;
    NSUInteger nCurButtonIdx;
    BOOL bOtherPage;  //OtherProfilePage가 열렸는지 판정하는 변수
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIView *vwContent;
@property (weak, nonatomic) IBOutlet UIScrollView *svContetns;
@property (weak, nonatomic) IBOutlet UILabel *lblMap;
@property (weak, nonatomic) IBOutlet UILabel *lblList;
@property (weak, nonatomic) IBOutlet UIImageView *ivMapLine;
@property (weak, nonatomic) IBOutlet UIImageView *ivListLine;
@property (strong, nonatomic) IBOutlet UIView *vwPaySuccess;
//Profile
@property (strong, nonatomic) IBOutlet UIImageView *ivProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblProfile;

//Search
@property (strong, nonatomic) IBOutlet UIImageView *ivSearch;
@property (strong, nonatomic) IBOutlet UILabel *lblSearch;

//Submit
@property (strong, nonatomic) IBOutlet UIImageView *ivSubmit;
@property (strong, nonatomic) IBOutlet UILabel *lblSubmit;
@property (weak, nonatomic) IBOutlet UIControl *vwBack;
@property (weak, nonatomic) IBOutlet UIControl *vwAlarm;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setDefaulttitle];

    bOtherPage = false;
    nCurPageIdx = PAGE_MENU_MAP;
    nCurButtonIdx = BUTTON_SEARDCH;
    [_vwPaySuccess setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PaySuccess)
                                                 name:@"PaySuccess"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setChangeFilter:)
                                                 name:@"ChangeTitle"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeExportProfile:)
                                                 name:@"ExportProfile"
                                               object:nil];

}

//-(BOOL)prefersStatusBarHidden{
//    return NO;
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
    
    _svContetns.contentSize = CGSizeMake(self.view.frame.size.width * 2, _svContetns.bounds.size.height);
    _svContetns.pagingEnabled = YES;
    
    [self setPage];
    [self changeBottomButton];
    
//    if ([Global.g_user.user_login isEqualToString:@"expert"]) {
//        [self onClickProfile:self];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat pageWidth = scrollView.frame.size.width;
//    nCurPageIdx = floor((scrollView.contentOffset.x - pageWidth / 2.0f ) / pageWidth) + 2 ; //this provide you the page number
//    [self setPage];
//}

//notification
- (void)PaySuccess {
    [_vwPaySuccess setHidden:NO];
}

//ListviewConteroller delegate
-(void)addOtherUserProfile:(NSString *)_uid type:(NSString *)post_type{
    if (vcOtherProfile == nil) {
        
        [_vwAlarm setHidden:NO];
        bOtherPage = true;
        
//        nCurButtonIdx = BUTTON_PROFILE;
//        [self changeBottomButton];
        
//        if ([post_type isEqualToString:@"2"]) {
        
            vcOtherProfile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherUserProfileViewController"];
            vcOtherProfile._id = _uid;
        vcOtherProfile.type = post_type;
            vcOtherProfile.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _vwContent.bounds.size.height);
            vcOtherProfile.vcParent = self;
            [_vwContent addSubview:vcOtherProfile.view];
            [self addChildViewController:vcOtherProfile];
//        } else {
//            
//            vcUser1Profile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"User1ProfileViewController"];
//            vcUser1Profile.user_id = _uid;
//            vcUser1Profile.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _vwContent.bounds.size.height);
//            vcUser1Profile.vcParent = self;
//            [_vwContent addSubview:vcUser1Profile.view];
//            [self addChildViewController:vcUser1Profile];
//        }
    }
}

#pragma mark - user defined functions
-(void)setDefaulttitle{
    _lblTitle.text = @"Explore Workouts in Your Area";
    [_vwBack setHidden:NO];
    [_vwAlarm setHidden:NO];
    
    _lblTitle.textColor = [UIColor whiteColor];
    [_lblTitle setFont:[UIFont fontWithName:@"Helvetica" size:14]];
}

- (void)setPage {

    _lblMap.textColor = [UIColor whiteColor];
    _lblList.textColor = [UIColor whiteColor];
    
    [_ivMapLine setHidden:YES];
    [_ivListLine setHidden:YES];
    
    if (nCurPageIdx == PAGE_MENU_MAP) {
    
        [_ivMapLine setHidden:NO];
        _lblMap.textColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _svContetns.contentOffset = CGPointMake(_vwContent.frame.size.width * (0), 0);
        if (vcMap == nil) {
            vcMap = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapViewController"];
            vcMap.vcParent = self;
            vcMap.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _svContetns.bounds.size.height);
            [_svContetns addSubview:vcMap.view];
            [self addChildViewController:vcMap];
        }
        
    } else if (nCurPageIdx == PAGE_MENU_LIST) {

        [_ivListLine setHidden:NO];
        _lblList.textColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _svContetns.contentOffset = CGPointMake(_vwContent.frame.size.width * (1), 0);
        if (vcList == nil) {
            vcList = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListViewController"];
            vcList.vcParent = self;
            vcList.delegate = self;
            vcList.view.frame = CGRectMake(_vwContent.bounds.size.width, 0, _vwContent.bounds.size.width, _svContetns.bounds.size.height);
            [_svContetns addSubview:vcList.view];
            [self addChildViewController:vcList];
        }
        
    }
}

-(void)removeviewsFromMain{
    [_vwPaySuccess setHidden:YES];
    if (vcOtherProfile != nil) {
        [vcOtherProfile.view removeFromSuperview];
        vcOtherProfile = nil;
    }
    
//    if ([Global.g_user.user_login isEqualToString:@"1"]) {
//        if (vcUserProfile != nil) {
//            [vcUserProfile.view removeFromSuperview];
//            vcUserProfile = nil;
//        }
        if (vcUser1Profile != nil) {
            [vcUser1Profile.view removeFromSuperview];
            vcUser1Profile = nil;
        }
//    } else {
        if (vcExpertUserProfile != nil) {
            [vcExpertUserProfile.view removeFromSuperview];
            vcExpertUserProfile = nil;
//        }
    }
}

-(void)changeBottomButton{
    [_ivProfile setAlpha:1.0];
    [_ivSearch setAlpha:1.0];
    [_ivSubmit setAlpha:1.0];
    
    [_lblProfile setAlpha:1.0];
    [_lblSearch setAlpha:1.0];
    [_lblSubmit setAlpha:1.0];
    
    if (nCurButtonIdx == BUTTON_PROFILE) {
        [_ivProfile setAlpha:0.5];
        [_lblProfile setAlpha:0.5];
    } else if (nCurButtonIdx == BUTTON_SEARDCH) {
        [_ivSearch setAlpha:0.5];
        [_lblSearch setAlpha:0.5];
    } else if (nCurButtonIdx == BUTTON_SUBMIT) {
        [_ivSubmit setAlpha:0.5];
        [_lblSubmit setAlpha:0.5];
    }
}

//change title
- (void)setChangeFilter:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ChangeTitle"]) {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *title = userInfo[@"title"];
        _lblTitle.text = title;
        
//        [_lblTitle setTextColor:[UIColor colorWithRed:0/255  green:156/255 blue:242/255 alpha:1 ]];
        _lblTitle.textColor = [UIColor whiteColor];
        [_lblTitle setFont:[UIFont fontWithName:@"Helvetica" size:20]];

    }
}

- (void)removeExportProfile:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ExportProfile"]) {
        if (vcOtherProfile != nil) {
            [vcOtherProfile.view removeFromSuperview];
            vcOtherProfile = nil;
        }
    }
}

- (void)removeMainPages{

    if (vcMap != nil) {
        [vcMap.view removeFromSuperview];
        vcMap = nil;
    }

    if (vcList != nil) {
        [vcList.view removeFromSuperview];
        vcList = nil;
    }

}

#pragma mark - click events
//title
- (IBAction)onClickAlarm:(id)sender {
    
}

- (IBAction)onClickFilter:(id)sender {
    FilterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FilterViewController"];
    vc.level_filter = vcList.level_filter;
    vc.sport_filter = vcList.sport_filter;
    vc.cate_filter = vcList.cate_filter;
    vc.distance_limit = vcList.distance_limit;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (IBAction)onClickBack:(id)sender {
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        if (bOtherPage) {
            [vcOtherProfile.view removeFromSuperview];
            vcOtherProfile = nil;
            bOtherPage = false;
        } else {
            StartedViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartedViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [Commons clearUserInfo];
        
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavLogin"]; //NavExpertLogin
        [self presentViewController:vc animated:NO completion:nil];
    }
}

//sub title

- (IBAction)onClickMap:(id)sender {
    [self removeMainPages];
    nCurPageIdx = PAGE_MENU_MAP;
    [self setPage];
}
- (IBAction)onClickList:(id)sender {
    [self removeMainPages];
    nCurPageIdx = PAGE_MENU_LIST;
    [self setPage];
 
}

//bottom
- (IBAction)onClickProfile:(id)sender {
    bOtherPage = false;
    nCurButtonIdx = BUTTON_PROFILE;
    [self changeBottomButton];
    
    [self removeviewsFromMain];
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
//        if (vcUserProfile == nil) {
//            vcUserProfile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
//    
//            vcUserProfile.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _vwContent.bounds.size.height);
//            [_vwContent addSubview:vcUserProfile.view];
//            [self addChildViewController:vcUserProfile];
        if (vcUser1Profile == nil) {
            vcUser1Profile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"User1ProfileViewController"];
            vcUser1Profile.user_id = [NSString stringWithFormat:@"%d", Global.g_user.user_uid];
            vcUser1Profile.vcParent = self;
            vcUser1Profile.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _vwContent.bounds.size.height);
            [_vwContent addSubview:vcUser1Profile.view];
            [self addChildViewController:vcUser1Profile];
        }
    } else {  //expert
        if (vcExpertUserProfile == nil) {
            vcExpertUserProfile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertUserProfileViewController"];
            vcExpertUserProfile.vcParent = self;
            vcExpertUserProfile.view.frame = CGRectMake(0, 0, _vwContent.bounds.size.width, _vwContent.bounds.size.height);
            [_vwContent addSubview:vcExpertUserProfile.view];
            [self addChildViewController:vcExpertUserProfile];
        }
    }
}

- (IBAction)onclickSearch:(id)sender {
    bOtherPage = false;
    [self removeviewsFromMain];
    [self removeMainPages];

    nCurPageIdx = PAGE_MENU_LIST;
    [self setPage];
    
    nCurButtonIdx = BUTTON_SEARDCH;
    [self changeBottomButton];
    
    [self setDefaulttitle];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pageRefresh" object:nil];
}

- (IBAction)onClickSubmit:(id)sender {
    bOtherPage = false;
    [self removeviewsFromMain];
    
    WorkoutSelectViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WorkoutSelectViewController"];
    [self.navigationController pushViewController:vc animated:NO];

}

@end
