//
//  ReviewOfferAdditionalSectionAdapter.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferAdditionalSectionAdapter.h"
#import "SubmitOfferAdditionalInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIFont+HelveticaNeue.h"
#import "SubmitOfferAdditionalInfoTableViewCell.h"
#import "ReviewOfferCellDisplayModel.h"
#import "NSString+TextSize.h"
#import "UIColor+AppColors.h"

@interface ReviewOfferAdditionalSectionAdapter()

@property (nonatomic, weak) id <ReviewOfferAdditionalSectionAdapterOutput> output;
@property (nonatomic, weak) SubmitOfferAdditionalInfoTableViewCell *cell;
@property (nonatomic, strong) NSString *text;

@end

@implementation ReviewOfferAdditionalSectionAdapter

- (instancetype)initWithOutput:(id<ReviewOfferAdditionalSectionAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProsSectionAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:[SubmitOfferAdditionalInfoTableViewCell viewNib] forCellReuseIdentifier:[SubmitOfferAdditionalInfoTableViewCell reuseIdentifier]];
}

- (NSInteger)numberOfRows {
    return [self.output additionalRowsCount];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    SubmitOfferAdditionalInfoTableViewCell *cell = (SubmitOfferAdditionalInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:SubmitOfferAdditionalInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    ReviewOfferCellDisplayModel *displayModel = [self.output additionalDisplayModelAtIndexPath:indexPath];
    
    self.cell = cell;
    self.text = displayModel.text;
    
    cell.titleLabel.text = displayModel.title;
    cell.additionalInfoTextView.text = displayModel.text;
    
    [cell.additionalInfoTextView setUserInteractionEnabled:NO];
//    [cell.additionalInfoTextView setSelectable:NO];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 88.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    CGFloat height = 70.0f;
    
    UIFont *font = [UIFont textFont];
    
    if (self.text && font) {
        
        [self.cell setNeedsUpdateConstraints];
        [self.cell updateConstraintsIfNeeded];
        
        CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width - 30.0f;
        
        CGFloat oneStringHeight = [@"text" sizeByWidth:contentWidth withFont:font].height;
        CGFloat textHeight = [self.text sizeByWidth:contentWidth withFont:font].height;
        
        if (textHeight > oneStringHeight) {
            height += textHeight - oneStringHeight;
        }
        
        [self.cell setNeedsLayout];
        [self.cell layoutIfNeeded];
    }
    
    return height;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

@end
