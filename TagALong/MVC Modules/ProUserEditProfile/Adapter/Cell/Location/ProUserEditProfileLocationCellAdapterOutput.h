//
//  ProUserEditProfileLocationCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 7/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserEditProfileLocationCellAdapterOutput <NSObject>

- (void)locationDidTapAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)userLocationSelected;

@end
