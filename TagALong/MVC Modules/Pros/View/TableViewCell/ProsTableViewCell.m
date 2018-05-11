//
//  ProsTableViewCell.m
//  TagALong
//
//  Created by User on 5/11/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsTableViewCell.h"
#import "ProsTableViewCellDisplayModel.h"

@interface ProsTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *subInfoLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationLabelHeightLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subInfoLabelHeightLayoutConstraint;


@end

@implementation ProsTableViewCell

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    const CGFloat subLabelHeight = 20.0f;
    
    CGFloat locationLabelHeight = self.locationLabel.text.length > 0 ? subLabelHeight : 0.0f;
    CGFloat subInfoLabelHeight = self.subInfoLabel.text.length > 0 ? subLabelHeight : 0.0f;
    
    self.locationLabelHeightLayoutConstraint.constant = locationLabelHeight;
    self.subInfoLabelHeightLayoutConstraint.constant = subInfoLabelHeight;
}

- (void)setupWithDisplayModel:(ProsTableViewCellDisplayModel*)displayModel {
    
    self.nameLabel.text = displayModel.nameText;
    self.locationLabel.text = displayModel.locationText;
    
    self.descriptionLabel.text = displayModel.descriptionText;
    self.subInfoLabel.text = displayModel.subInfoText;
}

@end
