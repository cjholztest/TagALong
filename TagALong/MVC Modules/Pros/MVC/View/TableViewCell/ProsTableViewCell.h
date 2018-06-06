//
//  ProsTableViewCell.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferBaseTableViewCell.h"

@class ProsTableViewCellDisplayModel;

@interface ProsTableViewCell : SubmitOfferBaseTableViewCell

- (void)setupWithDisplayModel:(ProsTableViewCellDisplayModel*)displayModel;

@end

