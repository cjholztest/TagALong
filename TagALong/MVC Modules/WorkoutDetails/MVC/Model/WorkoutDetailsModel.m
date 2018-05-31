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
#import "WorkoutDetailsModuleConstants.h"
#import "PaymentClient.h"
#import "PaymentClient+Pay.h"
#import "PaymentClient+CreditCard.h"

@interface WorkoutDetailsModel()

@property (nonatomic, weak) id <WorkoutDetailsModelOutput> output;

@property (nonatomic, strong) WorkoutProfileInfoDataModel *profileInfo;
@property (nonatomic, strong) WorkoutDetailsDataModel *workotDetails;
@property (nonatomic, strong) NSString *workoutTitle;
@property (nonatomic, strong) NSString *creditCardUID;

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
    
    __block NSError *workoutDetailsError = nil;
    __block NSError *bookedUsersError = nil;
    
    __block NSDictionary *workoutJSON = nil;
    __block NSArray *bookedUsersArray = nil;
    
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    dispatch_group_enter(serviceGroup);
    [self workoutDetilsForWorkoutID:workoutUID withCompletion:^(NSDictionary *workoutInfo, NSError *error) {
        workoutJSON = workoutInfo;
        workoutDetailsError = error;
        dispatch_group_leave(serviceGroup);
    }];
    
    dispatch_group_enter(serviceGroup);
    [self bookedUsersForWorkoutID:workoutUID withCompletion:^(NSArray *bookedUsers, NSError *error) {
        bookedUsersArray = bookedUsers;
        bookedUsersError = error;
        dispatch_group_leave(serviceGroup);
    }];
    
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        
        NSString *errorMessage = nil;
        BOOL isSuccessed;
        
        if (workoutDetailsError || bookedUsersError) {
            errorMessage = workoutDetailsError ? workoutDetailsError.localizedDescription : bookedUsersError.localizedDescription;
            isSuccessed = NO;
        } else {
            isSuccessed = YES;
        }
        
        BOOL userAlreadyBooked = NO;
        NSNumber *currentUserID = @(Global.g_user.user_uid);
        
        for (NSDictionary *dict in bookedUsersArray) {
            NSNumber *bookedUserID = dict[@"user_uid"];
            if ([bookedUserID integerValue] == [currentUserID integerValue]) {
                userAlreadyBooked = YES;
                break;
            }
        }
        
        NSDictionary *profileInfoJSON = workoutJSON[@"profile_info"];
        weakSelf.profileInfo = [WorkoutProfileInfoMapper profileInfoFromJSON:profileInfoJSON];
        
        NSDictionary *workotDetailsJSON = workoutJSON[@"workout_info"];
        weakSelf.workotDetails = [WorkoutDetailsMapper workoutDetailsFromJSON:workotDetailsJSON];
        
        [weakSelf updateTitle];
        
        BOOL isIndividual = [[SportService shared] isLevelIndividual:weakSelf.profileInfo.level];
        BOOL isUserPro = Global.g_user.loggedInUserIsPro;
        
        NSArray *displayModels = [weakSelf generateDisplayModels];
        WorkoutDetailsViewDisplayModel *profileDisplayModel = [weakSelf profileDispayModel];
        
        profileDisplayModel.isButtonVisible = !(userAlreadyBooked || isIndividual);
        profileDisplayModel.actionButtonType = isIndividual ? BookedUsersButtonType : BookNowButtonType;
        profileDisplayModel.buttonTitle = isUserPro ? @"SHOW VISITORS" : @"BOOK WORKOUT NOW";

        [weakSelf updateTitle];
        
        [weakSelf.output workoutDetaisDidLoadSuccess:isSuccessed
                                             message:errorMessage
                                       displayModels:displayModels
                                 profileDisplayModel:profileDisplayModel];
        
    });
}

- (void)bookedUsersForWorkoutID:(NSString*)workoutUID withCompletion:(BookedUsersCompletion)completion {
    
//    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"booked_users"];
    
    NSDictionary *params = @{ API_REQ_KEY_WORKOUT_UID : workoutUID };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completion) {
            completion(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)workoutDetilsForWorkoutID:(NSString*)workoutUID withCompletion:(WorkoutDetilsCompletion)completion {
    
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
        NSDictionary *result = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            result = responseObject;
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            message = @"The password is incorrect.";
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            message = @"User does not exist.";
        }
        
        NSError *generatedError = nil;
        
        if (message) {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : message};
            generatedError = [[NSError alloc] initWithDomain:@"generated.error.domain" code:500 userInfo:userInfo];
        }
        
        if (completion) {
            completion(result, generatedError);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        if (completion) {
            completion(nil, error);
        }
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

#pragma mark - Payment

- (void)onClickWorkout:(id)sender {
    
    if (self.workotDetails.amount.floatValue == 0.0f || self.workotDetails.amount.integerValue == -1) {
//        [self ReqBookNoew];
    } else {
        __weak typeof(self)weakSelf = self;
        [self requestCardInfoWithCompletion:^(NSString *cardID) {
            if (cardID) {
                self.creditCardUID = cardID;
//                [weakSelf showConfirmBookPayWorkoutAlert];
            } else {
//                [weakSelf showAddCreditCard];
            }
        }];
    }
}

- (void)bookPayWorkout {
    
    [self.output showLoader];
    
    NSDictionary *params = @{@"workout_uid" : [self.workotDetails.uid stringValue],
                             @"amount" : self.workotDetails.amount,
                             @"user_card_uid" : self.creditCardUID};
    
    __weak typeof(self)weakSelf = self;
    
    
    [PaymentClient payForWorkoutWithParams:params withCompletion:^(id responseObject, NSError *error) {
        
        [weakSelf.output hideLoader];
        
        if (error) {
//            [weakSelf showAlert:error.localizedDescription];
        } else {
            if ([responseObject[@"status"] boolValue]) {
//                [weakSelf showSuccessAlert];
            } else {
//                [weakSelf showAlert:@"Failure payment process"];
            }
        }
    }];
}

- (void)requestCardInfoWithCompletion:(void(^)(NSString *cardID))completion {
    
    [self.output showLoader];
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        [weakSelf.output hideLoader];
        
        if (error) {
//            [weakSelf showAlert:error.localizedDescription];
        } else {
            NSArray *cardList = responseObject;
            NSString *ccUIID = nil;
            
            if (cardList.count > 0) {
                NSDictionary *card = cardList.firstObject;
                //                creditCardID = card[@"card_uid"];
                ccUIID = card[@"card_uid"];
                //                [weakSelf showEnterPasswordDialog];
                //                [weakSelf bookPayWorkout];
            }
            
            if (completion) {
                completion(ccUIID);
            }
        }
    }];
}

- (void)bookWorkoutNow {
    
    [self.output showLoader];
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USR_BOOKING];
    
    NSDictionary *params = @{API_REQ_KEY_WORKOUT_UID        :   self.workotDetails.uid.stringValue,
                             API_REQ_KEY_AMOUNT             :   self.workotDetails.amount.stringValue};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        NSError* error;
        //        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
        //                                                                       options:kNilOptions
        //                                                                         error:&error];
        
        [weakSelf.output hideLoader];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
//            if ([self.where isEqualToString:@"profile"]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"ExportProfile" object:nil];
//            }
//            [self showSuccessAlert];
            //MARK: Pop up
            //            [self.navigationController popViewControllerAnimated:YES];
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }  else if(res_code == RESULT_ERROR_ALREADY_BOOKED){
            [Commons showToast:@"Already booked"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output hideLoader];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

@end
