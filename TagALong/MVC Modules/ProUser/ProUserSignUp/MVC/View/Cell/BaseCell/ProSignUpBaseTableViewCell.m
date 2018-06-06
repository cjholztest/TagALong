//
//  ProSignUpBaseTableViewCell.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProSignUpBaseTableViewCell.h"
#import "UITableViewCell+Styles.h"

@implementation ProSignUpBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self applyClearStyle];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyClearStyle];
}

@end
