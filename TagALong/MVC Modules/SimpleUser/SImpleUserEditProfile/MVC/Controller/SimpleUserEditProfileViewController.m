//
//  SImpleUserEditProfileViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileViewController.h"
#import "SimpleUserEditProfileModuleHeaders.h"

#define IS_IOS8_OR_ABOVE                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

static CGFloat const kImageScaleFactor = 0.5f;

@interface SimpleUserEditProfileViewController ()
<
SimpleUserEditProfileModelOutput,
SimpleUserEditProfileViewOutput,
AddCreditCardModuleDelegate,
CreditCardListModuleDelegate,
PickerModuleOutput,
ProUserEditProfileUserInfoCellAdapterOutput,
ProUserEditProfileFirstNameCellAdapterOutput,
ProUserEditProfileLastNameCellAdapterOutput,
ProUserEditProfilePhoneNumberCellAdapterOutput,
ProUserEditProfileCityNameCellAdapterOutput,
ProUserEditProfileCreditCellAdapterOutput,
ProUserEditProfileChangePasswordCellAdapterOutput
>

@property (nonatomic, weak) IBOutlet SimpleUserEditProfileView *contentView;

@property (nonatomic, strong) id <SimpleUserEditProfileModelInput> model;
@property (nonatomic, strong) id <ProUserEditProfileTableVIewAdapterInput> tableViewAdapter;

@property (nonatomic, assign) NSInteger miles;
@property (nonatomic, strong) NSString *iconURL;

@property (nonatomic, strong) SimpleUserProfile *profile;

@end

@implementation SimpleUserEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    
    self.model = [[SimpleUserEditProfileModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    [self.model loadCrediCards];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonDidTap)];
    
    ProUserEditProfileMainSectionAdapter *mainSection = [ProUserEditProfileMainSectionAdapter new];
    
    mainSection.cellAdapters =  [NSArray<ProUserEditProfileCellAdapter> arrayWithObjects:
                                 [[ProUserEditProfileUserInfoCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileFirstNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfileLastNameCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfilePhoneHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfilePhoneNumberCellAdapter alloc] initWithOutput:self],
                                 [[EmptyFooterCellAdapter alloc] init],
                                 [[ProUserEditProfileChangePasswordCellAdapter alloc] initWithOutput:self],
                                 [[ProUserEditProfilePaymentHeaderCellAdapter alloc] init],
                                 [[ProUserEditProfileCreditCellAdapter alloc] initWithOutput:self],
                                 [[EmptyFooterCellAdapter alloc] init], nil];
    
    ProUserEditProfileTableVIewAdapter *tableAdapter = [ProUserEditProfileTableVIewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ProUserEditProfileSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - SimpleUserEditProfileModelOutput

- (void)creditCardsDidLoadSuccess:(BOOL)isSuccess cardInfo:(NSString*)cardInfo {
    
}

- (void)areaRadiusDidUpdateSuccess:(BOOL)isSuccess message:(NSString*)message {
    
    if (isSuccess) {
        [self showAllertWithTitle:@"TagALong" message:message okCompletion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

- (void)profileDidUpdate:(BOOL)success errorMessage:(NSString*)message {
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

- (void)photoDidLoadWithUrl:(NSString *)url {
    self.profile.profileImageURL = url;
    [self.contentView.tableView reloadData];
}

#pragma mark - SimpleUserEditProfileViewOutput

- (void)editCreditButtonDidTap {
    
    __weak typeof(self)weakSelf = self;
    
    [self.model loadCrediCardsWithCompletion:^(NSArray *cards) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
        
        if (cards.count == 0) {
            AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
            addCreditCardVC.moduleDelegate = self;
            addCreditCardVC.modeType = AddCreditCardtModeTypeProfile;
            [weakSelf.navigationController pushViewController:addCreditCardVC animated:YES];
        } else {
            CreditCardListViewController *creditCardListVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(CreditCardListViewController.class)];
            creditCardListVC.moduleDelegate = self;
            [self.navigationController pushViewController:creditCardListVC animated:YES];
        }
    }];
}

- (void)areaRadiusDidTap {
    PickerViewController *pickerVC = (PickerViewController*)PickerViewController.fromStoryboard;
    [pickerVC setupWithType:MapMilesPickerType];
    pickerVC.moduleOutput = self;
    [self presentCrossDissolveVC:pickerVC];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self refreshData];
}

#pragma mark - Private

- (void)refreshData {
    self.profile.creditCardData = nil;
    [self.contentView.tableView reloadData];
}

#pragma mark - SimpleUserEditProfileModuleInput

- (void)setupMiles:(NSInteger)miles {
    self.miles = miles;
}

- (void)setupProfileIcon:(NSString*)iconUrl {
    self.iconURL = iconUrl;
}

#pragma mark - PickerModuleOutput

- (void)pickerDoneButtonDidTapWithMiles:(NSString *)miles {
    
}

- (void)creditCardDataDidLoad:(NSString *)creditData {
    self.profile.creditCardData = creditData;
}

#pragma mark - Private

- (void)saveButtonDidTap {
    [self.model saveProfile:self.profile];
}

#pragma mark - ProUserEditProfileModuleInput

- (void)setupProfile:(SimpleUserProfile *)profile {
    self.profile = profile;
}

#pragma mark - ProUserEditProfileUserInfoCellAdapterOutput

- (void)sportNameDidChange:(NSString*)sportName {
    
}

- (NSString*)sportName {
    return [NSString stringWithFormat:@"%@ %@", self.profile.firstName, self.profile.lastName];
}

- (NSString*)userProfileIconURL {
    return self.profile.profileImageURL;
}

- (UIColor*)lineColor {
    return UIColor.whiteColor;
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

#pragma mark - ProUserEditProfileCreditCellAdapterOutput

- (void)creditDidTap {
    
    if (self.profile.creditCardData.length > 0) {
        [self showCreditCardListForType:RegularUserCreditCardListType];
    } else {
        [self showAddCreditCardForType:AddCreditCardtModeTypePostWorkout];
    }
}

- (NSString*)creditData {
    return self.profile.creditCardData;
}

- (void)loadCreditInfoWithCompletion:(void (^)(NSString *))completion {
    [self.model loadDataForCreditWithCompletion:completion];
}

#pragma mark - Credit

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

#pragma mark - ProUserEditProfileChangePasswordCellAdapterOutput

- (void)changePasswordDidTap {
    ChangePasswordViewController *vc = (ChangePasswordViewController*)ChangePasswordViewController.fromStoryboard;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Image Picker

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


@end
