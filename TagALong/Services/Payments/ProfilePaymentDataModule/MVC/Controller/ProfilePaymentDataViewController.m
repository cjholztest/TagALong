//
//  ProfilePaymentDataViewController.m
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentDataViewController.h"
#import "ProfilePaymentDataModel.h"
#import "ProfilePaymentDataView.h"
#import "PaymentClient+Customer.h"
#import "ProfilePaymentTableViewCell.h"
#import "ProfilePaymentHeader.h"
#import "ProfilePaymentRegistrationFooter.h"
#import "ProfilePaymentDataFriendsController.h"
#import "EditDialogViewController.h"
#import "UIViewController+Alert.h"
#import "AddCreditCardViewController.h"

static NSString *const kCellIdentifier = @"ProfilePaymentFieldCellIdentifier";
static NSString *const kHeaderIentifier = @"ProfilePaymentRegisterHeaderIdentifier";
static NSString *const kFooterRegisterIdentifier = @"ProfilePaymentRegisterFooterIdentifier";

@interface ProfilePaymentDataViewController () <ProfilePaymentDataModelOutput, ProfilePaymentDataUserInterfaceInput, ProfilePaymentRegistrationFooterDelegate, EditDialogViewControllerDelegate, AddCreditCardModuleDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet ProfilePaymentDataView *contentView;
@property (nonatomic, strong) ProfilePaymentDataModel *model;
@property (nonatomic, strong) ProfilePaymentDataFriendsController *friendsController;
@property (nonatomic, strong) UITextField *activeTextField;

@end

@implementation ProfilePaymentDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Payout Credentials";
    [self setupDependencies];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.activeTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupDependencies {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBirthdayPicker)];
    [self.contentView.birthdayContainerView addGestureRecognizer:tap];
    [self.contentView.birthdayPicker setMaximumDate:[NSDate date]];
    self.contentView.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.tableView.backgroundColor = [UIColor clearColor];
    
    self.friendsController = [ProfilePaymentDataFriendsController new];
    self.model = [ProfilePaymentDataModel new];
    [self.model setupMode:self.modeType];
    self.model.output = self;
    
    self.contentView.eventHandler = self;
    self.contentView.tableView.dataSource = self;
    self.contentView.tableView.delegate = self;
}

- (void)showAddCreditCard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    [self presentViewController:addCreditCardVC animated:YES completion:nil];
}

#pragma mark - ProfilePaymentDataModelOutput

- (void)credentalsDidCheckWithError:(NSString *)errorMessage {
    [Commons showToast:errorMessage];
}

- (void)paymentCredentialsDidRegisterSuccess:(BOOL)isSuccessed errorMessage:(NSString *)errorMessage {
    [SharedAppDelegate closeLoading];
    if (isSuccessed) {
        switch (self.modeType) {
            case ProfilPaymentModeTypeRegistration:
                [self showAddCreditCard];
                break;
            case ProfilPaymentModeTypePostWorkout:
                [self.moduleDelegate paymentCredentialsDidSend];
                break;
            default:
                break;
        }
//        [self showAddCreditCard];
//        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlert:errorMessage];
    }
}

#pragma mark - ProfilePaymentDataUserInterfaceInput

- (void)birthdayPickerDoneButtonDidTap {
    [self.model updateValue:self.contentView.birthdayPicker.date forType:ProfilePaymentFieldTypeBirthday];
    [self.contentView upsateBirthdayPickerAppearanceWithVisibleState:NO];
    if (self.activeTextField.tag == ProfilePaymentFieldTypeBirthday) {
        self.activeTextField.text = [self.model enteredBirthdayDate];
    }
}

- (void)hideBirthdayPicker {
    [self.contentView upsateBirthdayPickerAppearanceWithVisibleState:NO];
}

- (void)sendDataButtonDidTap {
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ProfilePaymentRegistrationFooterDelegate

- (void)skipButtonDidTap {
    NSLog(@"skipButtonDidTap");
    if ([self.moduleDelegate respondsToSelector:@selector(skipSendingPaymentCredentials)]) {
        [self.moduleDelegate skipSendingPaymentCredentials];
    }
}

- (void)sendCredentialsButtonDidTap {
    [self.activeTextField resignFirstResponder];
    NSLog(@"sendCredentialsButtonDidTap");
    if ([self.model isEnteredCredentialsValid]) {
//        if (self.model.isPasswordContained) {
//            [SharedAppDelegate showLoading];
//            [self.model sendPaymentCredentials];
//        } else {
            [self showEnterPasswordDialog];
//        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeTextField = textField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    ProfilePaymentFieldType fieldType = textField.tag;
    if (fieldType != ProfilePaymentFieldTypeBirthday) {
        [self.model updateValue:textField.text forType:fieldType];
    }
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.rowsCount;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfilePaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row;
    cell.textField.placeholder = [self.friendsController placeholderFieldType:indexPath.row];
    cell.textField.keyboardType = [self.friendsController keyboardTypeForFieldType:indexPath.row];
    [cell.textField setUserInteractionEnabled:(indexPath.row != ProfilePaymentFieldTypeBirthday)];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProfilePaymentHeader *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderIentifier];
    NSString *title = [NSString stringWithFormat:@"You have to send your credential to have possibility to get the payouts.%@", self.model.isRegistrationMode ? @" You can send it later from your Profile or during creation new workout." : @""];
    cell.titleLabel.text = title;
    return cell.contentView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ProfilePaymentRegistrationFooter *footer = [tableView dequeueReusableCellWithIdentifier:kFooterRegisterIdentifier];
    [footer.skipButton setUserInteractionEnabled:self.model.isRegistrationMode];
    footer.delegate = self;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.model.isRegistrationMode ? 121 : 60.0;
}

#pragma mark - UITableVieDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ProfilePaymentFieldTypeBirthday) {
        [self.activeTextField resignFirstResponder];
        [self.contentView upsateBirthdayPickerAppearanceWithVisibleState:YES];
        ProfilePaymentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.activeTextField = cell.textField;
    }
}

#pragma mark - EditDialogViewControllerDelegate

- (void)setContent:(NSString*)type msg:(NSString*)content {
    if ([type isEqualToString:@"password"]) {
        [self.model updateValue:content forType:ProfilePaymentFieldTypePassword];
        if (self.model.isPasswordContained) {
            [SharedAppDelegate showLoading];
            [self.model sendPaymentCredentials];
        }
    }
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    __weak typeof(self)weakSelf = self;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf skipButtonDidTap];
    }];
}

- (void)skipAddCreditCard {
    __weak typeof(self)weakSelf = self;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf skipButtonDidTap];
    }];
}

#pragma mark - Password Alert

- (void)showEnterPasswordDialog {
    
    EditDialogViewController *dlgDialog = [[EditDialogViewController alloc] initWithNibName:@"EditDialogViewController" bundle:nil];
    dlgDialog.providesPresentationContextTransitionStyle = YES;
    dlgDialog.definesPresentationContext = YES;
    [dlgDialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDialog.delegate = self;
    
    dlgDialog.type = @"password";
    dlgDialog.content = @"";
    [self presentViewController:dlgDialog animated:NO completion:nil];
}


#pragma mark - Keyboar Notifications

- (void)keyboardDidShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.contentView.tableView.contentInset;
        insets.bottom = keyboardFrameBeginRect.size.height;
        self.contentView.tableView.contentInset = insets;
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.contentView.tableView.contentInset;
        insets.bottom = 0.0f;
        self.contentView.tableView.contentInset = insets;
    }];
}

@end
