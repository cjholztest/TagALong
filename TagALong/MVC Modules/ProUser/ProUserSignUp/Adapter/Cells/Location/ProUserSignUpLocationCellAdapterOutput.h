//
//  ProUserSignUpLocationCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProUserSignUpLocationCellAdapterOutput <NSObject>

- (void)locationDidTapAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)userLocationSelected;

@end
