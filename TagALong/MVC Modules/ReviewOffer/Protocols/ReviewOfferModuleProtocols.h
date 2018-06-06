//
//  ReviewOfferModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReviewOfferDataModel, ReviewOfferViewDisplayModel, RegularUserInfoDataModel;

@protocol ReviewOfferModelInput <NSObject>

- (void)acceptOffer:(NSString*)offerUID;
- (void)declineOffer:(NSString*)offerUID;

- (void)offerWasSeen:(NSString*)offerUID;

- (void)loadInfoForUserUID:(NSString*)userUID userType:(NSNumber*)userType byDate:(NSString*)date;

@end

@protocol ReviewOfferModelOutput <NSObject>

- (void)showResultOfferIsAccepted:(BOOL)isAccepted isSuccess:(BOOL)isSuccessed message:(NSString*)message;
- (void)userInfoDidLoad:(RegularUserInfoDataModel*)userInfo isSuccess:(BOOL)isSuccessed message:(NSString*)message;;

@end

@protocol ReviewOfferViewInput <NSObject>

- (void)setupWithDisplayModel:(RegularUserInfoDataModel*)userInfo;

@end

@protocol ReviewOfferViewOutput <NSObject>

- (void)acceptButtonDidTap;
- (void)declineButtonDidTap;

@end

@protocol ReviewOfferModuleInput <NSObject>

- (void)setupWithReviewOffer:(ReviewOfferDataModel*)reviewOffer;

@end

@protocol ReviewOfferModuleOutput <NSObject>

@end
