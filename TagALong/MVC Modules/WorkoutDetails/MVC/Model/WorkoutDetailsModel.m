//
//  WorkoutDetailsModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
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

static NSString *kUserDidPay = @"CurrentUserDidPay";

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

- (BOOL)isWokoutFree {
    return self.workotDetails.isAmountEmpty;
}

- (void)bookFreeWorkout {
    [self bookWorkoutNow];
}

- (void)bookWorkoutWithPassword:(NSString*)password {
    
    BOOL isAmountEmpty = self.workotDetails.isAmountEmpty;
    
    if (isAmountEmpty) {
        [self bookWorkoutNow];
    } else {
        
        __weak typeof(self)weakSelf = self;
        __block NSString *pass = password;
        
        [self requestCardInfoWithCompletion:^(NSString *cardID) {
            if (cardID) {
                weakSelf.creditCardUID = cardID;
                [weakSelf.output showConfirmationPyamentAlertWithAmount:weakSelf.workotDetails.amountText andCompletion:^{
                    [weakSelf bookPaymentWorkout:pass];
                }];
            } else {
                [weakSelf.output creditCardNotFound];
            }
        }];
    }

}

- (void)payBookedWorkoutWithPassword:(NSString*)password {
        
    __weak typeof(self)weakSelf = self;
    __block NSString *pass = password;
    
    if (Global.g_user.loggedInUserIsRegualar) {
        [self requestCardInfoWithCompletion:^(NSString *cardID) {
            if (cardID) {
                weakSelf.creditCardUID = cardID;
                [weakSelf.output showConfirmationPyamentAlertWithAmount:weakSelf.workotDetails.amountText andCompletion:^{
                    [weakSelf payBookedWorkout:pass];
                }];
            } else {
                [weakSelf.output creditCardNotFound];
            }
        }];
    } else {
        [self requestProcreditCardInfoWithCompletion:^(NSString *cardID) {
            if (cardID) {
                weakSelf.creditCardUID = cardID;
                [weakSelf.output showConfirmationPyamentAlertWithAmount:weakSelf.workotDetails.amountText andCompletion:^{
                    [weakSelf payBookedWorkout:pass];
                }];
            } else {
                [weakSelf.output proUserCreditCardNotFound];
            }
        }];
    }
}

- (void)loadDetaisForWorkout:(NSString*)workoutUID {
    
    __weak typeof(self)weakSelf = self;
    
    __block NSError *workoutDetailsError = nil;
    __block NSError *bookedUsersError = nil;
    
    __block NSDictionary *workoutJSON = nil;
    __block NSArray *bookedUsersArray = nil;
    
    __block NSString *didCurrentUserPay = nil;
    __block BOOL isCurrentUserVisitor = NO;
    
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
        
        NSNumber *currentUserUID = nil;        
        NSString *userEmail = nil;
        
        if (Global.g_user.loggedInUserIsRegualar) {
            currentUserUID = @(Global.g_user.user_id.integerValue);
            userEmail = Global.g_user.user_email;
        } else {
            currentUserUID = @(Global.g_expert.export_uid);
            userEmail = Global.g_expert.export_email;
        }
        
        for (NSInteger i = 0; i < bookedUsers.count; i++) {
            
            NSDictionary *dict = bookedUsers[i];
            NSString *email = dict[@"user_email"];
            
            if ([userEmail isEqualToString:email]) {
                isCurrentUserVisitor = YES;
                NSNumber *isPaid = dict[@"user_bookings"][@"paid"];
                if (isPaid.integerValue == 1) {
                    didCurrentUserPay = kUserDidPay;
                    break;
                }
            }
        }
        
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
        
        NSNumber *userID;// = @(Global.g_expert.export_uid);
        
        if ([Global.g_user loggedInUserIsRegualar]) {
            userID = @(Global.g_user.user_uid);
        } else {
            userID = @(Global.g_expert.export_uid);
        }
        
        BOOL isIndividual = userID.integerValue == weakSelf.workotDetails.postUID.integerValue;
        
        NSArray *displayModels = [weakSelf generateDisplayModels];
        WorkoutDetailsViewDisplayModel *profileDisplayModel = [weakSelf profileDispayModel];
        
        profileDisplayModel.isButtonVisible = !([didCurrentUserPay isEqualToString:kUserDidPay]/* userAlreadyBooked*/);
        profileDisplayModel.actionButtonType = isIndividual ? BookedUsersButtonType : BookNowButtonType;
        profileDisplayModel.buttonTitle = isIndividual ? (bookedUsersArray.count > 0 ? @"SHOW VISITORS" : @"There are no participants yet") : @"BOOK WORKOUT NOW";
        
        if (isIndividual) {
            profileDisplayModel.isButtonVisible = YES;
        } else if (weakSelf.workotDetails.isAmountEmpty && isCurrentUserVisitor) {
            profileDisplayModel.isButtonVisible = NO;
        }
        
        if (![didCurrentUserPay isEqualToString:kUserDidPay] && isCurrentUserVisitor && !weakSelf.workotDetails.isAmountEmpty) {
            profileDisplayModel.actionButtonType = PayBoockedButtonType;
            profileDisplayModel.buttonTitle = @"PAY FOR WORKOUT";
        }
        
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
            message = @"The password is incorrect";
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
    NSString *startTime = self.workotDetails.startTimeString;
    
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
    
    if (!self.workotDetails.title) {
        return;
    }
    
    NSMutableString *title = [[NSMutableString alloc] initWithString:self.workotDetails.title];
    
//    for (NSString *category in self.workotDetails.categories) {
//        NSInteger index = category.integerValue;
//        NSString *categoryName = [[SportService shared] categoryNameForIndex:index];
//        [title appendString:[NSString stringWithFormat:@", %@", categoryName]];
//    }
    self.workoutTitle = title;
}

#pragma mark - Payment

- (void)bookPaymentWorkout:(NSString*)password {
    
    [self.output showLoader];
    
    NSDictionary *params = @{@"workout_uid"     : [self.workotDetails.uid stringValue],
                             @"amount"          : self.workotDetails.amount,
                             @"user_card_uid"   : self.creditCardUID};
    
    __weak typeof(self)weakSelf = self;
    
    
    [PaymentClient payForWorkoutWithParams:params withCompletion:^(id responseObject, NSError *error) {
        
        [weakSelf.output hideLoader];
        
        BOOL isSuccess = NO;
        NSString *message = nil;
        
        if (error) {
            message = error.localizedDescription;
        } else {
            if ([responseObject[@"status"] boolValue]) {
                isSuccess = YES;
                message = @"You booked successfully";
            } else {
                isSuccess = NO;
                message = @"Failure payment process";
            }
        }
        [weakSelf.output workoutDidBookSuccess:isSuccess message:message];
    }];
}

- (void)payBookedWorkout:(NSString*)password {
    
    [self.output showLoader];
    
    NSDictionary *params = @{@"workout_uid"     : [self.workotDetails.uid stringValue],
                             @"amount"          : self.workotDetails.amount,
                             @"user_card_uid"   : self.creditCardUID};
    
    __weak typeof(self)weakSelf = self;
    
    
    [PaymentClient payForBookedWorkoutWithParams:params withCompletion:^(id responseObject, NSError *error) {
        [weakSelf.output hideLoader];
        
        BOOL isSuccess = NO;
        NSString *message = nil;
        
        if (error) {
            message = error.localizedDescription;
        } else {
            if ([responseObject[@"status"] boolValue]) {
                isSuccess = YES;
                message = @"You paid successfully";
            } else {
                isSuccess = NO;
                message = @"Failure payment process";
            }
        }
        [weakSelf.output workoutDidBookSuccess:isSuccess message:message];
    }];
}

- (void)requestCardInfoWithCompletion:(void(^)(NSString *cardID))completion {
    
    [self.output showLoader];
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        [weakSelf.output hideLoader];
        
        if (error) {
            [weakSelf.output workoutDidBookSuccess:NO message:error.localizedDescription];
        } else {
            NSArray *cardList = responseObject;
            NSString *ccUIID = nil;
            
            if (cardList.count > 0) {
                NSDictionary *card = cardList.firstObject;
                ccUIID = card[@"card_uid"];
            }
            
            if (completion) {
                completion(ccUIID);
            }
        }
    }];
}

- (void)requestProcreditCardInfoWithCompletion:(void(^)(NSString *cardID))completion {
    
    [self.output showLoader];
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfProUserCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        [weakSelf.output hideLoader];
        
        if (error) {
            [weakSelf.output workoutDidBookSuccess:NO message:error.localizedDescription];
        } else {
            NSArray *cardList = responseObject;
            NSString *ccUIID = nil;
            
            if (cardList.count > 0) {
                NSDictionary *card = cardList.firstObject;
                ccUIID = card[@"card_uid"];
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
        
        [weakSelf.output hideLoader];
        
        BOOL isSuccessed = NO;
        NSString *message = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        
        switch (res_code) {
            case RESULT_CODE_SUCCESS:
                isSuccessed = YES;
                message = @"You booked successfully";
                break;
            case RESULT_ERROR_PASSWORD:
                message = @"The password is incorrect";
                break;
            case RESULT_ERROR_USER_NO_EXIST:
                message = @"User does not exist.";
                break;
            case RESULT_ERROR_PARAMETER:
                message = @"The request parameters are incorrect.";
                break;
            case RESULT_ERROR_ALREADY_BOOKED:
                message = @"Already booked";
                break;
            default:
                break;
        }
        
        [weakSelf.output workoutDidBookSuccess:isSuccessed message:message];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [weakSelf.output hideLoader];
        [weakSelf.output workoutDidBookSuccess:NO message:error.localizedDescription];
    }];
}

@end
