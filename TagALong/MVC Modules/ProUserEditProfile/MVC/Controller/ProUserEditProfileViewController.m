//
//  ProUserEditProfileViewController.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileViewController.h"
#import "ProUserEditProfileModuleHeaders.h"

#define IS_IOS8_OR_ABOVE                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

static CGFloat const kImageScaleFactor = 0.5f;

@interface ProUserEditProfileViewController ()
<
ProUserEditProfileModelOutput,
ProUserEditProfileViewOutput,
ProUserEditProfileUserInfoCellAdapterOutput,
ProUserEditProfileFirstNameCellAdapterOutput,
ProUserEditProfileLastNameCellAdapterOutput,
ProUserEditProfilePhoneNumberCellAdapterOutput,
ProUserEditProfileCityNameCellAdapterOutput,
ProUserEditProfileAwardsCellAdapterOutput,
ProUserEditProfileBankCredentialsCellAdapterOutput,
ProUserEditProfileDebitCellAdapterOutput,
ProUserEditProfileCreditCellAdapterOutput,
ProUserEditProfileSportCellAdapterOutput,
ProUserEditProfileLocationCellAdapterOutput,
AddCreditCardModuleDelegate,
CreditCardListModuleDelegate,
SelectLocationModuleOutput,
ProfilePaymentDataModuleDelegate,
SelectLocationModuleOutput
>

@property (nonatomic, weak) IBOutlet ProUserEditProfileView *contentView;
@property (nonatomic, strong) id <ProUserEditProfileModelInput> model;

@property (nonatomic, strong) id <ProUserEditProfileTableVIewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) ProUserProfile *profile;

@end

@implementation ProUserEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(saveButtinDidTap)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)setup {
    
    ProUserEditProfileModel *model = [[ProUserEditProfileModel alloc] initWithOutput:self];
    
    self.model = model;
    self.contentView.output = self;
    
    ProUserEditProfileMainSectionAdapter *mainSection = [ProUserEditProfileMainSectionAdapter new];
    
    mainSection.cellAdapters =  [NSArray<ProUserEditProfileCellAdapter> arrayWithObjects:
                                 [[ProUserEditProfileUserInfoCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileFirstNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileLastNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfilePhoneHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfilePhoneNumberCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileCityHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfileCityNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileLocationCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileAwardsHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfileAwardsCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfilePaymentHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfileBankCredentialsCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileDebitCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileCreditCellAdapter alloc] initWithOutput:self],
                                 [[EmptyFooterCellAdapter alloc] init], nil];
    
    ProUserEditProfileTableVIewAdapter *tableAdapter = [ProUserEditProfileTableVIewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserEditProfileSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - Actions

- (void)saveButtinDidTap {
    [self.model saveProfile:self.profile];
}

#pragma mark - ProUserEditProfileModelOutput

- (void)profileDidUpdate:(BOOL)success errorMessage:(NSString*)message {
    
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

- (void)bankDataDidLoad:(NSString*)bankData {
    self.profile.bankCredetialsExisted = bankData.length > 0;
}

- (void)debitCardDataDidLoad:(NSString*)debitData {
    self.profile.debitCardData = debitData;
}

- (void)creditCardDataDidLoad:(NSString*)creditData {
    self.profile.creditCardData = creditData;
}

- (void)photoDidLoadWithUrl:(NSString *)url {
    self.profile.profileImageURL = url;
    [self.contentView.tableView reloadData];
}

#pragma mark - ProUserEditProfileViewOutput

#pragma mark - ProUserEditProfileModuleInput

- (void)setupProfile:(ProUserProfile *)profile {
    self.profile = profile;
}

#pragma mark - ProUserEditProfileUserInfoCellAdapterOutput

- (void)sportNameDidChange:(NSString*)sportName {
    self.profile.sport = sportName;
}

- (NSString*)sportName {
    return self.profile.sport;
}

- (NSString*)userProfileIconURL {
    return self.profile.profileImageURL;
}

- (UIColor*)lineColor {
    return UIColor.proBackgroundColor;
}

- (void)userIconDidTap {
    [self showImagePicker];
}

#pragma mark - ProUserEditProfileFirstNameCellAdapterOutput

- (void)firstNameDidChange:(NSString*)firstName {
    self.profile.firstName = firstName;
}

- (NSString*)firstName {
    return self.profile.firstName;
}

#pragma mark - ProUserEditProfileLastNameCellAdapterOutput

- (void)lastNameDidChange:(NSString*)lastName {
    self.profile.lastName = lastName;
}

- (NSString*)lastName {
    return self.profile.lastName;
}

#pragma mark - ProUserEditProfilePhoneNumberCellAdapterOutput

- (void)phoneNumberDidChange:(NSString*)phone {
    self.profile.phoneNumber = phone;
}

- (NSString*)phoneNumber {
    return self.profile.phoneNumber;
}

#pragma mark - ProUserEditProfileCityNameCellAdapterOutput

- (void)cityNameDidChange:(NSString*)cityName {
    self.profile.location = cityName;
}

- (NSString*)cityName {
    return self.profile.location;
}

#pragma mark - ProUserEditProfileAwardsCellAdapterOutput

- (void)awardsDidChange:(NSString*)awards {
    self.profile.awards = awards;
}

- (NSString*)existedAwards {
    return self.profile.awards;
}

#pragma mark - ProUserEditProfileBankCredentialsCellAdapterOutput

- (void)bankCredentialsDidTap {
    [self showRegisterCredentials];
}

- (NSString*)bankCredentialsData {
    return self.profile.bankCredetialsExisted ? @"update" : nil;
}

- (void)loadBankCredentialsInfoWithComplation:(void (^)(NSString *))completion {
    [self.model loadDataForBankCredentialsWithCompletion:completion];
}

#pragma mark - ProUserEditProfileDebitCellAdapterOutput

- (void)debitDidTap {
    self.profile.debitCardData.length > 0 ? [self showCreditCardListForType:ProUserDebitCardListType] : [self showAddCreditCardForType:AddCreditCardtModeTypeProfile];
}

- (NSString*)debitData {
    return self.profile.debitCardData;
}

- (void)loadDebitInfoWithCompletion:(void (^)(NSString *))completion {
    [self.model loadDataForDebitWithCompletion:completion];
}

#pragma mark - ProUserEditProfileCreditCellAdapterOutput

- (void)creditDidTap {
    
    if (self.profile.creditCardData.length > 0) {
        [self showCreditCardListForType:ProUserCreditCardListType];
    } else {
        [self showAddCreditCardForType:AddCreditCardtProUserModeTypePostWorkout];
    }
}

- (NSString*)creditData {
    return self.profile.creditCardData;
}

- (void)loadCreditInfoWithCompletion:(void (^)(NSString *))completion {
    [self.model loadDataForCreditWithCompletion:completion];
}

#pragma mark - ProUserEditProfileSportCellAdapterOutput

- (void)sportDidChange:(NSString *)sport {
    self.profile.sport = sport;
}

- (NSString*)sport {
    return self.profile.sport;
}

#pragma mark - ProUserEditProfileLocationCellAdapterOutput

- (void)locationDidTapAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectLocationViewController *selectLocationVC = (SelectLocationViewController*)SelectLocationViewController.fromStoryboard;

    selectLocationVC.moduleOutput = self;
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.profile.latitude.floatValue, self.profile.longitude.floatValue);
    
    [selectLocationVC setupLocation:location];
    
    [self.navigationController pushViewController:selectLocationVC animated:YES];
}

- (BOOL)userLocationSelected {
    return (self.profile.latitude.floatValue != 0.0f && self.profile.longitude.floatValue != 0.0f);
}

#pragma mark - SelectLocationModuleOutput

- (void)locationDidSet:(CLLocationCoordinate2D)location {
    self.profile.latitude = @(location.latitude);
    self.profile.longitude = @(location.longitude);
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *imgData;
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        UIImage *compressimage = [self.model compressedImageFrom:thumb scale:kImageScaleFactor];
        imgData = UIImageJPEGRepresentation(compressimage, kImageScaleFactor);
        CGImageRelease(image);
        
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     
                                 }];
        
        [self.model uploadImage:thumb scale:kImageScaleFactor];
    }
    else
    {
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIImage *compressimage = [self.model compressedImageFrom:outputImage scale:kImageScaleFactor];
        imgData = UIImageJPEGRepresentation(compressimage, kImageScaleFactor);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.model uploadImage:outputImage scale:kImageScaleFactor];
    }
}

- (void)showImagePicker {
    
    [OHActionSheet showSheetInView:self.view
                             title:nil
                 cancelButtonTitle:@"Cancel"
            destructiveButtonTitle:nil
                 otherButtonTitles:@[@"Photo shoot", @"Album"]
                        completion:^(OHActionSheet* sheet, NSInteger buttonIndex)
     {
         if( buttonIndex == 0 )
         {
             UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
             imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
             imagePickerController.delegate = self;
             imagePickerController.allowsEditing = YES;
             
             if(IS_IOS8_OR_ABOVE)
             {
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     [self presentViewController:imagePickerController animated:YES completion:nil];
                 }];
             }
             else
             {
                 [self presentViewController:imagePickerController animated:YES completion:nil];
             }
         }
         else if( buttonIndex == 1 ){
             UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
             imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
             imagePickerController.delegate = self;
             imagePickerController.allowsEditing = YES;
             imagePickerController.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
             [self presentViewController:imagePickerController animated:YES completion:nil];
         }
     }];
}

- (void)showRegisterCredentials {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    ProfilePaymentDataViewController *profilePaymentVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(ProfilePaymentDataViewController.class)];
    profilePaymentVC.moduleDelegate = self;
    profilePaymentVC.modeType = ProfilPaymentModeTypeProfile;
    profilePaymentVC.isUpdateMode = self.profile.bankCredetialsExisted;
    [self.navigationController pushViewController:profilePaymentVC animated:YES];
}

- (void)showAddCreditCardForType:(AddCreditCardtModeType)type {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    addCreditCardVC.modeType = type;
    [self.navigationController pushViewController:addCreditCardVC animated:YES];
}

- (void)showCreditCardListForType:(CardListType)type {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    CreditCardListViewController *creditCardListVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(CreditCardListViewController.class)];
    creditCardListVC.moduleDelegate = self;
    creditCardListVC.cardListType = type;
    [self.navigationController pushViewController:creditCardListVC animated:YES];
}

#pragma mark - ProfilePaymentDataModuleDelegate

- (void)paymentCredentialsDidSend {
    [self.navigationController popToViewController:self animated:YES];
    [self refreshData];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self refreshData];
}

#pragma mark - Private

- (void)refreshData {
    
    self.profile.bankCredetialsExisted = NO;
    self.profile.debitCardData = nil;
    self.profile.creditCardData = nil;
    
    [self.contentView.tableView reloadData];
}

@end
