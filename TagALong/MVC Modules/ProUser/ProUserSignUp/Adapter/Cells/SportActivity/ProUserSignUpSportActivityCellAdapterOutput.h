//
//  ProUserSignUpSportActivityCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/31/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpSportActivityCellAdapterOutput <NSObject>

- (void)sportActivityDidChange:(NSString*)sportActivity;
- (NSString*)sportActivity;

@end
