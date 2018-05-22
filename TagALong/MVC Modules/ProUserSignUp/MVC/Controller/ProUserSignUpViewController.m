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
ProUserSignUpIsPhoneVisibleCellAdapterOutput,
ProUserSignUpTermsPrivacyCellAdapterOutput,
ProUserSignUpLocationCellAdapterOutput,
SelectLocationModuleOutput,
PickerModuleOutput,
QLPreviewControllerDelegate,
QLPreviewControllerDataSource
>

@property (nonatomic, weak) IBOutlet ProUserSignUpView *contentView;

@property (nonatomic, strong) id <ProUserSignUpModelInput> model;
@property (nonatomic, strong) id <ProUserSignUpTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) ProUserSignUpDataModel *proUser;

@property (nonatomic, assign) BOOL isPrivacyActive;

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
    ProUserSignUpLocationCellAdapter *location = [[ProUserSignUpLocationCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpSportCellAdapter *sport = [[ProUserSignUpSportCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpAdditionalInfoCellAdapter *additionalInfo = [[ProUserSignUpAdditionalInfoCellAdapter alloc] initWithOutput:self];
    ProUserSignUpAwardsCellAdapter *awards = [[ProUserSignUpAwardsCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpTermsPrivacyCellAdapter *termsPrivacy = [[ProUserSignUpTermsPrivacyCellAdapter alloc] initWithOutput:self];
    
//    ProUserSignUpRegisterCellAdapter *signUp = [[ProUserSignUpRegisterCellAdapter alloc] initWithOutput:self];
    
    ProUserSignUpMainSectionAdapter *mainSection = [ProUserSignUpMainSectionAdapter new];
    mainSection.cellAdapters =  [NSArray<ProUserSignUpCellAdapter> arrayWithObjects:firstName, lastName, eMail, phone, isPhoneVisible, address, location, password, confirmPassword, sport, awards, additionalInfo, termsPrivacy, nil];
    
    ProUserSignUpTableViewAdapter *tableAdapter = [ProUserSignUpTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProUserSignUpModelOutput

- (void)proUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString*)message {
    
    [SharedAppDelegate closeLoading];
    
    __weak typeof(self)weakSelf = self;
    
    UIAlertAction *alertAction = nil;;
    NSString *title  = nil;
    
    if (isSuccessed) {
        title = @"THANK YOU";
        alertAction = [UIAlertAction actionWithTitle:@"Great"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action) {
                                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                                    }];
    } else {
        title = @"ERROR";
        alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                             handler:nil];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)validationDidFailWithMessage:(NSString*)message {
    [SharedAppDelegate closeLoading];
    [Commons showToast:message];
}

#pragma mark - ProUserSignUpViewOutput

- (void)signUpButtonDidTap {
    [SharedAppDelegate showLoading];
    [self.model signUpaProUser:self.proUser];
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
    
    PickerViewController *sportsPickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    
    sportsPickerVC.moduleOutput = self;
    [sportsPickerVC setupWithType:SportsPickerType];
    
    [self presentCrossDissolveVC:sportsPickerVC];
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

#pragma mark - ProUserSignUpTermsPrivacyCellAdapterOutput

- (void)termsDidTap {
    self.isPrivacyActive = NO;
    [self showPreview];
}

- (void)privacyDidTap {
    self.isPrivacyActive = YES;
    [self showPreview];
}

#pragma mark - ProUserSignUpLocationCellAdapterOutput

- (void)locationDidTapAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectLocationViewController *selectLocationVC = (SelectLocationViewController*)SelectLocationViewController.fromStoryboard;
    
    selectLocationVC.moduleOutput = self;
    [selectLocationVC setupLocation:self.proUser.location];
    
    [self.navigationController pushViewController:selectLocationVC animated:YES];
}

- (BOOL)userLocationSelected {
    return (self.proUser.location.latitude != 0.0f && self.proUser.location.longitude != 0.0f);
}

#pragma mark - SelectLocationModuleOutput

- (void)locationDidSet:(CLLocationCoordinate2D)location {
    self.proUser.location = location;
    [self.contentView.tableView reloadData];
}

#pragma mark - PickerViewController

- (void)pickerDoneButtonDidTapWithSelectedIndex:(NSInteger)index andItemTitle:(NSString *)title {
    self.proUser.sportIndex = index;
    self.proUser.sport = title;
    [self.contentView.tableView reloadData];
}

#pragma mark - Preview

- (void)showPreview {
    QLPreviewController *previewVC = [QLPreviewController new];
    previewVC.delegate = self;
    previewVC.dataSource = self;
    [self presentViewController:previewVC animated:YES completion:nil];
}

#pragma mark - QLPreviewController

- (id <QLPreviewItem>)previewController:(QLPreviewController*)controller previewItemAtIndex:(NSInteger)index {
    NSString *fileName = self.isPrivacyActive ? @"TagAlong - Privacy Policy" : @"TagAlong - Terms";
    NSURL *URL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"docx"];
    return URL;
}

- (NSInteger) numberOfPreviewItemsInPreviewController:(QLPreviewController*)controller {
    return 1;
}

@end
