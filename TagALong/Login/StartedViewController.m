//
//  StartedViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "StartedViewController.h"
#import "HomeViewController.h"
#import "AddressViewController.h"
#import "SelectWorkoutTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface StartedViewController ()<UITableViewDelegate, UITableViewDataSource, AddressViewControllerDelegate, CLLocationManagerDelegate>{
    BOOL isSelectOpen;
}
@property (nonatomic, strong) NSMutableArray *arrAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcvwSelectHeight;
@property (weak, nonatomic) IBOutlet UITableView *tvAddress;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation StartedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isSelectOpen = false;
    _lcvwSelectHeight.constant = 0;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];

    [self.tvAddress registerNib:[UINib nibWithNibName:@"SelectWorkoutTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectWorkoutTableViewCell"];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    
    return _arrAddress.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SelectWorkoutTableViewCell";
    SelectWorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    NSDictionary *dic = _arrAddress[indexPath.row];
    cell.lblTitle.text = [dic objectForKey:API_REQ_KEY_TITLE];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
    NSDictionary *dic = _arrAddress[indexPath.row];
    Global.g_user.user_latitude = [dic objectForKey:API_RES_KEY_LATITUDE] ;
    Global.g_user.user_longitude = [dic objectForKey:API_RES_KEY_LONGITUDE];
    NSString *address_uid = [dic objectForKey:API_REQ_KEY_ADDRESS_UID];
    
    NSLog(@"Global.g_user.user_latitude = %@", Global.g_user.user_latitude);
    NSLog(@"Global.g_user.user_longitude = %@", Global.g_user.user_longitude);
    
    [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
    [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];
    [Preference setString:PREFCONST_ADDRESS_UID value:address_uid];
    [self goHome];

}


#pragma mark - user defined functions
-(void)goHome{
    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    //UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavHome"];
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:nil];

}

//address delegate
- (void)PageRefresh{
    [self ReqGetAddressList];
}

#pragma mark - click events
- (IBAction)onClickSelArea:(id)sender {
    isSelectOpen = !isSelectOpen;
    if (isSelectOpen) {
        _lcvwSelectHeight.constant = 200;
        [self ReqGetAddressList];
    } else {
        _lcvwSelectHeight.constant = 0;
    }
}

- (IBAction)onClickMyArea:(id)sender {
    //get address
    double latitude = self.locationManager.location.coordinate.latitude;
    double longitude = self.locationManager.location.coordinate.longitude;

    Global.g_user.user_latitude = [NSString stringWithFormat:@"%f", latitude];
    Global.g_user.user_longitude = [NSString stringWithFormat:@"%f", longitude];
    
    NSLog(@"Global.g_user.user_latitude = %@", Global.g_user.user_latitude);
    NSLog(@"Global.g_user.user_longitude = %@", Global.g_user.user_longitude);
    
    [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
    [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];
    [Preference setString:PREFCONST_ADDRESS_UID value:@""];
    [self goHome];
}


- (IBAction)onClickAddress:(id)sender {
    AddressViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddressViewController"];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onClickBack:(id)sender {
    
    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavLogin"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you shure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                    [Commons clearUserInfo];
                                    
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

#pragma mark - Network
-(void)ReqGetAddressList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_GET_ADDRESS,
                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%D", Global.g_user.user_uid]
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
            
            _arrAddress = [responseObject objectForKey:API_RES_KEY_ADDRESS_LIST];
            [_tvAddress reloadData];
            
        } else if (res_code == RESULT_ERROR_USER_NO_EXIST) {
            [Commons showToast:@"User does not exist."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
    
}

@end
