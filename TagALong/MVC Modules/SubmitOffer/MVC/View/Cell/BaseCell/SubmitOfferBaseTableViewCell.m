//
//  SubmitOfferBaseTableViewCell.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"
#import "UITableViewCell+Styles.h"

@implementation SubmitOfferBaseTableViewCell

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
