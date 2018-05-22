//
//  SubmitOfferWhenCellAdapterOutput.h
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferWhenCellAdapterOutput <NSObject>

- (void)dateDidTap;
- (void)timeDidTap;

- (void)whenCellDidTap;

- (NSDate*)date;
- (NSDate*)time;

@end
