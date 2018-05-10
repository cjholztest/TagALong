//
//  ProsView.m
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsView.h"

@interface ProsView()

@end

@implementation ProsView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = 50.0;
    
    self.tableView.contentInset = insets;
}

@end
