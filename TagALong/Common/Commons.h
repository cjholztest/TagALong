//
//  Commons.h
//  Tagalong
//
//  Created by rabbit J. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Commons : NSObject


+ (void)parseAndSaveUserInfo:(NSDictionary*)jResult pwd:(NSString*)strPwd;
+ (void)parseAndSaveExpertUserInfo:(NSDictionary*)jResult pwd:(NSString*)strPwd;
+ (BOOL)checkEmail:(NSString *)email ;
+ (void)saveSettingToPrefrence;
+ (void)LoadSettingFromPrefrence;
+ (void)saveUserInfoToPrefrence;
+ (void)saveExpertUserInfoToPrefrence;
+ (void)showToast:(NSString*)msg;
+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address;
+ (void) clearUserInfo ;
+ (void)showOneBtnDlg:(NSString*)msg id:(id)parent;
+ (BOOL)checkPassword:(NSString *)password;
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;
+ (BOOL)isStringNumeric:(NSString*)string;

@end
