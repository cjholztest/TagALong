//
//  SimpleUserSignUpViewController.m
//  TagALong
//
//  Created by User on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserSignUpViewController.h"
#import "SimpleUserSignUpModuleHeaders.h"

@interface SimpleUserSignUpViewController ()
<
SimpleUserSignUpModelOutput,
SimpleUserSignUpViewOutput,
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
QLPreviewControllerDelegate,
QLPreviewControllerDataSource
>

@property (nonatomic, weak) IBOutlet SimpleUserSignUpView *contentView;

@property (nonatomic, strong) id <SimpleUserSignUpModelInput> model;
@property (nonatomic, strong) id <ProUserSignUpTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) SimpleUserSignUpDataModel *simpleUser;

@property (nonatomic, assign) BOOL isPrivacyActive;

@end

@implementation SimpleUserSignUpViewController

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
    self.simpleUser = [[SimpleUserSignUpDataModel alloc] init];
    
    self.model = [[SimpleUserSignUpModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    ProUserSignUpMainSectionAdapter *mainSection = [ProUserSignUpMainSectionAdapter new];
    mainSection.cellAdapters =  [NSArray<ProUserSignUpCellAdapter> arrayWithObjects:
                                 [[ProUserSignUpFirstNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpLastNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpEmailCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpPhoneCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpIsPhoneVisibleCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpCityCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpLocationCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpPasswordCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpConfirmPasswordCellAdapter alloc] initWithOutput:self],
                                 [[ProUserSignUpTermsPrivacyCellAdapter alloc] initWithOutput:self], nil];
    
    ProUserSignUpTableViewAdapter *tableAdapter = [ProUserSignUpTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserSignUpSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProUserSignUpModelOutput

- (void)simpleUserDidSignUpSuccessed:(BOOL)isSuccessed andMessage:(NSString *)message {
    
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
    [SharedAppDelegate showLoading];
    [self.model signUpSimpleUser:self.simpleUser];
}

#pragma mark - ProUserSignUpModuleInput


#pragma mark - ProUserSignUpFirstNameCellAdapterOutput

- (void)firstNameDidChange:(NSString*)firstName {
    self.simpleUser.firstName = firstName;
}

- (NSString*)firstName {
    return self.simpleUser.firstName;
}

#pragma mark - ProUserSignUpLastNameCellAdapterOutput

- (void)lastNameDidChange:(NSString*)lastName {
    self.simpleUser.lastName = lastName;
}

- (NSString*)lastName {
    return self.simpleUser.lastName;
}

#pragma mark - ProUserSignUpEmailCellAdapterOutput

- (void)eMailDidChange:(NSString*)eMail {
    self.simpleUser.eMail = eMail;
}

- (NSString*)eMail {
    return self.simpleUser.eMail;
}

#pragma mark - ProUserSignUpPhoneCellAdapterOutput

- (void)phoneDidChange:(NSString*)phone {
    self.simpleUser.phone = phone;
}

- (NSString*)phone {
    return self.simpleUser.phone;
}

#pragma mark - ProUserSignUpPasswordCellAdapterOutput

- (void)passwordDidChange:(NSString*)password {
    self.simpleUser.password = password;
}

- (NSString*)password {
    return self.simpleUser.password;
}

#pragma mark - ProUserSignUpConfirmPasswordCellAdapterOutput

- (void)confirmPasswordDidChange:(NSString*)confirmPassword {
    self.simpleUser.confirmPassword = confirmPassword;
}

- (NSString*)confirmPassword {
    return self.simpleUser.confirmPassword;
}

#pragma mark - ProUserSignUpAddressCellAdapterOutput

- (void)addressDidChange:(NSString*)address {
    self.simpleUser.address = address;
}

- (NSString*)address {
    return self.simpleUser.address;
}

#pragma mark - ProUserSignUpSportCellAdapterOutput

- (void)sportCellDidTap {
    
    PickerViewController *sportsPickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    
    sportsPickerVC.moduleOutput = self;
    [sportsPickerVC setupWithType:SportsPickerType];
    
    [self presentCrossDissolveVC:sportsPickerVC];
}

- (NSString*)kindOfSport {
    return self.simpleUser.sport;
}

#pragma mark - ProUserSignUpAdditionalInfoCellAdapterOutput

- (void)additionalInfoDidChange:(NSString*)additionalInfo {
    self.simpleUser.additionalInfo = additionalInfo;
}

- (NSString*)additionalInfo {
    return self.simpleUser.additionalInfo;
}

#pragma mark - ProUserSignUpAwardsCellAdapterOutput

- (void)awardsDidChange:(NSString*)awards {
    self.simpleUser.awards = awards;
}

- (NSString*)awards {
    return self.simpleUser.awards;
}

#pragma mark - ProUserSignUpIsPhoneVisibleCellAdapterOutput

- (void)isPhoneVisibleStateDidChange:(BOOL)isVisible {
    self.simpleUser.isPhoneVisible = isVisible;
}

- (BOOL)isPhoneVisible {
    return self.simpleUser.isPhoneVisible;
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
    [selectLocationVC setupLocation:self.simpleUser.location];
    
    [self.navigationController pushViewController:selectLocationVC animated:YES];
}

- (BOOL)userLocationSelected {
    return (self.simpleUser.location.latitude != 0.0f && self.simpleUser.location.longitude != 0.0f);
}

#pragma mark - ProUserSignUpCityCellAdapterOutput

- (void)cityNameDidChange:(NSString *)cityName {
    self.simpleUser.cityName = cityName;
}

- (NSString*)cityName {
    return self.simpleUser.cityName;
}

#pragma mark - ProUserSignUpSportActivityCellAdapterOutput

- (void)sportActivityDidChange:(NSString *)sportActivity {
    self.simpleUser.sportActivity = sportActivity;
}

- (NSString*)sportActivity {
    return self.simpleUser.sportActivity;
}

#pragma mark - SelectLocationModuleOutput

- (void)locationDidSet:(CLLocationCoordinate2D)location {
    
    self.simpleUser.location = location;
    __weak typeof(self)weakSelf = self;
    
    [self.model updateCityByLocation:location withCompletion:^(NSString *city) {
        weakSelf.simpleUser.cityName = city;
        [weakSelf.contentView.tableView reloadData];
    }];
}

#pragma mark - PickerViewController

- (void)pickerDoneButtonDidTapWithSelectedIndex:(NSInteger)index andItemTitle:(NSString *)title {
    self.simpleUser.sportIndex = index;
    self.simpleUser.sport = title;
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
