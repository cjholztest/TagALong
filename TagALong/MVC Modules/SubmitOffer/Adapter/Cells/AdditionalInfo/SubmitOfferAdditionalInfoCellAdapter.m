//
//  SubmitOfferAdditionalInfoCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAdditionalInfoCellAdapter.h"
#import "SubmitOfferAdditionalInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIFont+HelveticaNeue.h"
#import "NSString+TextSize.h"
#import "UIColor+AppColors.h"

@interface SubmitOfferAdditionalInfoCellAdapter() <UITextViewDelegate>

@property (nonatomic, weak) id <SubmitOfferAdditionalInfoCellAdapterOutput> output;

@property (nonatomic, weak) SubmitOfferAdditionalInfoTableViewCell *cell;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SubmitOfferAdditionalInfoCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferAdditionalInfoCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferAdditionalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferAdditionalInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.additionalInfoTextView.delegate = self;
    [cell.additionalInfoTextView setTintColor:[UIColor textColor]];
    
    self.cell = cell;
    self.tableView = tableView;
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferAdditionalInfoTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferAdditionalInfoTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(additionalInfoCellDidTap)]) {
        [self.output additionalInfoCellDidTap];
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    self.text = [NSString stringWithFormat:@"%@%@", textView.text, text];
//    [self.cell updateTextViewAppearance];
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    return YES;
}

@end
