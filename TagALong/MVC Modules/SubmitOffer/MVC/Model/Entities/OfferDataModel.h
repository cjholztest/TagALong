//
//  OfferDataModel.h
//  TagALong
//
//  Created by User on 5/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferDataModel : NSObject

@property (nonatomic, strong) NSString *who;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *what;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *additionalInfo;

@property (nonatomic, strong) NSString *addressUID;

@property (nonatomic, strong) NSString *athleteUID;

@end
