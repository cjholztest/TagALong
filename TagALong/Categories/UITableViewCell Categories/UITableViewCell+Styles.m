//
//  UITableViewCell+Styles.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UITableViewCell+Styles.h"

@implementation UITableViewCell (Styles)

- (void)applyClearStyle {
    self.backgroundColor = UIColor.clearColor;
    self.backgroundView.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
