//
//  ReviewOfferModuleProtocols.h
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReviewOfferDataModel;

@protocol ReviewOfferModelInput <NSObject>

- (void)acceptOffer:(NSString*)offerUID;
- (void)declineOffer:(NSString*)offerUID;

- (void)offerWasSeen:(NSString*)offerUID;

@end

@protocol ReviewOfferModelOutput <NSObject>

- (void)showResultOfferIsAccepted:(BOOL)isAccepted isSuccess:(BOOL)isSuccessed message:(NSString*)message;

@end

@protocol ReviewOfferViewInput <NSObject>

//- (void)acceptOffer

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
