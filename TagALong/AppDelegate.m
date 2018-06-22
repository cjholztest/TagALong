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
#import <UserNotifications/UserNotifications.h>

const NSString *kStripeAccountTestKey = @"pk_test_VKdmHHXsKzJ8L7VQecG4HcSh";
const NSString *kStripeAccountLiveKey = @"pk_live_aXftjw1cnlbTAhz1juzgtM6I";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL isStripeTest = NO;
    
    NSString *key = [NSString stringWithFormat:@"%@", isStripeTest ? kStripeAccountTestKey : kStripeAccountLiveKey];
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:key];
    
//    [self registerForPushNotification];
    
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

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    
    NSString *tok = [NSString stringWithFormat:@"%02.2hhx", deviceToken];
    NSLog(@"dev token = %@", tok);
    
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token: %@", token);
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"token: %@", token);
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"token: %@", token);
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"device_token"];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  ) {
        NSLog(@"didReceiveRemoteNotification");
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error) {
        NSLog(@"error register notification %@", error.localizedDescription);
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [self getNotificationSettings];
}

- (void)showLoading {
    [[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleCustom];
    [[SVProgressHUD appearance] setForegroundColor:UIColorFromRGB(0x27AAE1)];
    [[SVProgressHUD appearance] setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

- (void)closeLoading {
    [SVProgressHUD dismiss];
}

- (void)registerForPushNotification {
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"is granted: %@", granted ? @"YES" : @"NO");
        if (granted) {
            [self getNotificationSettings];
        }
        if (error) {
            NSLog(@"granted error %@", error.localizedDescription);
        }
    }];
}

- (void)getNotificationSettings {
    [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"Settings: %@", settings);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (settings.authorizationStatus != UNAuthorizationStatusNotDetermined) {
                NSLog(@"didRegisterUser");
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        });
    }];
}

@end
