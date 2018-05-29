//
//  WorkoutDetailsModel.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsModel.h"

@interface WorkoutDetailsModel()

@property (nonatomic, weak) id <WorkoutDetailsModelOutput> output;

@end

@implementation WorkoutDetailsModel

- (instancetype)initWithOutput:(id<WorkoutDetailsModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - WorkoutDetailsModelInput

- (void)loadDetaisForWorkout:(NSString*)workoutUID {
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"detail_workout"];
    
    NSDictionary *params = @{ API_REQ_KEY_WORKOUT_UID: workoutUID };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            NSDictionary *workout_info = [responseObject objectForKey:API_RES_KEY_WORKOUT_INFO];
            NSDictionary *profile_info = [responseObject objectForKey:API_RES_KEY_PROFILE_INFO];
            
//            [self setData:workout_info profile:profile_info];
//            [self requestBookedUsers];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

@end
