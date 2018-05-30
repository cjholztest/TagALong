//
//  AddressViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "AddressViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AddressViewController () <UITextFieldDelegate>{
    float latitude;
    float longitude;

}
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITextField *tfAddress;
@property (strong, nonatomic) IBOutlet UITextField *tfZip;
@property (strong, nonatomic) IBOutlet UITextField *tfTitle;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage: [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.blackColor];
    
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
-(void)Background:(UITapGestureRecognizer *)recognizer{
    [_tfAddress resignFirstResponder];
    [_tfZip resignFirstResponder];
    [_tfTitle resignFirstResponder];
}

-(BOOL)CheckValidValue{

    if (_tfTitle.text.length == 0) {
        [Commons showToast:@"Input title!"];
        return NO;
    }
    
    if (_tfAddress.text.length == 0) {
        [Commons showToast:@"Input email!"];
        return NO;
    }
    
    if (_tfZip.text.length == 0) {
        [Commons showToast:@"Input zip code!"];
        return NO;
    }
    
    return YES;
}

-(void)goGpsPosFromZip :(NSString *)code{
    if ([self CheckValidValue]) {
       CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
       [geoCoder geocodeAddressString:@"ZIP CODE HERE" completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"Latitude %f", coordinate.latitude);
        NSLog(@"Longitude %f", coordinate.longitude);
           latitude = coordinate.latitude;
           longitude = coordinate.longitude;
           [self reqRegAddress];

       }];
    }
}

#pragma mark - click events

- (IBAction)onClickConfirm:(id)sender {
    
//    if ([self CheckValidValue]) {
//        [self reqRegAddress];
//    }
    
//    [self goGpsPosFromZip:_tfZip.text];
    
    if (_tfTitle.text.length == 0) {
        [Commons showToast:@"Input title!"];
        return;
    }
    
    if (_tfAddress.text.length == 0) {
        [Commons showToast:@"Input address!"];
        return;
    }
    
    if (_tfZip.text.length == 0) {
        [Commons showToast:@"Input zipcode!"];
        return;
    }
    
    //get address
    CLLocationCoordinate2D code = [Commons geoCodeUsingAddress:_tfAddress.text];
    latitude = code.latitude;
    longitude = code.longitude;
    
    [self reqRegAddress];
}

- (IBAction)onClickclose:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Network
-(void)reqRegAddress{
    NSString *address = _tfAddress.text;
    NSString *zip_code = _tfZip.text;
    NSString *title = _tfTitle.text;
    
//    latitude = self.locationManager.location.coordinate.latitude;
//    longitude = self.locationManager.location.coordinate.longitude;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"reg_address"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_TITLE              :   title,
                             API_REQ_KEY_ADDRESS            :   address,
                             API_REQ_KEY_ZIP                :   zip_code,
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude]
                             };
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //NSError* error;
//        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                       options:kNilOptions
//                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [Commons showToast:@"It has been add successfully."];
            [self.delegate PageRefresh];
            [self.navigationController popViewControllerAnimated:NO];
            
        } else if(res_code == RESULT_ERROR_ZIPCODE_DUPLICATE){
            
            [Commons showToast:@"This zip code has been duplicated"];
        } else if(res_code == RESULT_ERROR_TITLE_DUPLICATE){
            
            [Commons showToast:@"This title has been duplicated"];
        } else if(res_code == RESULT_ERROR_DB){
            
            [Commons showToast:@"DB conncet is error"];
        } else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
            [Commons showToast:@"User does not exist."];
        } else if(res_code == RESULT_ERROR_PARAMETER){
            
            [Commons showToast:@"Incorrect parameter!"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError *jsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        NSString *errorMessage = dict[@"error"][@"message"];
        NSError *errorToDisplay = nil;
        
        [SharedAppDelegate closeLoading];
    }];
}

@end
