//
//  SelectLocationModuleProtocols.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectLocationModelInput <NSObject>

@end

@protocol SelectLocationModelOutput <NSObject>

@end

@protocol SelectLocationViewnput <NSObject>

@end

@protocol SelectLocationViewOutput <NSObject>

@end

@protocol SelectLocationModuleInput <NSObject>

- (void)setupLocation:(CLLocationCoordinate2D)location;

@end

@protocol SelectLocationModuleOutput <NSObject>

- (void)locationDidSet:(CLLocationCoordinate2D)location;

@end
