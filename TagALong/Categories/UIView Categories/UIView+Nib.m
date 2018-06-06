//
//  UIView+Nib.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

+ (UIView*)loadFromNibWithName:(NSString*)name bundle:(NSBundle*)bundle {
    return (UIView*)[[UINib nibWithNibName:name bundle:bundle] instantiateWithOwner:nil options:nil].firstObject;
}

+ (NSString*)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (UINib*)viewNib {
    return [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
}

@end
