//
//  MExpertUser.h
//  Tagalong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MExpertUser : NSObject

@property(nonatomic, assign) int export_uid;
@property(nonatomic, retain) NSString *export_email;
@property(nonatomic, retain) NSString *export_pwd;
@property(nonatomic, retain) NSString *export_login; //1:general 2:expert
@property(nonatomic, retain) NSString *export_phone;
@property(nonatomic, retain) NSString *export_id;
@property(nonatomic, retain) NSString *export_nm;
@property(nonatomic, retain) NSString *export_nck;
@property(nonatomic, retain) NSString *export_last_nm;
@property(nonatomic, retain) NSString *expert_profile_img;
@property(nonatomic, retain) NSString *expert_location;
@property(nonatomic, retain) NSString *expert_sport;
@property(nonatomic, retain) NSString *expert_communication;
@property(nonatomic, retain) NSString *expert_content;

@property(nonatomic, retain) NSString *expert_latitude;
@property(nonatomic, retain) NSString *expert_longitude;

@end


