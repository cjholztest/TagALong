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

static const CGFloat kMetersInMile = 1609.34f;

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

- (void)loadProsInRadius:(NSString*)miles {
    
    __block CGFloat radius = miles.floatValue;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"exports_in_radius"];
    
    NSNumber *latitude = nil;
    NSNumber *longitude = nil;
    
    if (Global.g_user.loggedInUserIsRegualar) {
        latitude = @(Global.g_user.user_latitude.floatValue);
        longitude = @(Global.g_user.user_longitude.floatValue);
    } else {
        latitude = @(Global.g_expert.expert_latitude.floatValue);
        longitude = @(Global.g_expert.expert_longitude.floatValue);
    }
    
    NSDictionary *params = @{API_REQ_KEY_USER_LATITUDE      :   latitude,
                             API_REQ_KEY_USER_LONGITUDE     :   longitude,
                             @"radius" : miles};
    
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
            
            CGFloat athleteMilesDistance = athlete.distance.floatValue * kMetersInMile;
            athlete.isInSelectedRadius = athleteMilesDistance <= radius;
            
            [self.athletes addObject:athlete];
            
            ProsTableViewCellDisplayModel *displayModel = [ProsTableViewCellDisplayModel new];
            
            displayModel.nameText = [NSString stringWithFormat:@"%@ %@", athlete.firstName, athlete.lastName];
            displayModel.locationText = athlete.city;
            
            displayModel.descriptionText = athlete.sportActivity;
            
            [self.athletesDisplayModels addObject:displayModel];
        }
        
        [self.output prosDidLoadSuccessfully];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
        
    }];
}

- (BOOL)isCurrentProUserAloneInArea {
    if (self.athletes.count == 1) {
        AthleteDataModel *athlete = self.athletes.firstObject;
        int currentProUID = Global.g_expert.export_uid;
        if (currentProUID == athlete.userUID.intValue) {
            return YES;
        }
    }
    return NO;
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
