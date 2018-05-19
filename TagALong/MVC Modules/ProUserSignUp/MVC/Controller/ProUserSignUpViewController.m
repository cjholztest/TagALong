//
//  ProUserSignUpViewController.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpViewController.h"
#import "ProUserSignUpModuleHeaders.h"
#import "ProUserSignUpDataModel.h"

@interface ProUserSignUpViewController ()
<
ProUserSignUpModelOutput,
ProUserSignUpViewOutput,
ProUserSignUpFirstNameCellAdapterOutput,
ProUserSignUpLastNameCellAdapterOutput,
ProUserSignUpEmailCellAdapterOutput,
ProUserSignUpPhoneCellAdapterOutput,
ProUserSignUpPasswordCellAdapterOutput,
ProUserSignUpConfirmPasswordCellAdapterOutput,
ProUserSignUpAddressCellAdapterOutput,
ProUserSignUpSportCellAdapterOutput,
ProUserSignUpAdditionalInfoCellAdapterOutput,
ProUserSignUpAwardsCellAdapterOutput
>

@property (nonatomic, weak) IBOutlet ProUserSignUpView *contentView;

@property (nonatomic, strong) id <ProUserSignUpModelInput> model;
@property (nonatomic, strong) id <ProUserSignUpTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) ProUserSignUpDataModel *proUser;

@end

@implementation ProUserSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar applyDefaultStyle];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setup {
    
    self.title = @"Pro Sign Up";
    self.proUser = [ProUserSignUpDataModel new];
    
    self.model = [[ProUserSignUpModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    ProUserSignUpFirstNameCellAdapter *firstName = [[ProUserSignUpFirstNameCellAdapter alloc] initWithOutput:self];
    ProUserSignUpLastNameCellAdapter *lastName = [[ProUserSignUpLastNameCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpEmailCellAdapter *eMail = [[ProUserSignUpEmailCellAdapter alloc] initWithOutput:self];
    ProUserSignUpPhoneCellAdapter *phone = [[ProUserSignUpPhoneCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpPasswordCellAdapter *password = [[ProUserSignUpPasswordCellAdapter alloc] initWithOutput:self];
    ProUserSignUpConfirmPasswordCellAdapter *confirmPassword = [[ProUserSignUpConfirmPasswordCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpAddressCellAdapter *address = [[ProUserSignUpAddressCellAdapter alloc] initWithOutput:self];
    ProUserSignUpSportCellAdapter *sport = [[ProUserSignUpSportCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpAddressCellAdapter *additionalInfo = [[ProUserSignUpAddressCellAdapter alloc] initWithOutput:self];
    ProUserSignUpAwardsCellAdapter *awards = [[ProUserSignUpAwardsCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpMainSectionAdapter *mainSection = [ProUserSignUpMainSectionAdapter new];
    mainSection.cellAdapters =  [NSArray<ProUserSignUpCellAdapter> arrayWithObjects:firstName, lastName, eMail, phone, password, confirmPassword, address, sport, additionalInfo, awards, nil];
    
    ProUserSignUpTableViewAdapter *tableAdapter = [ProUserSignUpTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProUserSignUpModelOutput

#pragma mark - ProUserSignUpViewOutput

#pragma mark - ProUserSignUpModuleInput


#pragma mark - ProUserSignUpFirstNameCellAdapterOutput

#pragma mark - ProUserSignUpLastNameCellAdapterOutput

#pragma mark - ProUserSignUpEmailCellAdapterOutput

#pragma mark - ProUserSignUpPhoneCellAdapterOutput

#pragma mark - ProUserSignUpPasswordCellAdapterOutput

#pragma mark - ProUserSignUpConfirmPasswordCellAdapterOutput

#pragma mark - ProUserSignUpAddressCellAdapterOutput

#pragma mark - ProUserSignUpSportCellAdapterOutput

#pragma mark - ProUserSignUpAdditionalInfoCellAdapterOutput

#pragma mark - ProUserSignUpAwardsCellAdapterOutput

@end
