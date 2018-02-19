//
//  AddressViewController.m
//  TagALong
//
//  Created by rabbit on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "PassForgetViewController.h"


@interface PassForgetViewController ()<UITextFieldDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UIImageView *ivBackground;

@end

@implementation PassForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        _ivBackground.image = [UIImage imageNamed:@"bg_login.png"];
    } else {
        _ivBackground.image = [UIImage imageNamed:@"bg_login1.png"];
    }

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Background:)];
    [self.view addGestureRecognizer:singleFingerTap];

}

//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}

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
    [_tfEmail resignFirstResponder];
}

-(BOOL)CheckValidEmailType{
    
    if (_tfEmail.text.length == 0) {
        [Commons showToast:@"Input email!"];
        return NO;
    }
    
    if (![Commons checkEmail:_tfEmail.text]) {
        [Commons showToast:@"Please enter in email format."];
        return NO;
    }
    
    return YES;
}


#pragma mark - click events

- (IBAction)onClickReset:(id)sender {

    if ([self CheckValidEmailType]) {
        [self reqFindPassword];
    }
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - Network
-(void)reqFindPassword{
    NSString *_email = _tfEmail.text;
    
    //    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_URL, API_TYPE_REGISTER];
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_FIND_PASSWORD,
                             API_REQ_KEY_USER_EMAIL         :   _email,
                             API_REQ_KEY_LOGIN_TYPE         :   Global.g_user.user_login,
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
            
            [Commons showToast:@"It has been sent out successfully."];
            [self.navigationController popViewControllerAnimated:NO];
            
        }   else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
            [Commons showToast:@"User does not exist."];
            [_tfEmail becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

@end
