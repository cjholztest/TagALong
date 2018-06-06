//
//  SubmitOfferDurationCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferDurationCellAdapterOutput <NSObject>

- (void)durationCellDidTap;
- (NSString*)durationValue;

@end
