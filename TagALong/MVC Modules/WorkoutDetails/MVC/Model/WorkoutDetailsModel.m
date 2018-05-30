//
//  WorkoutDetailsModel.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsModel.h"
#import "WorkoutProfileInfoMapper.h"
#import "WorkoutProfileInfoDataModel.h"
#import "WorkoutDetailsMapper.h"
#import "WorkoutDetailsDataModel.h"
#import "WorkoutMainDetailsTableViewCellDisplayModel.h"
#import "SportService.h"
#import "WorkoutDetailsViewDisplayModel.h"

@interface WorkoutDetailsModel()

@property (nonatomic, weak) id <WorkoutDetailsModelOutput> output;

@property (nonatomic, strong) WorkoutProfileInfoDataModel *profileInfo;
@property (nonatomic, strong) WorkoutDetailsDataModel *workotDetails;
@property (nonatomic, strong) NSString *workoutTitle;

@end

@implementation WorkoutDetailsModel

- (instancetype)initWithOutput:(id<WorkoutDetailsModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - WorkoutDetailsModelInput

- (NSString*)titleText {
    return self.workoutTitle;
}

- (NSString*)additionalInfoText {
    return self.workotDetails.additionalInfo;
}

- (void)loadDetaisForWorkout:(NSString*)workoutUID {
    
    __weak typeof(self)weakSelf = self;
    
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
        
        NSString *message = nil;
        BOOL isSuccessed = NO;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            isSuccessed = YES;
            
            NSDictionary *profileInfoJSON = responseObject[@"profile_info"];
            weakSelf.profileInfo = [WorkoutProfileInfoMapper profileInfoFromJSON:profileInfoJSON];
            
            NSDictionary *workotDetailsJSON = responseObject[@"workout_info"];
            weakSelf.workotDetails = [WorkoutDetailsMapper workoutDetailsFromJSON:workotDetailsJSON];
            
            [weakSelf updateTitle];
            
            NSArray *displayModels = [weakSelf generateDisplayModels];
            WorkoutDetailsViewDisplayModel *profileDisplayModel = [weakSelf profileDispayModel];
            
            [weakSelf.output workoutDetaisDidLoadSuccess:isSuccessed
                                                 message:nil
                                           displayModels:displayModels
                                     profileDisplayModel:profileDisplayModel];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            message = @"The password is incorrect.";
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            message = @"User does not exist.";
        }
        
        if (!isSuccessed) {
            [weakSelf.output workoutDetaisDidLoadSuccess:NO
                                                 message:message
                                           displayModels:nil
                                     profileDisplayModel:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output workoutDetaisDidLoadSuccess:NO
                                             message:error.localizedDescription
                                       displayModels:nil
                                 profileDisplayModel:nil];
    }];
}

#pragma mark - Private

- (NSArray*)generateDisplayModels {
    
    NSDateFormatter *formtter = [NSDateFormatter new];
    formtter.dateFormat = @"dd/MM/yyyy";
    
    NSString *date = [formtter stringFromDate:self.workotDetails.workoutDate];
    
    formtter.dateFormat = @"h:mm a";
    NSString *startTime = [formtter stringFromDate:self.workotDetails.startTime];
    
    NSString *when = [NSString stringWithFormat:@"%@    %@", date, startTime];
    NSString *duratoin = self.workotDetails.duration;
    NSString *amount = self.workotDetails.amountText;
    
    NSArray *titles = @[@"WHEN:", @"DURATION:", @"AMOUNT:"];
    NSArray *values = @[when, duratoin, amount];
    
    NSMutableArray *displayModels = [NSMutableArray array];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        WorkoutMainDetailsTableViewCellDisplayModel *displayModel = [WorkoutMainDetailsTableViewCellDisplayModel new];
        displayModel.title = titles[i];
        displayModel.text = values[i];
        [displayModels addObject:displayModel];
    }
    
    return displayModels;
}

- (WorkoutDetailsViewDisplayModel*)profileDispayModel {
    
    WorkoutDetailsViewDisplayModel *model = [WorkoutDetailsViewDisplayModel new];
    
    model.phoneText = self.profileInfo.phoneNumber;
    model.fullNameText = [NSString stringWithFormat:@"%@ %@", self.profileInfo.firstName, self.profileInfo.lastName];
    model.levelText = [[SportService shared] levelTitleByLevelIndex:self.profileInfo.level];
    model.locationText = self.profileInfo.location;
    model.iconURL = self.profileInfo.profileIconURL;
    
    return model;
}

- (void)updateTitle {
    
    NSMutableString *title = [[NSMutableString alloc] initWithString:self.workotDetails.title];
    
    for (NSString *category in self.workotDetails.categories) {
        NSInteger index = category.integerValue;
        NSString *categoryName = [[SportService shared] categoryNameForIndex:index];
        [title appendString:[NSString stringWithFormat:@", %@", categoryName]];
    }
    self.workoutTitle = title;
}

@end
