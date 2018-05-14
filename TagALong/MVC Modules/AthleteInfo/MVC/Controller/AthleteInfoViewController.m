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

@interface AthleteInfoViewController () <AthleteInfoModelOutput, AthleteInfoViewOutput, AthleteInfoModuleInput>

@property (nonatomic, weak) IBOutlet AthleteInfoView *contentView;
@property (nonatomic, strong) id <AthleteInfoModelInput> model;

@end

@implementation AthleteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setup {
    self.model = [[AthleteInfoModel alloc] initWithOuput:self];
    self.contentView.output = self;
}

#pragma mark - AthleteInfoModelOutput

#pragma mark - AthleteInfoViewOutput

#pragma mark - AthleteInfoModuleInput

@end
