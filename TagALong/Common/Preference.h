//
//  Preference.h
//  TagALong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PREFCONST_LOGIN_TYPE        @"pref_login_type"
#define PREFCONST_LOGIN_EMAIL       @"pref_login_email"
#define PREFCONST_LOGIN_PWD         @"pref_login_pwd"
#define PREFCONST_TOKEN             @"pref_token"
#define PREFCONST_UID               @"pref_uid"
#define PREFCONST_PHONE             @"pref_phone"
#define PREFCONST_ID                @"pref_id"
#define PREFCONST_NM                @"pref_nm"
#define PREFCONST_NCK               @"pref_nck"
#define PREFCONST_LAST_NAME         @"pref_last_name"
#define PREFCONST_PROFILE           @"pref_profile_img"
#define PREFCONST_AGE               @"pref_age"
#define PREFCONST_GENDER            @"pref_gender"
#define PREFCONST_LOCATION          @"pref_location"
#define PREFCONST_LATITUDE          @"pref_latitude"
#define PREFCONST_LONGTITUDE        @"pref_longtitude"
#define PREFCONST_AUTO_LOGIN        @"auto_login"
#define PREFCONST_ADDRESS_UID       @"address_uid"

#define PREFCONST_EXPERT_LOGIN_TYPE        @"pref_expert_login_type"
#define PREFCONST_EXPERT_LOGIN_EMAIL       @"pref_expert_login_email"
#define PREFCONST_EXPERT_LOGIN_PWD         @"pref_expert_login_pwd"
#define PREFCONST_EXPERT_TOKEN             @"pref_expert_token"
#define PREFCONST_EXPERT_UID               @"pref_expert_uid"
#define PREFCONST_EXPERT_PHONE             @"pref_expert_phone"
#define PREFCONST_EXPERT_ID                @"pref_expert_id"
#define PREFCONST_EXPERT_NM                @"pref_expert_nm"
#define PREFCONST_EXPERT_NCK               @"pref_expert_nck"
#define PREFCONST_EXPERT_LAST_NAME         @"pref_expert_last_name"
#define PREFCONST_EXPERT_PROFILE           @"pref_expert_profile_img"
#define PREFCONST_EXPERT_LOCATION          @"pref_expert_location"
#define PREFCONST_EXPERT_CONTENT            @"pref_expert_content"
#define PREFCONST_EXPERT_SPORT              @"pref_expert_sport"
#define PREFCONST_EXPERT_COMMUNICATION      @"pref_expert_communicatiom"


@interface Preference : NSObject

+ (BOOL)getBoolean:(NSString*)strkey default:(BOOL)defalut;
+ (int)getInt:(NSString*)strkey default:(int)defalut;
+ (NSString*)getString:(NSString*)strkey default:(NSString*)defalut;
+ (void)setInt:(NSString*)strkey value:(int)value;
+ (void)setDouble:(NSString*)strkey value:(double)value;
+ (void)setBoolean:(NSString*)strkey value:(BOOL)value;
+ (void)setString:(NSString*)strkey value:(NSString*)value;
+ (int)getDouble:(NSString*)strkey default:(double)defalut ;
@end
