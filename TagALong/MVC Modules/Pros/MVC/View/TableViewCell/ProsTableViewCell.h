//
//  ProsTableViewCell.h
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProsTableViewCellDisplayModel;

@interface ProsTableViewCell : UITableViewCell

- (void)setupWithDisplayModel:(ProsTableViewCellDisplayModel*)displayModel;

@end

