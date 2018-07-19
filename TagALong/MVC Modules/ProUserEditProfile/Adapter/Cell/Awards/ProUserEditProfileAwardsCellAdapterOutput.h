//
//  ProUserEditProfileAwardsCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileAwardsCellAdapterOutput <NSObject>

- (void)awardsDidChange:(NSString*)awards;
- (NSString*)existedAwards;

@end
