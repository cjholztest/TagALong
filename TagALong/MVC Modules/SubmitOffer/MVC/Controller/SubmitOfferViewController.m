//
//  SubmitOfferViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
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
#import "UIViewController+AlertController.h"
#import "OfferDataModel.h"

@interface SubmitOfferViewController ()
<
SubmitOfferViewOutput,
SubmitOfferModelOutput,
SubmitOfferWhoCellAdapterOutput,
SubmitOfferWhenCellAdapterOutput,
SubmitOfferWhatCellAdapterOutput,
SubmitOfferDurationCellAdapterOutput,
SubmitOfferAmountCellAdapterOutput,
SubmitOfferAdditionalInfoCellAdapterOutput,
PickerModuleOutput,
DatePickerModuleOutput
>

@property (nonatomic, weak) IBOutlet SubmitOfferView *contentView;
@property (nonatomic, strong) id <SubmitOfferModelInput> model;

@property (nonatomic, strong) id <SubmitOfferTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) NSString *athleteID;

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

- (void)submitOfferDidTap {
    [SharedAppDelegate showLoading];
    [self.model submitOfferToArhlete:self.athleteID];
}

#pragma mark - SubmitOfferModelOutput

- (void)dataDidChange {
    [self.contentView.tableView reloadData];
}

- (void)offerDidSubmitSuccess:(BOOL)isSuccess message:(NSString*)message {
    [SharedAppDelegate closeLoading];
    NSString *title = isSuccess ? @"TAGALONG" : @"ERROR";
    
    [self showAllertWithTitle:title message:message okCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)validationDidFailWithMessage:(NSString*)message {
    [SharedAppDelegate closeLoading];
    [Commons showToast:message];
}

#pragma mark - SubmitOfferWhoCellAdapterOutput

- (void)whoCellDidTap {
    [self hideKeyboardIfNeeded];
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [pickerVC setupWithType:TotalPeoplePickerType];
    pickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:pickerVC];
}

- (NSString*)who {
    return self.model.currentOfferInfo.who;
}

#pragma mark - SubmitOfferWhenCellAdapterOutput

- (void)dateDidTap {
    [self hideKeyboardIfNeeded];
    DatePickerViewController *datePickerVC = (DatePickerViewController*)DatePickerViewController.fromStoryboard;
    [datePickerVC setupWithType:DateDatePickerType];
    datePickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:datePickerVC];
}

- (void)timeDidTap {
    [self hideKeyboardIfNeeded];
    PickerViewController *startTimePickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [startTimePickerVC setupWithType:StartTimePickerType];
    startTimePickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:startTimePickerVC];
}

- (void)whenCellDidTap {
    [self hideKeyboardIfNeeded];
}

- (NSDate*)date {
    return self.model.currentOfferInfo.date;
}

- (NSString*)time {
    return self.model.currentOfferInfo.timeString;
}

#pragma mark - SubmitOfferWhatCellAdapterOutput

- (void)whatCellDidTap {
    [self hideKeyboardIfNeeded];
}

- (void)whatTextDidChange:(NSString*)text {
    [self.model updateWhatInfo:text];
}

- (NSString*)what {
    return self.model.currentOfferInfo.what;
}

#pragma mark - SubmitOfferDurationCellAdapterOutput

- (void)durationCellDidTap {
    [self hideKeyboardIfNeeded];
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [pickerVC setupWithType:DuratoinPickerType];
    pickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:pickerVC];
}

- (NSString*)durationValue {
    return self.model.currentOfferInfo.duration;
}

#pragma mark - SubmitOfferAmountCellAdapterOutput

- (void)amountCellDidTap {
    [self hideKeyboardIfNeeded];
}

- (void)amountDidChange:(NSString*)amount {
    [self.model updateAmount:amount];
}

- (NSString*)amount {
    return self.model.currentOfferInfo.amount;
}

#pragma mark - SubmitOfferAdditionalInfoCellAdapterOutput

- (void)additionalInfoCellDidTap {
    [self hideKeyboardIfNeeded];
}

- (NSString*)additionalInfo {
    return self.model.currentOfferInfo.additionalInfo;
}

#pragma mark - SubmitOfferModuleInput

- (void)setupWithAthleteID:(NSString *)athleteID {
    self.athleteID = athleteID;
}

#pragma mark - Actions

- (void)hideKeyboardIfNeeded {
    if (self.isEdidtingEnabled) {
        [self.view endEditing:YES];
    }
}

#pragma mark - PickeModuleOutput

- (void)durationDidSelect:(NSString *)durationText {
    [self.model updateDuration:durationText];
}

- (void)pickerDoneButtonDidTapWithTotalOfPeople:(NSString*)title {
    [self.model updateWhoInfo:title];
}

- (void)pickerDoneButtonDidTapWithDuration:(NSString*)duration {
    [self.model updateDuration:duration];
}

- (void)pickerDoneButtonDidTapWithStartTime:(NSString *)title {
    [self.model updateTime:title];
}

#pragma mark - DatePickerModuleOutput

- (void)dateDidChange:(NSDate *)date {
    [self.model updateDate:date];
}

- (void)timeDidChange:(NSDate *)date {
//    [self.model updateTime:date];
}

@end
