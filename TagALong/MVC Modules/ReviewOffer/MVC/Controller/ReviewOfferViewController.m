//
//  ReviewOfferViewController.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferViewController.h"
#import "ReviewOfferModel.h"
#import "ReviewOfferView.h"
#import "ReviewOfferDataModel.h"
#import "UIViewController+AlertController.h"

@interface ReviewOfferViewController () <ReviewOfferModelOutput, ReviewOfferViewOutput>

@property (nonatomic, weak) IBOutlet ReviewOfferView *contentView;

@property (nonatomic, strong) id <ReviewOfferModelInput> model;
@property (nonatomic, strong) ReviewOfferDataModel *reviewOffer;

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
}

#pragma mark - ReviewOfferModelOutput

- (void)showResultOfferIsAccepted:(BOOL)isAccepted isSuccess:(BOOL)isSuccessed message:(NSString*)message {
    [SharedAppDelegate closeLoading];
    NSString *title = isSuccessed ? @"TagALong" : @"ERROR";
    [self showAllertWithTitle:title message:message okCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
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

#pragma mark - Private

@end
