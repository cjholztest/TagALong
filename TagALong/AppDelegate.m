//
//  AppDelegate.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import <Stripe/Stripe.h>

const NSString *kStripeAccountTestKey = @"pk_test_VKdmHHXsKzJ8L7VQecG4HcSh";
const NSString *kStripeAccountLiveKey = @"pk_live_aXftjw1cnlbTAhz1juzgtM6I";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL isStripeTest = YES;
    
    NSString *key = [NSString stringWithFormat:@"%@", isStripeTest ? kStripeAccountTestKey : kStripeAccountLiveKey];
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:key];
    
    //Global.g_token = [[NSUserDefaults standardUserDefaults] stringForKey:PREFCONST_TOKEN];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"content---%@", token);
//    
//    Global.g_token = token;
//    
//    [[NSUserDefaults standardUserDefaults] setValue:token forKey:PREFCONST_TOKEN];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

- (void)showLoading {
    [[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleCustom];
    [[SVProgressHUD appearance] setForegroundColor:UIColorFromRGB(0x27AAE1)];
    [[SVProgressHUD appearance] setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

- (void)closeLoading {
    [SVProgressHUD dismiss];
}

@end
