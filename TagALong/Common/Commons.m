//
//  Commons.m
//  Tagalong
//
//  Created by rabbit J. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import "Commons.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "OneBtnDlgViewController.h"

@import AdSupport;

@implementation Commons

+ (NSString *)identifierForAdvertising
{
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        
        return [IDFA UUIDString];
    }
    
    return nil;
}

+ (NSString*)generateMD5:(NSString*) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (NSString*)generateBase64:(NSString*)input {
    NSData *plainData = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}


+ (NSString*)getUserAdvertiseKey {
    NSString *IDFA = [self identifierForAdvertising];
    if (IDFA == nil)
        return nil;
    return [self generateMD5:IDFA];
}

+ (NSString*)getUserAdvertiseKey2 {
    NSString *IDFA = [self identifierForAdvertising];
    if (IDFA == nil)
        return nil;
    return [self generateBase64:IDFA];
}

+ (NSString*)getUserDeviceSerialNo {
    NSString *token = @"";
//    NSString *token = [Preference getString:PREFCONST_TOKEN default:@""];
    return token;
}

+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

/**
 * 로그인 API연동 후에 서버로 부터 받은 사용자 정보 저장
 */
+ (void)parseAndSaveUserInfo:(NSDictionary*)jResult pwd:(NSString*)strPwd {
    
    if (Global.g_user == nil)
        Global.g_user = [MUser alloc];
    
    @try {
        Global.g_user.user_uid = [[jResult objectForKey:API_RES_KEY_USER_UID] intValue];
        Global.g_user.user_email = [jResult objectForKey:API_RES_KEY_USER_EMAIL];
        Global.g_user.user_phone = [jResult objectForKey:API_RES_KEY_USER_PHONE];
        Global.g_user.user_id = [jResult objectForKey:API_RES_KEY_USER_ID];
        Global.g_user.user_nm = [jResult objectForKey:API_RES_KEY_USER_NM];
        Global.g_user.user_nck = [jResult objectForKey:API_RES_KEY_USER_NCK];
        Global.g_user.user_last_nm = [jResult objectForKey:API_RES_KEY_USER_LAST_NAME];
        Global.g_user.user_profile_img = [jResult objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        Global.g_user.user_age = [jResult objectForKey:API_RES_KEY_USER_AGE];
        Global.g_user.user_gender = [jResult objectForKey:API_RES_KEY_USER_GENDER];
        Global.g_user.user_location = [jResult objectForKey:API_RES_KEY_USER_LOCATION];
        Global.g_user.user_login = @"1";
        Global.access_token = jResult[@"token"];
        
        [self saveUserInfoToPrefrence:strPwd];
    }  @catch (NSException *e) {
        Global.g_user = nil;
        return;
    }
    
}

/**
 * 로그인 API연동 후에 서버로 부터 받은 사용자 정보 저장
 */
+ (void)parseAndSaveExpertUserInfo:(NSDictionary*)jResult pwd:(NSString*)strPwd {
    
    if (Global.g_expert == nil)
        Global.g_expert = [MExpertUser alloc];
    
    @try {
        Global.g_expert.export_uid = [[jResult objectForKey:API_RES_KEY_EXPERT_UID] intValue];
        Global.g_expert.export_email = [jResult objectForKey:API_RES_KEY_EXP0RT_EMAIL];
        Global.g_expert.export_phone = [jResult objectForKey:API_RES_KEY_EXPpRT_PHONE];
        Global.g_expert.export_id = [jResult objectForKey:API_RES_KEY_USER_ID];
        Global.g_expert.export_nm = [jResult objectForKey:API_RES_KEY_USER_NM];
        Global.g_expert.export_nck = [jResult objectForKey:API_RES_KEY_USER_NCK];
        Global.g_expert.export_last_nm = [jResult objectForKey:API_RES_KEY_USER_LAST_NAME];
        Global.g_expert.expert_profile_img = [jResult objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        Global.g_expert.expert_location = [jResult objectForKey:API_RES_KEY_USER_LOCATION];
        Global.g_expert.expert_sport = [jResult objectForKey:API_RES_KEY_EXPERT_SPORT];
        Global.g_expert.expert_content = [jResult objectForKey:API_RES_KEY_EXPERT_CONTENT];
        Global.g_user.user_login = @"2";
        Global.g_expert.expert_communication = [jResult objectForKey:API_RES_KEY_EXPERT_COMMUNICATION];
        Global.g_expert.expert_content = [jResult objectForKey:API_RES_KEY_EXPERT_CONTENT];
        Global.access_token = jResult[@"token"];
        
        [self saveExpertUserInfoToPrefrence:strPwd];
    }  @catch (NSException *e) {
        Global.g_user = nil;
        return;
    }
}

/**
 * 사용자정보 저장
 */
+ (void) saveUserInfoToPrefrence:(NSString*) pwd {
    
    [Preference setString:PREFCONST_LOGIN_EMAIL value:Global.g_user.user_email];
    [Preference setString:PREFCONST_LOGIN_PWD value:pwd];
    [Preference setString:PREFCONST_LOGIN_TYPE value:@"1"];
    [Preference setString:PREFCONST_PHONE value:Global.g_user.user_phone];
    [Preference setString:PREFCONST_ID value:Global.g_user.user_id];
    [Preference setString:PREFCONST_NM value:Global.g_user.user_nm];
    [Preference setString:PREFCONST_NCK value:Global.g_user.user_nck];
    [Preference setString:PREFCONST_LAST_NAME value:Global.g_user.user_last_nm];
    [Preference setString:PREFCONST_PROFILE value:Global.g_user.user_profile_img];
    [Preference setString:PREFCONST_AGE value:Global.g_user.user_age];
    [Preference setString:PREFCONST_GENDER value:Global.g_user.user_gender];
    [Preference setString:PREFCONST_LOCATION value:Global.g_user.user_location];
    [Preference setBoolean:PREFCONST_AUTO_LOGIN value:true];
//    [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
//    [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];
}

/**
 * expert 사용자정보 저장
 */
+ (void) saveExpertUserInfoToPrefrence:(NSString*) pwd {
    
    [Preference setString:PREFCONST_EXPERT_LOGIN_EMAIL value:Global.g_expert.export_email];
    [Preference setString:PREFCONST_EXPERT_LOGIN_PWD value:pwd];
    [Preference setString:PREFCONST_LOGIN_TYPE value:@"2"];
    [Preference setString:PREFCONST_EXPERT_PHONE value:Global.g_expert.export_phone];
    [Preference setString:PREFCONST_EXPERT_ID value:Global.g_expert.export_id];
    [Preference setString:PREFCONST_EXPERT_NM value:Global.g_expert.export_nm];
    [Preference setString:PREFCONST_EXPERT_NCK value:Global.g_expert.export_nck];
    [Preference setString:PREFCONST_EXPERT_LAST_NAME value:Global.g_expert.export_last_nm];
    [Preference setString:PREFCONST_EXPERT_PROFILE value:Global.g_expert.expert_profile_img];
    [Preference setString:PREFCONST_EXPERT_CONTENT value:Global.g_expert.expert_content];
    [Preference setString:PREFCONST_EXPERT_COMMUNICATION value:Global.g_expert.expert_communication];
    [Preference setString:PREFCONST_EXPERT_LOCATION value:Global.g_expert.expert_location];
    [Preference setString:PREFCONST_EXPERT_SPORT value:Global.g_expert.expert_sport];
    [Preference setBoolean:PREFCONST_AUTO_LOGIN value:true];
}

+ (void) clearUserInfo {
    Global.g_user.user_email = nil;
    Global.g_user.user_pwd = nil;
    Global.g_expert.export_email = nil;
    Global.g_expert.export_pwd = nil;
    Global.g_user.user_login = @"1";
    
    [Preference setString:PREFCONST_LOGIN_EMAIL value:@""];
    [Preference setString:PREFCONST_LOGIN_PWD value:@""];

    [Preference setString:PREFCONST_EXPERT_LOGIN_EMAIL value:@""];
    [Preference setString:PREFCONST_EXPERT_LOGIN_PWD value:@""];

}

+ (BOOL)checkEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValidEmail = [emailTest evaluateWithObject:email];
    
    return isValidEmail;
}

+ (BOOL)checkPassword:(NSString *)password {
    NSString *passwordRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *passwordCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    
    BOOL isValidPassword = [passwordCheck evaluateWithObject:password];
    
    return isValidPassword;
}

+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    NSString *phoneNumberRegex = @"[\\+]{0,1}[0-9]{6,14}$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    BOOL isPhoneNumberValid = [phoneNumberTest evaluateWithObject:phoneNumber];
    return isPhoneNumberValid;
}

+ (void)showToast:(NSString*)msg{
    MDToast *toast = [[MDToast alloc] init];
    toast.text = msg;
    [toast show];
}

+ (void)showOneBtnDlg:(NSString*)msg id:(id)parent{
    OneBtnDlgViewController *dlgOneBtn = [[OneBtnDlgViewController alloc] initWithNibName:@"OneBtnDlgViewController" bundle:nil];
    dlgOneBtn.providesPresentationContextTransitionStyle = YES;
    dlgOneBtn.definesPresentationContext = YES;
    [dlgOneBtn setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    dlgOneBtn.str = msg;
    
    [parent presentViewController:dlgOneBtn animated:NO completion:nil];
}

+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

+ (BOOL)isStringNumeric:(NSString*)string {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [string rangeOfCharacterFromSet:notDigits].location == NSNotFound;
}

@end
