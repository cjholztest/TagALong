//
//  WorkoutSelectViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "WorkoutSelectViewController.h"
#import "TypeWorkoutViewController.h"
#import "AreaWorkoutViewController.h"
#import "PostWorkoutDetailViewController.h"

@interface WorkoutSelectViewController ()<UIScrollViewDelegate, PostWorkoutDetailViewControllerDelegate>{
    TypeWorkoutViewController *vcTypeWrokout;
    AreaWorkoutViewController *vcAreaWorkout;
    NSInteger nCurPageIdx;
}

@property (strong, nonatomic) IBOutlet UIScrollView *svContent;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *vwBlueBG;
@property (strong, nonatomic) IBOutlet UIView *backArrowView;

@end

@implementation WorkoutSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    nCurPageIdx = PAGE_MENU_TYPE;
    
    [SharedAppDelegate showLoading];
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [_vwBlueBG setHidden:YES];
    } else {
        [_vwBlueBG setHidden:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    _svContent.contentSize = CGSizeMake(self.view.frame.size.width * 2, _svContent.bounds.size.height);
    _svContent.pagingEnabled = YES;
    
    [self setPage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.blackColor];
    
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden: NO animated: YES];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationController.navigationItem.rightBarButtonItem = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user defined functions
//PostWorkoutDetailViewController Delegate
-(void)dismiss{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)setPage {
    
    if (nCurPageIdx == PAGE_MENU_TYPE) {
        self.navigationItem.title = @"Workout Type";
        //_lblTitle.text = @"Type of Workout";
        _svContent.contentOffset = CGPointMake(_svContent.frame.size.width * (0), 0);
        if (vcTypeWrokout == nil) {
            vcTypeWrokout = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TypeWorkoutViewController"];
            vcTypeWrokout.vcParent = self;
            vcTypeWrokout.view.frame = CGRectMake(0, 0, _svContent.bounds.size.width, _svContent.bounds.size.height);
            [_svContent addSubview:vcTypeWrokout.view];
            [self addChildViewController:vcTypeWrokout];
            [SharedAppDelegate closeLoading];
        }
        //[];
        [UIView animateWithDuration:0.25 animations:^{
            [self.backArrowView setAlpha:0.5];
        }];
        
    } else if (nCurPageIdx == PAGE_MENU_AREA) {
        //_lblTitle.text = @"Focus Area of the Workout";
        self.navigationItem.title = @"Workout Focus Area";
        _svContent.contentOffset = CGPointMake(_svContent.frame.size.width * (1), 0);
        if (vcAreaWorkout == nil) {
            vcAreaWorkout = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AreaWorkoutViewController"];
            vcAreaWorkout.vcParent = self;
            vcAreaWorkout.view.frame = CGRectMake(_svContent.bounds.size.width, 0, _svContent.bounds.size.width, _svContent.bounds.size.height);
            [_svContent addSubview:vcAreaWorkout.view];
            [self addChildViewController:vcAreaWorkout];
            [SharedAppDelegate closeLoading];
        }
        [UIView animateWithDuration:0.25 animations:^{
            [self.backArrowView setAlpha:1];
        }];
    }
}

#pragma mark - click events
- (IBAction)onClickRight:(id)sender {
    
    if (nCurPageIdx == PAGE_MENU_TYPE) {
        if ([vcTypeWrokout.sport_uid isEqualToString:@""] ||vcTypeWrokout.sport_uid == nil ) {
            vcTypeWrokout.sport_uid = @"6";
        }
        nCurPageIdx = PAGE_MENU_AREA;
        [self setPage];
    } else {
        if ([vcAreaWorkout.categories isEqualToString:@""] ||vcAreaWorkout.categories == nil ) {
            vcAreaWorkout.categories = @"7";
        }

        PostWorkoutDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PostWorkoutDetailViewController"];
        vc.delegate = self;
        vc.categories = vcAreaWorkout.categories;
        vc.sport_uid = vcTypeWrokout.sport_uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)onClickLeft:(id)sender {
    if (nCurPageIdx == PAGE_MENU_TYPE) {
        [self dismiss];
    } else {
        nCurPageIdx = PAGE_MENU_TYPE;
        [self setPage];
    }
}
- (IBAction)onClickBack:(id)sender {
    [self dismiss];
}

@end
