//
//  MUser.h
//  Tagalong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUser : NSObject

@property(nonatomic, assign) int user_uid;
@property(nonatomic, retain) NSString *user_email;
@property(nonatomic, retain) NSString *user_pwd;
@property(nonatomic, retain) NSString *user_login; //1:general 2:expert
@property(nonatomic, retain) NSString *user_phone;
@property(nonatomic, retain) NSString *user_id;
@property(nonatomic, retain) NSString *user_nm;
@property(nonatomic, retain) NSString *user_nck;
@property(nonatomic, retain) NSString *user_last_nm;
@property(nonatomic, retain) NSString *user_profile_img;
@property(nonatomic, retain) NSString *user_location;
@property(nonatomic, retain) NSString *user_age;
@property(nonatomic, retain) NSString *user_gender;
@property(nonatomic, retain) NSString *user_latitude;
@property(nonatomic, retain) NSString *user_longitude;

@end

