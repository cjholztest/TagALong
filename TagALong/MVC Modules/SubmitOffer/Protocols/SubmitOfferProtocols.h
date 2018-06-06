//
//  SubmitOfferProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OfferDataModel;

@protocol SubmitOfferModelInput <NSObject>

- (void)updateDate:(NSDate*)date;
- (void)updateTime:(NSDate*)time;

- (void)updateWhoInfo:(NSString*)whoInfo;
- (void)updateWhatInfo:(NSString*)whatInfo;
- (void)updateDuration:(NSString*)duration;
- (void)updateAmount:(NSString*)amount;

- (void)updateAdditionalInfo:(NSString*)additionalInfo;

- (OfferDataModel*)currentOfferInfo;

- (void)submitOfferToArhlete:(NSString*)athleteID;

@end

@protocol SubmitOfferModelOutput <NSObject>

- (void)dataDidChange;

- (void)offerDidSubmitSuccess:(BOOL)isSuccess message:(NSString*)message;
- (void)validationDidFailWithMessage:(NSString*)message;

@end

@protocol SubmitOfferViewInput <NSObject>



@end

@protocol SubmitOfferViewOutput <NSObject>

- (void)submitOfferDidTap;

@end

@protocol SubmitOfferModuleInput <NSObject>

- (void)setupWithAthleteID:(NSString*)athleteID;

@end

@protocol SubmitOfferModuleOutput <NSObject>

@end
