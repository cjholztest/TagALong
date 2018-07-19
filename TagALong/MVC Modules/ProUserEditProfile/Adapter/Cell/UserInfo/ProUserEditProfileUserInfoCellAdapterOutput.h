//
//  ProUserEditProfileUserInfoCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileUserInfoCellAdapterOutput <NSObject>

- (void)sportNameDidChange:(NSString*)sportName;
- (void)userIconDidTap;

- (NSString*)sportName;
- (NSString*)userProfileIconURL;
- (UIColor*)lineColor;

@end
