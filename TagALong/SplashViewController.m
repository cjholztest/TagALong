//
//  SplashViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "SplashViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeViewController.h"

@interface SplashViewController (){
    float latitude;
    float longitude;

}
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(goLogin)
                                   userInfo:nil
                                    repeats:NO];
    if (Global.g_user == nil)
        Global.g_user = [MUser alloc];
    if (Global.g_expert == nil)
        Global.g_expert = [MExpertUser alloc];
    
    
    //Boolean autologin = [Preference getBoolean:PREFCONST_AUTO_LOGIN default:false];
    NSString *user_login = [Preference getString:PREFCONST_LOGIN_TYPE default:@"1"];
    Global.g_user.user_login = user_login;
    if ([user_login isEqualToString:@"1"]) {
        NSString *email = [Preference getString:PREFCONST_LOGIN_EMAIL default:nil];
        NSString *pass = [Preference getString:PREFCONST_LOGIN_PWD default:nil];

        if (email != nil && pass != nil) {
            [self ReqLogin:email pass:pass];
        } else {
            [self goLogin];
        }
    } else {
        NSString *email1 = [Preference getString:PREFCONST_EXPERT_LOGIN_EMAIL default:nil];
        NSString *pass1 = [Preference getString:PREFCONST_EXPERT_LOGIN_PWD default:nil];
        if (email1 != nil && pass1 != nil) {
            [self ReqExpertLogin:email1 pass:pass1];
        } else {
            [self goLogin];
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)goLogin{
    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavLogin"]; 
    [self presentViewController:vc animated:NO completion:nil];
}

-(void)goHome{
//    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavHome"];
    [self presentViewController:vc animated:NO completion:nil];

}


#pragma mark - Network
-(void)ReqLogin:(NSString *)email pass:(NSString*)pass{
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_LOGIN,
                             API_REQ_KEY_USER_EMAIL         :   email,
                             API_REQ_KEY_USER_PWD           :   pass,
                             API_REQ_KEY_LOGIN_TYPE         :   @"1",
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude],
                             API_REQ_KEY_TOKEN              :   Global.g_token,
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
            
            [Commons parseAndSaveUserInfo:responseObject pwd:pass];
            [self goHome];
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


#pragma mark - Network
-(void)ReqExpertLogin:(NSString *)email1 pass:(NSString*)pass1{
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_LOGIN,
                             API_REQ_KEY_USER_EMAIL         :   email1,
                             API_REQ_KEY_USER_PWD           :   pass1,
                             API_REQ_KEY_LOGIN_TYPE         :   @"2",//expert
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude],
                             API_REQ_KEY_TOKEN              :   Global.g_token,
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

            [Commons parseAndSaveExpertUserInfo:responseObject pwd:pass1];
            [self goHome];
        } else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        } else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}


@end
