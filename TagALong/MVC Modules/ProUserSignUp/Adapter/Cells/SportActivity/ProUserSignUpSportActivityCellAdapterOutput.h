//
//  ProUserSignUpSportActivityCellAdapterOutput.h
//  TagALong
//
//  Created by User on 5/31/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpSportActivityCellAdapterOutput <NSObject>

- (void)sportActivityDidChange:(NSString*)sportActivity;
- (NSString*)sportActivity;

@end
