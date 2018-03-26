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
#import "ProfilePaymentDataFriendsController.h"

static NSString *const kCellIdentifier = @"ProfilePaymentFieldCellIdentifier";
static NSString *const kHeaderIentifier = @"ProfilePaymentRegisterHeaderIdentifier";
static NSString *const kFooterRegisterIdentifier = @"ProfilePaymentRegisterFooterIdentifier";
static NSString *const kFooterIdentifier = @"ProfilePaymentFooterIdentifier";

@interface ProfilePaymentDataViewController () <ProfilePaymentDataModelOutput, ProfilePaymentDataUserInterfaceInput, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet ProfilePaymentDataView *contentView;
@property (nonatomic, strong) ProfilePaymentDataModel *model;
@property (nonatomic, strong) ProfilePaymentDataFriendsController *friendsController;

@end

@implementation ProfilePaymentDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDependencies];
//    [self skipButtonDidTap];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupDependencies {
    self.friendsController = [ProfilePaymentDataFriendsController new];
    self.model = [ProfilePaymentDataModel new];
    self.model.output = self;
    self.contentView.eventHandler = self;
    self.contentView.tableView.dataSource = self;
    self.contentView.tableView.delegate = self;
}

#pragma mark - ProfilePaymentDataUserInterfaceInput

- (IBAction)sendbtn:(id)sender {
//    [self skipButtonDidTap];
}
- (void)skipButtonDidTap {
    NSDictionary *birthday = @{@"day" : @(arc4random() % 28), @"month" : @((arc4random() % 10) + 1), @"year" : @(1994)};
    NSDictionary *address = @{@"line1" : @"1234 Main Street", @"postal_code" : @(94111), @"city" : @"San Francisco", @"state" : @"CA"};
    NSDictionary *legacy = @{@"dob" : birthday, @"address" : address, @"first_name" : @"zxcv", @"last_name" : @"Pro", @"ssn_last_4" : @"0000"};
    NSDictionary *params = @{@"legal_entity" : legacy, @"password" : @"111111"};
    
    [PaymentClient registerExpertWithPaymentData:params completion:^(id responseObject, NSError *error) {
        if (error) {
            
        } else {
            
        }
    }];
}

- (void)sendDataButtonDidTap {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)sendData {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfilePaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfilePaymentFieldCellIdentifier"];
    cell.textField.delegate = self;
    cell.textField.placeholder = [self.friendsController placeholderFieldType:indexPath.row];
    cell.textField.keyboardType = [self.friendsController keyboardTypeForFieldType:indexPath.row];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderIentifier];
    return cell.contentView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFooterIdentifier];
    return cell.contentView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0;
}

#pragma mark - UITableVieDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Keyboar Notifications

- (void)keyboardDidShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.contentView.scrollView.contentInset;
        insets.bottom = keyboardFrameBeginRect.size.height;
        self.contentView.scrollView.contentInset = insets;
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.contentView.scrollView.contentInset;
        insets.bottom = 0.0f;
        self.contentView.scrollView.contentInset = insets;
    }];
}

@end
