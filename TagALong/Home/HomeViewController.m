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
#import "ProsViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate, ListViewControllerDelegate>{

    MapViewController *vcMap;
    ListViewController *vcList;
    UserProfileViewController *vcUserProfile;
    User1ProfileViewController *vcUser1Profile;
    ExpertUserProfileViewController *vcExpertUserProfile;
    OtherUserProfileViewController *vcOtherProfile;
    ProsViewController *vcPros;
    //NSInteger nCurPageIdx;

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

//Pros
@property (weak, nonatomic) IBOutlet UIImageView *ivPros;
@property (weak, nonatomic) IBOutlet UILabel *lblPros;

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
    
    self.ivPros.image = [[UIImage imageNamed:@"ic_pros"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.ivPros.tintColor = UIColor.whiteColor;
    self.ivPros.layer.borderColor = UIColor.whiteColor.CGColor;
    
    [self setDefaulttitle];
    //[self addAlarmBarButton];
    bOtherPage = false;
    _nCurPageIdx = PAGE_MENU_MAP;
    _nCurButtonIdx = BUTTON_SEARDCH;
    
    if ([Global.g_user.user_login isEqualToString:@"2"]) {
        [self addLogoutButton];
    }

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

-(void)addLogoutButton {
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action: @selector(onClickBack:)];
    self.navigationItem.leftBarButtonItem = editButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.blackColor];
    
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];

    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden: NO animated: YES];
    
    [self setPage];
    [self changeBottomButton];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)successViewTapped {
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
    [_vwPaySuccess setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    _svContetns.contentSize = CGSizeMake(self.view.frame.size.width * 2, _svContetns.bounds.size.height);
    _svContetns.pagingEnabled = YES;
    

    
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
    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(successViewTapped)];
    [_vwPaySuccess addGestureRecognizer:tapReg];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
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
            [self.navigationController pushViewController:vcOtherProfile animated:YES];
            //[_vwContent addSubview:vcOtherProfile.view];
            //[self addChildViewController:vcOtherProfile];
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
    //[self addAlarmBarButton];
    [_ivMapLine setHidden:YES];
    [_ivListLine setHidden:YES];
    //_nCurButtonIdx = BUTTON_SEARDCH;
    if (_nCurPageIdx == PAGE_MENU_MAP) {
    
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
        
    } else if (_nCurPageIdx == PAGE_MENU_LIST) {

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
    
    if (vcPros != nil) {
        [vcPros.view removeFromSuperview];
        vcPros = nil;
    }
}

-(void)changeBottomButton{
    
    NSArray *uiElements = @[_ivProfile, _ivSearch, _ivSubmit, _ivPros, _lblProfile, _lblSearch, _lblSubmit, _lblPros];
    for (UIView *view in uiElements) {
        [view setAlpha:0.5f];
    }
    
    if (_nCurButtonIdx == BUTTON_PROFILE) {
        [_ivProfile setAlpha:1];
        [_lblProfile setAlpha:1];
    } else if (_nCurButtonIdx == BUTTON_SEARDCH) {
        [_ivSearch setAlpha:1];
        [_lblSearch setAlpha:1];
    } else if (_nCurButtonIdx == BUTTON_SUBMIT) {
        [_ivSubmit setAlpha:1];
        [_lblSubmit setAlpha:1];
    } else if (_nCurButtonIdx == BUTTON_PROS) {
        [_ivPros setAlpha:1.0f];
        [_lblPros setAlpha:1.0f];
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
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)onClickBack:(id)sender {
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        if (bOtherPage) {
            [vcOtherProfile.view removeFromSuperview];
            vcOtherProfile = nil;
            bOtherPage = false;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
//            StartedViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartedViewController"];
//            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavLogin"]; //NavExpertLogin
//        [self presentViewController:vc animated:NO completion:nil];
        
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                        [Commons clearUserInfo];
                                        [self.navigationController setNavigationBarHidden:YES animated:NO];
                                        [UIView transitionFromView:self.view
                                                            toView:vc.view
                                                          duration:0.75
                                                           options:UIViewAnimationOptionTransitionFlipFromBottom
                                                        completion:^(BOOL finished) {
                                                            
                                                            appDelegate.window.rootViewController = vc;
                                                        }];
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//sub title

- (IBAction)onClickMap:(id)sender {
    [self removeMainPages];
    _nCurPageIdx = PAGE_MENU_MAP;
    [self setPage];
}
- (IBAction)onClickList:(id)sender {
    [self removeMainPages];
    _nCurPageIdx = PAGE_MENU_LIST;
    [self setPage];
 
}

//bottom
- (IBAction)onClickProfile:(id)sender {
    bOtherPage = false;
    _nCurButtonIdx = BUTTON_PROFILE;
    [self changeBottomButton];
    self.navigationItem.title = @"Profile";
    [self removeviewsFromMain];
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
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

- (IBAction)onClickPros:(id)sender {
    if (!vcPros) {
        bOtherPage = false;
        _nCurButtonIdx = BUTTON_PROS;
        [self changeBottomButton];
        self.navigationItem.title = @"Pros";
        [self removeviewsFromMain];
        vcPros = [[UIStoryboard storyboardWithName:@"ProsViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"ProsViewController"];
        vcPros.view.frame = _vwContent.bounds;
        [_vwContent addSubview:vcPros.view];
        [self addChildViewController:vcPros];
    }
}

- (IBAction)onclickSearch:(id)sender {
    bOtherPage = false;
    [self removeviewsFromMain];
    [self removeMainPages];

    self.navigationItem.title = @"Explore Workouts";
    //[self addAlarmBarButton];
    _nCurPageIdx = PAGE_MENU_LIST;
    [self setPage];
    
    _nCurButtonIdx = BUTTON_SEARDCH;
    [self changeBottomButton];
    
    [self setDefaulttitle];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pageRefresh" object:nil];
}

- (IBAction)onClickSubmit:(id)sender {
    bOtherPage = false;
    [self removeviewsFromMain];
    
    WorkoutSelectViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WorkoutSelectViewController"];
    [self.navigationController pushViewController:vc animated:YES];

}

//-(void)addAlarmBarButton {
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action: nil];
//
//    self.navigationItem.rightBarButtonItem = editButton;
//}

@end
