//
//  ChangePasswordViewController.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordModuleHeaders.h"

@interface ChangePasswordViewController ()
<
ChangePasswordModelOutput,
ChangePasswordViewOutput,
OldPasswordCellAdapterOutput,
NewPasswordCellAdapterOutput,
ConfirmPasswordCellAdapterOutput
>

@property (nonatomic, weak) IBOutlet ChangePasswordView *contentView;
@property (nonatomic, strong) id <ChangePasswordModelInput> model;

@property (nonatomic, strong) id <ChangePasswordTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) UserPassword *userPassword;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupActions];
    [self setup];
}

- (void)setup {
    
    self.navigationItem.title = @"Change Password";
    
    ChangePasswordModel *model = [[ChangePasswordModel alloc] initWithOutput:self];
    
    self.model = model;
    self.contentView.output = self;
    
    self.userPassword = [UserPassword new];
    
    ChangePasswordMainSectionAdapter *mainSection = [ChangePasswordMainSectionAdapter new];
    
    mainSection.cellAdapters =  [NSArray<ChangePasswordCellAdapter> arrayWithObjects:
                                 [[OldPasswordCellAdapter alloc] initWithOutput:self],
                                 [[NewPasswordCellAdapter alloc] initWithOutput:self],
                                 [[ConfirmPasswordCellAdapter alloc] initWithOutput:self], nil];
    
    ChangePasswordTableViewAdapter *tableAdapter = [ChangePasswordTableViewAdapter new];
    tableAdapter.sectionAdapters = [NSArray<ChangePasswordSectionAdapter> arrayWithObject:mainSection];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

- (void)setupActions {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - Actions

- (void)saveButtonAction {
    
    NSString *validationMessage = [self.model isUserPasswordValid:self.userPassword];
    
    if (validationMessage) {
        [self showAllertWithTitle:@"ERROR" message:validationMessage okCompletion:nil];
    } else {
        [self.model savePassword:self.userPassword];
    }
}

#pragma mark - ChangePasswordModelOutput

- (void)passwordDidSaveSuccess:(BOOL)success message:(NSString *)message {
    
    if (success) {
        
        __weak typeof(self)weakSelf = self;
        
        NSString *textMessage = @"New Password did save successfully";
        [self showAllertWithTitle:@"TagALong" message:textMessage okCompletion:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        
    } else {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
    }
}

#pragma mark - ChangePasswordViewOutput

#pragma mark - ChangePasswordModuleInput

#pragma mark - OldPasswordCellAdapterOutput

- (void)oldPasswordDidChange:(NSString*)oldPassword {
    self.userPassword.oldPassword = oldPassword;
}

- (NSString*)oldPassword {
    return self.userPassword.oldPassword;
}

#pragma mark - NewPasswordCellAdapterOutput

- (void)newPasswordDidCange:(NSString*)newPassword {
    self.userPassword.theNewPassword = newPassword;
}

- (NSString*)newPassword {
    return self.userPassword.theNewPassword;
}

#pragma mark - ConfirmPasswordCellAdapterOutput

- (void)cofirmPasswordDidChange:(NSString*)confirmPassword {
    self.userPassword.confirmPassword = confirmPassword;
}

- (NSString*)confirmPassword {
    return self.userPassword.confirmPassword;
}

@end
