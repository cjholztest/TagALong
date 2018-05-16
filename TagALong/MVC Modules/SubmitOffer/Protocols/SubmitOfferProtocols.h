//
//  SubmitOfferProtocols.h
//  TagALong
//
//  Created by User on 5/14/18.
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

@end

@protocol SubmitOfferModelOutput <NSObject>

- (void)dataDidChange;

@end

@protocol SubmitOfferViewInput <NSObject>



@end

@protocol SubmitOfferViewOutput <NSObject>

- (void)submitOfferDidTap;

@end

@protocol SubmitOfferModuleInput <NSObject>

@end

@protocol SubmitOfferModuleOutput <NSObject>

@end
