//
//  SubmitOfferViewController.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferViewController.h"
#import "SubmitOfferModel.h"
#import "SubmitOfferView.h"
#import "SubmitOfferAdapterHeaders.h"
#import "PickerViewController.h"
#import "DatePickerViewController.h"
#import "UIViewController+Storyboard.h"
#import "UIViewController+Presentation.h"

@interface SubmitOfferViewController ()
<   SubmitOfferViewOutput,
    SubmitOfferModelOutput,
    SubmitOfferWhoCellAdapterOutput,
    SubmitOfferWhenCellAdapterOutput,
    SubmitOfferWhatCellAdapterOutput,
    SubmitOfferDurationCellAdapterOutput,
    SubmitOfferAmountCellAdapterOutput,
    SubmitOfferAdditionalInfoCellAdapterOutput  >

@property (nonatomic, weak) IBOutlet SubmitOfferView *contentView;
@property (nonatomic, strong) id <SubmitOfferModelInput> model;

@property (nonatomic, strong) id <SubmitOfferTableViewAdapterInput> tableViewAdapter;

@end

@implementation SubmitOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    
    self.model = [[SubmitOfferModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    SubmitOfferMainSectionAdapter *mainSectionAdapter = [SubmitOfferMainSectionAdapter new];
    
    mainSectionAdapter.cellAdapters = [NSArray <SubmitOfferCellAdapter> arrayWithObjects:
                                       [[SubmitOfferWhoCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferWhenCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferWhatCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferDurationCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferAmountCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferAdditionalInfoCellAdapter alloc] initWithOutput:self], nil];
    
    SubmitOfferTableViewAdapter *tableAdapter = [[SubmitOfferTableViewAdapter alloc] init];
    tableAdapter.sectionAdapters = [NSMutableArray<SubmitOfferSectionAdapter> arrayWithObjects:mainSectionAdapter, nil];

    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - SubmitOfferViewOutput

#pragma mark - SubmitOfferModelOutput

- (void)dataDidChange {
    [self.contentView.tableView reloadData];
}

#pragma mark - SubmitOfferWhoCellAdapterOutput

- (void)whoCellDidTap {
    [self hideKeyboardIfNeeded];
}

#pragma mark - SubmitOfferWhenCellAdapterOutput

- (void)dateDidTap {
    [self hideKeyboardIfNeeded];
    DatePickerViewController *datePickerVC = (DatePickerViewController*)DatePickerViewController.fromStoryboard;
    [self presentCrossDissolveVC:datePickerVC];
}

- (void)timeDidTap {
    [self hideKeyboardIfNeeded];
    DatePickerViewController *datePickerVC = (DatePickerViewController*)DatePickerViewController.fromStoryboard;
    [self presentCrossDissolveVC:datePickerVC];
}

- (void)whenCellDidTap {
    [self hideKeyboardIfNeeded];
}

#pragma mark - SubmitOfferWhatCellAdapterOutput

- (void)whatCellDidTap {
    [self hideKeyboardIfNeeded];
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [pickerVC setupAsSports];
    [self presentCrossDissolveVC:pickerVC];
}

#pragma mark - SubmitOfferDurationCellAdapterOutput

- (void)durationCellDidTap {
    [self hideKeyboardIfNeeded];
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [self presentCrossDissolveVC:pickerVC];
}

#pragma mark - SubmitOfferAmountCellAdapterOutput

- (void)amountCellDidTap {
    [self hideKeyboardIfNeeded];
}

#pragma mark - SubmitOfferAdditionalInfoCellAdapterOutput

- (void)additionalInfoCellDidTap {
    [self hideKeyboardIfNeeded];
}

#pragma mark - SubmitOfferModuleInput



#pragma mark - Keyboard Notifications

- (void)keyboardDidAppear:(NSNotification*)notification {
    [super keyboardDidAppear:notification];
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        UIEdgeInsets inset = self.contentView.tableView.contentInset;
        inset.bottom  = keyboardHeight;
        self.contentView.tableView.contentInset = inset;
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    [super keyboardDidHide:notification];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.tableView.contentInset = UIEdgeInsetsZero;
    }];
}

- (void)keyboardDidChange:(NSNotification*)notification {
    [super keyboardDidChange:notification];
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        UIEdgeInsets inset = self.contentView.tableView.contentInset;
        inset.bottom  = keyboardHeight;
        self.contentView.tableView.contentInset = inset;
    }];
}

#pragma mark - Actions

- (void)hideKeyboardIfNeeded {
    if (self.isEdidtingEnabled) {
        [self.view endEditing:YES];
    }
}

@end
