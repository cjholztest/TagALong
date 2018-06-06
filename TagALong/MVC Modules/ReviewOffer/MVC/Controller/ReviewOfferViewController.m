//
//  ReviewOfferViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferViewController.h"
#import "ReviewOfferModel.h"
#import "ReviewOfferView.h"
#import "ReviewOfferDataModel.h"
#import "UIViewController+AlertController.h"
#import "ReviewOfferTableViewAdapter.h"
#import "ReviewOfferTableViewAdapterInput.h"
#import "ReviewOfferMainSectionAdapter.h"
#import "ReviewOfferAdditionalSectionAdapter.h"
#import "ReviewOfferCellDisplayModel.h"
#import "ReviewOfferViewDisplayModel.h"
#import "NSDateFormatter+ServerRequest.h"

@interface ReviewOfferViewController () <ReviewOfferModelOutput, ReviewOfferViewOutput, ReviewOfferMainSectionAdapterOutput, ReviewOfferAdditionalSectionAdapterOutput>

@property (nonatomic, weak) IBOutlet ReviewOfferView *contentView;

@property (nonatomic, strong) id <ReviewOfferModelInput> model;
@property (nonatomic, strong) ReviewOfferDataModel *reviewOffer;
@property (nonatomic, strong) NSMutableArray *infoDisplayModels;

@property (nonatomic, strong) id <ReviewOfferTableViewAdapterInput> tableViewAdapter;

@end

@implementation ReviewOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.model offerWasSeen:self.reviewOffer.bidUID.stringValue];
}

- (void)setup {
    self.model = [[ReviewOfferModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
//    self.contentView.userNameLabel.text = self.reviewOffer.from
    self.contentView.descriptionLabel.text = self.reviewOffer.additionalInfo;
    
    self.infoDisplayModels = [NSMutableArray array];
    
    NSArray *titles = @[@"WHO:", @"WHEN:", @"WHAT:", @"DURATION:", @"AMOUNT OFFERED:"];
    
    NSString *who = [NSString stringWithFormat:@"%@ people", self.reviewOffer.totalPeople.stringValue];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:self.reviewOffer.workoutDate];
    
    dateFormatter.dateFormat = @"h:mm a";
    NSString *timeString = [dateFormatter stringFromDate:self.reviewOffer.workoutTime];
    
    NSString *when = [NSString stringWithFormat:@"%@, %@", dateString, timeString];
    NSString *what = self.reviewOffer.descriptionInfo;
    
    NSString *duration = self.reviewOffer.duration;
    NSString *amount = [NSString stringWithFormat:@"$ %.2f", self.reviewOffer.amount.floatValue];
    
    NSArray *values = @[who, when, what, duration, amount];
    
    for (NSInteger i = 0; i < values.count; i++) {
        ReviewOfferCellDisplayModel *displayModel = [ReviewOfferCellDisplayModel new];
        displayModel.title = titles[i];
        displayModel.text = values[i];
        [self.infoDisplayModels addObject:displayModel];
    }
    
    ReviewOfferMainSectionAdapter *mainSection = [[ReviewOfferMainSectionAdapter alloc] initWithOutput:self];
    ReviewOfferAdditionalSectionAdapter *additionalSectionAdapter = [[ReviewOfferAdditionalSectionAdapter alloc] initWithOutput:self];
    
    ReviewOfferTableViewAdapter *reviewOfferTableViewAdapter = [ReviewOfferTableViewAdapter new];
    [reviewOfferTableViewAdapter.sectionAdapters addObject:mainSection];
    [reviewOfferTableViewAdapter.sectionAdapters addObject:additionalSectionAdapter];
    
    self.tableViewAdapter = reviewOfferTableViewAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
    
//    ReviewOfferViewDisplayModel *displayModel = [ReviewOfferViewDisplayModel new];
    
    [self.model loadInfoForUserUID:self.reviewOffer.fromUserUID.stringValue
                          userType:self.reviewOffer.postType
                            byDate:[NSDateFormatter workoutDateStringFromDate:self.reviewOffer.workoutDate]];
    
//    displayModel.fullName = [NSString stringWithFormat:self.reviewOffer.us]
}

#pragma mark - ReviewOfferModelOutput

- (void)showResultOfferIsAccepted:(BOOL)isAccepted isSuccess:(BOOL)isSuccessed message:(NSString*)message {
    [SharedAppDelegate closeLoading];
    NSString *title = isSuccessed ? @"TagALong" : @"ERROR";
    [self showAllertWithTitle:title message:message okCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)userInfoDidLoad:(RegularUserInfoDataModel *)userInfo isSuccess:(BOOL)isSuccessed message:(NSString *)message {
    
    if (!isSuccessed) {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
        return;
    }
    
    [self.contentView setupWithDisplayModel:userInfo];
}

#pragma mark - ReviewOfferViewOutput

- (void)acceptButtonDidTap {
    [SharedAppDelegate showLoading];
    [self.model acceptOffer:self.reviewOffer.bidUID.stringValue];
}

- (void)declineButtonDidTap {
    [SharedAppDelegate showLoading];
    [self.model declineOffer:self.reviewOffer.bidUID.stringValue];
}

#pragma mark - ReviewOfferModuleInput

- (void)setupWithReviewOffer:(ReviewOfferDataModel*)reviewOffer {
    self.reviewOffer = reviewOffer;
}

#pragma mark - ReviewOfferMainSectionAdapterOutput

- (NSInteger)reviewRowsCount {
    return self.infoDisplayModels.count;
}

- (id)infoDisplayModelAtIndexPath:(NSIndexPath *)indexPath {
    return self.infoDisplayModels[indexPath.row];
}

#pragma mark - ReviewOfferAdditionalSectionAdapterOutput

- (NSInteger)additionalRowsCount {
    return 1;
}

- (id)additionalDisplayModelAtIndexPath:(NSIndexPath *)indexPath {
    ReviewOfferCellDisplayModel *displayModel = [ReviewOfferCellDisplayModel new];
    displayModel.title = @"ADDITIONAL INFORMATION:";
    displayModel.text = self.reviewOffer.additionalInfo;
    return displayModel;
}

#pragma mark - Private

@end
