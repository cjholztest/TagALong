//
//  ProUserEditProfileSportCellAdapterOutput.h
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileSportCellAdapterOutput <NSObject>

- (void)sportDidChange:(NSString*)sport;
- (NSString*)sport;

@end
