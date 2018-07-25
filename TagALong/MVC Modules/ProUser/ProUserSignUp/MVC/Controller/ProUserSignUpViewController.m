//
//  ProUserSignUpViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
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
ProUserSignUpCityCellAdapterOutput,
ProUserSignUpSportActivityCellAdapterOutput,
SelectLocationModuleOutput,
PickerModuleOutput,
ProUserSignUpGenderCellAdapterOutput,
ProUserSignUpBirthdayCellAdapterOutput,
QLPreviewControllerDelegate,
QLPreviewControllerDataSource
>

@property (nonatomic, weak) IBOutlet ProUserSignUpView *contentView;

@property (nonatomic, strong) id <ProUserSignUpModelInput> model;
@property (nonatomic, strong) id <ProUserSignUpTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) ProUserSignUpDataModel *proUser;

@property (nonatomic, assign) BOOL isPrivacyActive;
@property (nonatomic, assign) BOOL isPrivacyAccepted;

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
    
    self.proUser = [[ProUserSignUpDataModel alloc] init];
    
    self.model = [[ProUserSignUpModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    ProUserSignUpMainSectionAdapter *mainSection = [ProUserSignUpMainSectionAdapter new];
    mainSection.cellAdapters =  [NSArray<ProUserSignUpCellAdapter> arrayWithObjects:
                                 [[ProUserSignUpFirstNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpLastNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpBirthdayCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpGenderCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpEmailCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpPhoneCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpCityCellAdapter alloc] initWithOutput:self],
//                                 [[ProUserSignUpAddressCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpLocationCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpPasswordCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpConfirmPasswordCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpSportActivityCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpAwardsCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpTermsPrivacyCellAdapter alloc] initWithOutput:self], nil];
    
    ProUserSignUpTableViewAdapter *tableAdapter = [ProUserSignUpTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProUserSignUpModelOutput

- (void)proUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString*)message {
    
    [SharedAppDelegate closeLoading];
    
    __weak typeof(self)weakSelf = self;
    
    if (isSuccessed) {
        [self showAllertWithTitle:@"THANK YOU" message:message okTitle:@"Great" okCompletion:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

- (void)validationDidFailWithMessage:(NSString*)message {
    [SharedAppDelegate closeLoading];
    [Commons showToast:message];
}

#pragma mark - ProUserSignUpViewOutput

- (void)signUpButtonDidTap {
    
    NSString *validationErrorMessage = [self.model isUserDataValid:self.proUser];
    if (validationErrorMessage) {
        [Commons showToast:validationErrorMessage];
        return;
    }
    
    if (self.isAccepted) {
        [SharedAppDelegate showLoading];
        [self.model signUpaProUser:self.proUser];
    } else {
        NSString *message = @"Terms and Privacy Policy are not accepted";
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
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
    [self showPickerWithType:SportsPickerType];
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

- (void)iAcceptDidTap {
    self.isPrivacyAccepted = !self.isPrivacyAccepted;
    [self.contentView.tableView reloadData];
}

- (BOOL)isAccepted {
    return self.isPrivacyAccepted;
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

#pragma mark - ProUserSignUpCityCellAdapterOutput

- (void)cityNameDidChange:(NSString *)cityName {
    self.proUser.cityName = cityName;
}

- (NSString*)cityName {
    return self.proUser.cityName;
}

#pragma mark - ProUserSignUpSportActivityCellAdapterOutput

- (void)sportActivityDidChange:(NSString *)sportActivity {
    self.proUser.sportActivity = sportActivity;
}

- (NSString*)sportActivity {
    return self.proUser.sportActivity;
}

#pragma mark - ProUserSignUpGenderActivityCellAdapterOutput

- (void)genderDidTap {
    [self showPickerWithType:GenderPickerType];
}

- (NSString*)gender {
    return self.proUser.gender;
}

#pragma mark - ProUserSignUpBirthdayCellAdapterOutput

- (void)birthdayMonthDidTap {
    [self showPickerWithType:MonthPickerType];
}

- (void)birthdayYearDidTap {
    [self showPickerWithType:YearPickerType];
}

- (NSString*)birthdayMonth {
    return self.proUser.birthday.monthTitle;
}

- (NSString*)birthdayYear {
    return self.proUser.birthday.yearTitle;
}

#pragma mark - SelectLocationModuleOutput

- (void)locationDidSet:(CLLocationCoordinate2D)location {
    
    self.proUser.location = location;
    __weak typeof(self)weakSelf = self;
    
    [self.model updateAddressByLocation:location withConpletion:^(NSString *city, NSString *address) {
        weakSelf.proUser.cityName = city;
//        weakSelf.proUser.address = address;
        [weakSelf.contentView.tableView reloadData];
    }];
}

#pragma mark - PickerViewController

- (void)pickerDoneButtonDidTapWithSelectedIndex:(NSInteger)index andItemTitle:(NSString *)title {
    self.proUser.sportIndex = index;
    self.proUser.sport = title;
    [self.contentView.tableView reloadData];
}

- (void)pickerDoneButtonDidTapWithGender:(NSString *)title atIndex:(NSInteger)index {
    self.proUser.gender = title;
    self.proUser.genderIndex = index;
    [self.contentView.tableView reloadData];
}

- (void)pickerDoneButtonDidTapWithMonth:(NSString*)month atIndex:(NSInteger)index {
    self.proUser.birthday.monthTitle = month;
    self.proUser.birthday.monthIndex = index;    
    [self.contentView.tableView reloadData];
}

- (void)pickerDoneButtonDidTapWithYear:(NSString*)year {
    self.proUser.birthday.yearTitle = year;
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

#pragma mark - Private

- (void)showPickerWithType:(PickerType)type {
    
    PickerViewController *sportsPickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    
    sportsPickerVC.moduleOutput = self;
    [sportsPickerVC setupWithType:type];
    
    [self presentCrossDissolveVC:sportsPickerVC];
}

@end
