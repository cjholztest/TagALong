//
//  AthleteInfoModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AthleteInfoProtocols.h"

@interface AthleteInfoModel : NSObject <AthleteInfoModelInput>

- (instancetype)initWithOuput:(id<AthleteInfoModelOutput>)output;

@end
