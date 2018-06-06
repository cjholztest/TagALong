//
//  ProUserSignUpCityCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/31/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpCityCellAdapterOutput <NSObject>

- (void)cityNameDidChange:(NSString*)cityName;
- (NSString*)cityName;

@end
