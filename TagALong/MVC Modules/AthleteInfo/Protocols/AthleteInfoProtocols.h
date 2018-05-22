//
//  AthleteInfoProtocols.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AthleteDataModel;

@protocol AthleteInfoModelInput <NSObject>

- (void)loadData;

@end

@protocol AthleteInfoModelOutput <NSObject>

- (void)dataDidLoad;

@end

@protocol AthleteInfoViewInput <NSObject>

- (void)setupWithAthlete:(AthleteDataModel*)athlete;

@end

@protocol AthleteInfoViewOutput <NSObject>

- (void)tagALongButtonDidTap;

@end

@protocol AthleteInfoModuleInput <NSObject>

- (void)setupWithAthlete:(AthleteDataModel*)athlete;

@end

@protocol AthleteInfoModuleOutput <NSObject>

@end
