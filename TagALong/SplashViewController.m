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
            if (![email isEqualToString:@""] && ![pass isEqualToString:@""] ) {
                [self ReqLogin:email pass:pass];
            } else {
                [self goLogin];
            }
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
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)goHome{
//    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavStart"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)goExpertHome{

    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavHome"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)showAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    [self goLogin];
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Network
-(void)ReqLogin:(NSString *)email pass:(NSString*)pass{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"login"];
    //NSString *url = [NSString stringWithFormat:SERVER_URL, @"login"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_EMAIL         :   email,
                             API_REQ_KEY_USER_PWD           :   pass,
                             API_REQ_KEY_LOGIN_TYPE         :   @"1",
                             };
    
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [Commons parseAndSaveUserInfo:responseObject pwd: pass];
            
            [self goHome];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [self showAlert:@"The password is incorrects"];
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [self showAlert:@"User does not exist"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [self showAlert:@"Failed to communicate with the server"];
    }];
}


#pragma mark - Network
-(void)ReqExpertLogin:(NSString *)email1 pass:(NSString*)pass1{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"login"];
    //NSString *url = [NSString stringWithFormat:SERVER_URL, @"login"];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_EMAIL         :   email1,
                             API_REQ_KEY_USER_PWD           :   pass1,
                             API_REQ_KEY_LOGIN_TYPE         :   @"2",
                             };
    
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            [Commons parseAndSaveExpertUserInfo:responseObject pwd:pass1];
            
            [self goExpertHome];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [self showAlert:@"The password is incorrects"];
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [self showAlert:@"User does not exist"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [self showAlert:@"Failed to communicate with the server"];
    }];
}


@end
