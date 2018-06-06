//
//  ProsModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsModel.h"
#import "ProsTableViewCellDisplayModel.h"
#import "AthleteDataModel.h"
#import "AthleteMapper.h"

@interface ProsModel()

@property (nonatomic, weak) id <ProsModelOutput> output;

@property (nonatomic, strong) NSMutableArray *athletes;
@property (nonatomic, strong) NSMutableArray *athletesDisplayModels;

@end

@implementation ProsModel

- (instancetype)initWithOutput:(id<ProsModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
        self.athletesDisplayModels = [NSMutableArray new];
        self.athletes = [NSMutableArray new];
    }
    return self;
}

#pragma mark - ProsModelInput

- (void)loadPros {
    // need to add load logic
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"exports_in_radius"];
    
    NSDictionary *params = @{API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude};

//    NSDictionary *params = @{API_REQ_KEY_USER_LATITUDE      :   @(0.0f),
//                             API_REQ_KEY_USER_LONGITUDE     :   @(0.0f)};
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        NSError* error;
        //        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
        //                                                                       options:kNilOptions
        //                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        self.athletesDisplayModels = [NSMutableArray array];
        self.athletes = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject) {
            
            AthleteDataModel *athlete = [AthleteMapper athleteFromJSON:dict];
            [self.athletes addObject:athlete];
            
            ProsTableViewCellDisplayModel *displayModel = [ProsTableViewCellDisplayModel new];
            
            displayModel.nameText = [NSString stringWithFormat:@"%@ %@", athlete.firstName, athlete.lastName];
            displayModel.locationText = athlete.city;
            
            displayModel.descriptionText = athlete.sportActivity;
//                displayModel.subInfoText = [NSString stringWithFormat:@"Sub info %lu", i];
            
            [self.athletesDisplayModels addObject:displayModel];
            
        }
        
        [self.output prosDidLoadSuccessfully];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
        
    }];
}

#pragma mark - ProsModelDataSource

- (id)athleteDetailsAtIndex:(NSInteger)index {
    return self.athletes[index];
}

- (id)athleteAtIndex:(NSInteger)index {
    return self.athletesDisplayModels[index];
}

- (NSInteger)athletesCount {
    return self.athletesDisplayModels.count;
}

@end
