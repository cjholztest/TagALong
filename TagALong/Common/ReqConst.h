//
//  ReqConst.h
//  yuisu
//
//  Created by Rabbit J. on 9/30/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#ifndef ReqConst_h
#define ReqConst_h

/** TenSec 서버 주소**/
//#define SERVER_URL          @"http://192.168.0.30:11117/api/"
//#define SERVER_URL          @"http://192.168.0.10:9983/api/"
#define SERVER_URL            @"http://54.70.143.61/api/"
#define TEST_SERVER_URL       @"http://18.218.218.141:8080/api/"

/**
 * API REQ KEY
 */
#define API_REQ_KEY_TYPE                        @"api_type"
#define API_REQ_KEY_USER_UID                    @"usr_uid"
#define API_REQ_KEY_USER_NICKNAME               @"user_nck"
#define API_REQ_KEY_USER_LAST_NAME              @"user_last_name"
#define API_REQ_KEY_USER_EMAIL                  @"user_email"
#define API_REQ_KEY_USER_CITY                   @"user_city"
#define API_REQ_KEY_USER_PHONE                  @"user_phone"
#define API_REQ_KEY_USER_PWD                    @"user_pwd"
#define API_REQ_KEY_USER_LONGITUDE              @"longitude"
#define API_REQ_KEY_USER_LATITUDE               @"latitude"
#define API_REQ_KEY_COMMUNICATION               @"communication"
#define API_REQ_KEY_SPORT                       @"sport"
#define API_REQ_KEY_SPORT_UID                   @"sport_uid"
#define API_REQ_KEY_CONTENT                     @"content"
#define API_REQ_KEY_LOGIN_TYPE                  @"login_type"
#define API_REQ_KEY_TOKEN                       @"token"
#define API_REQ_KEY_ADDRESS                     @"address"
#define API_REQ_KEY_ZIP                         @"zip"
#define API_REQ_KEY_TITLE                       @"title"
#define API_REQ_KEY_CATEGORIES                  @"categories"
#define API_REQ_KEY_WORKOUT_DATE                @"workout_date"
#define API_REQ_KEY_START_TIME                  @"start_time"
#define API_REQ_KEY_DURATION                    @"duration"
#define API_REQ_KEY_AMOUNT                      @"amount"
#define API_REQ_KEY_ADDITION                    @"addition"
#define API_REQ_KEY_USER_LOCATION               @"location"
#define API_REQ_KEY_SORT_TYPE                   @"sort_type"
#define API_REQ_KEY_LEVEL_FILTER                @"level_filter"
#define API_REQ_KEY_SPORTS_FILTER               @"sports_filter"
#define API_REQ_KEY_CATEGORIES_FILTER           @"categories_filter"
#define API_REQ_KEY_DISTANCE_limit              @"distance_limit"
#define API_REQ_KEY_WORKOUT_UID                 @"workout_uid"
#define API_REQ_KEY_EXPERT_UID                  @"export_uid"
#define API_REQ_KEY_EXPERT_PHONE                @"export_phone"
#define API_REQ_KEY_TARGET_DATE                 @"target_date"
#define API_REQ_KEY_UPFILE                      @"upfile"
#define API_REQ_KEY_LEVEL                       @"level"
#define API_REQ_KEY_EXPORT_NCK_NM               @"export_nck_nm"
#define API_REQ_KEY_USER_PROFILE_IMG            @"profile_img"
#define API_REQ_KEY_IS_MAP                      @"is_map"
#define API_REQ_KEY_PAGE_NUM                    @"page_num"
#define API_REQ_KEY_ADDRESS_UID                 @"address_uid"

/**
 * API RESULT KEY
 */
#define API_RES_KEY_TYPE                        @"api_type"
#define API_RES_KEY_RESULT_CODE                 @"res_code"
#define API_RES_KEY_USER_UID                    @"usr_uid"
#define API_RES_KEY_USER_EMAIL                  @"user_email"
#define API_RES_KEY_USER_PHONE                  @"user_phone"
#define API_RES_KEY_USER_ID                     @"usr_id"
#define API_RES_KEY_USER_GENDER                 @"gender"
#define API_RES_KEY_USER_AGE                    @"age"
#define API_RES_KEY_USER_PROFILE_IMG            @"profile_img"
#define API_RES_KEY_USER_NM                     @"usr_nm"
#define API_RES_KEY_USER_NCK                    @"user_nck"
#define API_RES_KEY_USER_LOCATION               @"location"
#define API_RES_KEY_USER_LOGIN_TYPE             @"login_type"
#define API_RES_KEY_EXPERT_UID                  @"export_uid"
#define API_RES_KEY_EXP0RT_EMAIL                @"export_email"
#define API_RES_KEY_EXPpRT_PHONE                @"export_phone"
#define API_RES_KEY_EXPERT_SPORT                @"sport"
#define API_RES_KEY_EXPERT_COMMUNICATION        @"communication"
#define API_RES_KEY_EXPERT_CONTENT              @"content"
#define API_RES_KEY_SPORT_LIST                  @"sport_list"
#define API_RES_KEY_SPORT_UID                   @"sport_uids"
#define API_RES_KEY_SPORT_NAME                  @"sport_name"
#define API_RES_KEY_ADDRESS_LIST                @"address_list"
#define API_RES_KEY_TITLE                       @"title"
#define API_RES_KEY_ADDRESS                     @"address"
#define API_RES_KEY_LATITUDE                    @"latitude"
#define API_RES_KEY_LONGITUDE                   @"longitude"
#define API_RES_KEY_WORKOUT_LIST                @"workout_list"
#define API_RES_KEY_LEVEL                       @"level"
#define API_RES_KEY_DISTANCE                    @"distance"
#define API_RES_KEY_USR_NCK_NM                  @"usr_nck_nm"
#define API_RES_KEY_EXPORT_NCK_NM               @"export_nck_nm"
#define API_RES_KEY_USER_LAST_NAME              @"usr_last_name"
#define API_RES_KEY_EXPORT_LAST_NAME            @"export_last_name"
#define API_RES_KEY_EXPORT_PROFILE              @"export_profile"
#define API_RES_KEY_USR_PROFILE                 @"usr_profile"
#define API_RES_KEY_USR_PHONE                   @"usr_phone"
#define API_RES_KEY_WORKOUT_UID                 @"workout_uid"
#define API_RES_KEY_WORKOUT_DATE                @"workout_date"
#define API_RES_KEY_AMOUNT                      @"amount"
#define API_RES_KEY_WORKOUT_INFO                @"workout_info"
#define API_RES_KEY_PROFILE_INFO                @"profile_info"
#define API_RES_KEY_NICKNAME                    @"nickname"
#define API_RES_KEY_LASTNAME                    @"lastname"
#define API_RES_KEY_PHONE_NUM                   @"phonenum"
#define API_RES_KEY_START_TIME                  @"start_time"
#define API_RES_KEY_CATEGORIES                  @"categories"
#define API_RES_KEY_POST_TYPE                   @"post_type"
#define API_RES_KEY_DURATION                    @"duration"
#define API_RES_KEY_EXPORT_INFO                 @"export_info"
#define API_RES_KEY_USER_INFO                   @"user_info"
#define API_RES_KEY_STAR_MARK                   @"star_mark"
#define API_RES_KEY_FILE_NAME                   @"file_name"
#define API_RES_KEY_FILE_URL                    @"file_url"
#define API_RES_KEY_COUNT_PER_PAGE              @"count_per_page"
#define API_RES_KEY_MSG                         @"msg"

/**
 * API TYPE
 */
#define API_TYPE_FAIL                       @"fail"
#define API_TYPE_REGISTER                   @"register"
#define API_TYPE_EXPoRT_REGISTER            @"export_register"
#define API_TYPE_LOGIN                      @"login"
#define API_TYPE_FIND_PASSWORD              @"find_password"
#define API_TYPE_REG_ADDRESS                @"reg_address"
#define API_TYPE_GET_SPORT                  @"get_sport"
#define API_TYPE_GET_ADDRESS                @"get_address"
#define API_TYPE_REGISTER_WORKOUT           @"register_workout"
#define API_TYPE_LIST_WORKOUT               @"list_workout"
#define API_TYPE_EXPORT_LIST_WORKOUT        @"export_list_workout"
#define API_TYPE_DETAIL_WORKOUT             @"detail_workout"
#define API_TYPE_REGISTER_WORKOUT           @"register_workout"
#define API_TYPE_EXPERT_GET_PROFILE         @"export_get_profile"
#define API_TYPE_USER_OTHER_GET_PROFILE     @"user_other_get_profile"
#define API_TYPE_EXPERT_UPDATE_PROFILE      @"export_update_profile"
#define API_TYPE_USER_GET_PROFILE           @"user_get_profile"
#define API_TYPE_USR_BOOKING                @"usr_booking"
#define API_TYPE_FILE_UPLOAD                @"file_upload"
#define API_TYPE_USER_PROFILE_UPDATE        @"user_update_profile"
#define API_TYPE_UPDATE_ADDRESS             @"update_address"

/**
 * API RESULT CODE
 */
#define RESULT_CODE_FAIL                    -1
#define RESULT_CODE_SUCCESS                 0
#define RESULT_ERROR_PARAMETER              1
#define RESULT_ERROR_DB                     2
#define RESULT_ERROR_EMAIL                  3
#define RESULT_ERROR_PASSWORD               4
#define RESULT_ERROR_EMAIL_DUPLICATE        5
#define RESULT_ERROR_NICKNAME_DUPLICATE     6
#define RESULT_ERROR_PHONE_NUM_DUPLICATE    7
#define RESULT_ERROR_USER_NO_EXIST          8
#define RESULT_ERROR_ZIPCODE_DUPLICATE      9
#define RESULT_ERROR_TITLE_DUPLICATE        10
#define RESULT_ERROR_WORKOUT_DUPLICATE      11
#define RESULT_ERROR_FILE_UPLOAD            12
#define RESULT_ERROR_ALREADY_BOOKED         13
#define RESULT_ERROR_WORKOUT_NOT_EXISTS     14

/**
 * ERROR MESSAGE
 */
#define ERROR_MSG_NETWORK_FAIL      @"NETWORK FAIL"
#define ERROR_MSG_NETWORK_ERROR     @"NETWORK ERROR"
#define ERROR_MSG_PARAMETER_FAIL    @"API RESUILT PARAMETER FAILED"
#define ERROR_MSG_DB_FAIL           @"API RESUILT DB FAILED"
#define ERROR_MSG_PARSE_FAIL        @"API RESUILT PARSE FAILED"
#define ERROR_MSG_UNKNOWN_ERROR     @"UNKNOWN ERROR"

#endif /* ReqConst_h */

