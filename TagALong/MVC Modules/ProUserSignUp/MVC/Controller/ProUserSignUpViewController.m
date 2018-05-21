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
ProUserSignUpAwardsCellAdapterOutput,
ProUserSignUpIsPhoneVisibleCellAdapterOutput
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
    self.proUser = [[ProUserSignUpDataModel alloc] init];
    
    self.model = [[ProUserSignUpModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    ProUserSignUpFirstNameCellAdapter *firstName = [[ProUserSignUpFirstNameCellAdapter alloc] initWithOutput:self];
    ProUserSignUpLastNameCellAdapter *lastName = [[ProUserSignUpLastNameCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpEmailCellAdapter *eMail = [[ProUserSignUpEmailCellAdapter alloc] initWithOutput:self];
    ProUserSignUpPhoneCellAdapter *phone = [[ProUserSignUpPhoneCellAdapter alloc] initWithOutput:self];
    ProUserSignUpIsPhoneVisibleCellAdapter *isPhoneVisible = [[ProUserSignUpIsPhoneVisibleCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpPasswordCellAdapter *password = [[ProUserSignUpPasswordCellAdapter alloc] initWithOutput:self];
    ProUserSignUpConfirmPasswordCellAdapter *confirmPassword = [[ProUserSignUpConfirmPasswordCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpAddressCellAdapter *address = [[ProUserSignUpAddressCellAdapter alloc] initWithOutput:self];
    ProUserSignUpSportCellAdapter *sport = [[ProUserSignUpSportCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpAdditionalInfoCellAdapter *additionalInfo = [[ProUserSignUpAdditionalInfoCellAdapter alloc] initWithOutput:self];
    ProUserSignUpAwardsCellAdapter *awards = [[ProUserSignUpAwardsCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpMainSectionAdapter *mainSection = [ProUserSignUpMainSectionAdapter new];
    mainSection.cellAdapters =  [NSArray<ProUserSignUpCellAdapter> arrayWithObjects:firstName, lastName, eMail, phone, isPhoneVisible, address, password, confirmPassword, sport, awards, additionalInfo, nil];
    
    ProUserSignUpTableViewAdapter *tableAdapter = [ProUserSignUpTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProUserSignUpModelOutput

- (void)proUserDidSignUpWithState:(BOOL)isSuccessed andErrorMessage:(NSString*)errorMessage {
    
}

#pragma mark - ProUserSignUpViewOutput

- (void)signUpButtonDidTap {
    
}

#pragma mark - ProUserSignUpModuleInput


#pragma mark - ProUserSignUpFirstNameCellAdapterOutput

- (void)firstNameDidChange:(NSString*)firstName {
    self.proUser.firstName = firstName;
}

- (NSString*)firstName {
    return self.proUser.firstName;
}

#pragma mark - ProUserSignUpLastNameCellAdapterOutput

- (void)lastNameDidChange:(NSString*)lastName {
    self.proUser.lastName = lastName;
}

- (NSString*)lastName {
    return self.proUser.lastName;
}

#pragma mark - ProUserSignUpEmailCellAdapterOutput

- (void)eMailDidChange:(NSString*)eMail {
    self.proUser.eMail = eMail;
}

- (NSString*)eMail {
    return self.proUser.eMail;
}

#pragma mark - ProUserSignUpPhoneCellAdapterOutput

- (void)phoneDidChange:(NSString*)phone {
    self.proUser.phone = phone;
}

- (NSString*)phone {
    return self.proUser.phone;
}

#pragma mark - ProUserSignUpPasswordCellAdapterOutput

- (void)passwordDidChange:(NSString*)password {
    self.proUser.password = password;
}

- (NSString*)password {
    return self.proUser.password;
}

#pragma mark - ProUserSignUpConfirmPasswordCellAdapterOutput

- (void)confirmPasswordDidChange:(NSString*)confirmPassword {
    self.proUser.confirmPassword = confirmPassword;
}

- (NSString*)confirmPassword {
    return self.proUser.confirmPassword;
}

#pragma mark - ProUserSignUpAddressCellAdapterOutput

- (void)addressDidChange:(NSString*)address {
    self.proUser.address = address;
}

- (NSString*)address {
    return self.proUser.address;
}

#pragma mark - ProUserSignUpSportCellAdapterOutput

- (void)sportCellDidTap {
    
}

- (NSString*)kindOfSport {
    return self.proUser.sport;
}

#pragma mark - ProUserSignUpAdditionalInfoCellAdapterOutput

- (void)additionalInfoDidChange:(NSString*)additionalInfo {
    self.proUser.additionalInfo = additionalInfo;
}

- (NSString*)additionalInfo {
    return self.proUser.additionalInfo;
}

#pragma mark - ProUserSignUpAwardsCellAdapterOutput

- (void)awardsDidChange:(NSString*)awards {
    self.proUser.awards = awards;
}

- (NSString*)awards {
    return self.proUser.awards;
}

#pragma mark - ProUserSignUpIsPhoneVisibleCellAdapterOutput

- (void)isPhoneVisibleStateDidChange:(BOOL)isVisible {
    self.proUser.isPhoneVisible = isVisible;
}

- (BOOL)isPhoneVisible {
    return self.proUser.isPhoneVisible;
}

@end
