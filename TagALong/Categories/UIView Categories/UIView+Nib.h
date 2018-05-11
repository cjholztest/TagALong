//
//  UIView+Nib.h
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)

+ (UIView*)loadFromNibWithName:(NSString*)name bundle:(NSBundle*)bundle;

+ (NSString*)reuseIdentifier;
+ (UINib*)viewNib;

@end
