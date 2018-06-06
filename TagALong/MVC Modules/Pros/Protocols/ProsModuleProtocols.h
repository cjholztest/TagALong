//
//  ProsModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProsModuleConstants.h"

@protocol ProsModelOutput <NSObject>

- (void)prosDidLoadSuccessfully;
- (void)prosDidLoadWithError:(NSString*)errorMessage;

@end

@protocol ProsModelInput <NSObject>

- (void)loadPros;

@end

@protocol ProsModelDataSource <NSObject>

- (id)athleteDetailsAtIndex:(NSInteger)index;
- (id)athleteAtIndex:(NSInteger)index;
- (NSInteger)athletesCount;

@end

@protocol ProsViewOutput <NSObject>

@end

@protocol ProsModuleInput <NSObject>

@end

@protocol ProsModuleOutput <NSObject>

@end
