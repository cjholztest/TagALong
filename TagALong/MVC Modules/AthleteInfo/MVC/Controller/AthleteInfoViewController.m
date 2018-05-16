//
//  AthleteInfoViewController.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteInfoViewController.h"
#import "AthleteInfoModel.h"
#import "AthleteInfoView.h"
#import "UIViewController+Storyboard.h"
#import "SubmitOfferViewController.h"

@interface AthleteInfoViewController () <AthleteInfoModelOutput, AthleteInfoViewOutput, AthleteInfoModuleInput, SubmitOfferModuleOutput>

@property (nonatomic, weak) IBOutlet AthleteInfoView *contentView;
@property (nonatomic, strong) id <AthleteInfoModelInput> model;

@end

@implementation AthleteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.model = [[AthleteInfoModel alloc] initWithOuput:self];
    self.contentView.output = self;
}

#pragma mark - AthleteInfoModelOutput

- (void)dataDidLoad {
    
}

#pragma mark - AthleteInfoViewOutput

- (void)tagALongButtonDidTap {
    
    SubmitOfferViewController *submitVC = (SubmitOfferViewController*)SubmitOfferViewController.fromStoryboard;
    submitVC.moduleOutput = self;
    [self.navigationController pushViewController:submitVC animated:YES];
}

#pragma mark - AthleteInfoModuleInput

- (void)setupWithAthleteDetails:(NSDictionary*)athleteDetails {
//    self.contentView.nameLabel.text  
}

#pragma mark - SubmitOfferModuleOutput

@end
