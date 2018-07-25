//
//  WorkoutDetailsViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsViewController.h"
#import "WorkoutDetailsModuleHeaders.h"

@interface WorkoutDetailsViewController ()
<
WorkoutDetailsModelOutput,
WorkoutDetailsViewOutput,
WorkoutDetailsTitleSectionAdapterOutput,
WorkoutDetailsMainSectionAdapterOutput,
WorkoutDetailsAdditionalSectionAdapterOutput,
AddCreditCardModuleDelegate,
EditDialogViewControllerDelegate
>

@property (nonatomic, weak) IBOutlet WorkoutDetailsView *contentView;
@property (nonatomic, strong) id <WorkoutDetailsModelInput> model;

@property (nonatomic, strong) id <WorkoutDetailsTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) NSString *workoutUID;
@property (nonatomic, strong) NSArray *displayModels;

@property (nonatomic, assign) WorkoutDetailsButtonType type;

@end

@implementation WorkoutDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.contentView.profileIconImageView.layer.cornerRadius = self.contentView.profileIconImageView.bounds.size.width / 2.0;
    self.contentView.profileIconImageView.clipsToBounds = YES;
}

- (void)setup {
    self.model = [[WorkoutDetailsModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    WorkoutDetailsTableViewAdapter *tableAdapter = [[WorkoutDetailsTableViewAdapter alloc] init];
    
    tableAdapter.sectionAdapters = [NSMutableArray<WorkoutDetailsSectionAdapter> arrayWithObjects:
                                    [[WorkoutDetailsTitleSectionAdapter alloc] initWithOutput:self],
                                    [[WorkoutDetailsMainSectionAdapter alloc] initWithOutput:self],
                                    [[WorkoutDetailsAdditionalSectionAdapter alloc] initWithOutput:self], nil];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
    
    [self.model loadDetaisForWorkout:self.workoutUID];
}

#pragma mark - WorkoutDetailsModelOutput

- (void)workoutDetaisDidLoadSuccess:(BOOL)isSuccessed
                            message:(NSString*)message
                      displayModels:(NSArray*)displayModels
                profileDisplayModel:(WorkoutDetailsViewDisplayModel*)profileDisplayModel {
    
    if (!isSuccessed) {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
        return;
    }
    
    self.displayModels = displayModels;
    
    [self.contentView.tableView reloadData];
    [self.contentView setupWithProfileInfo:profileDisplayModel];
}

- (void)workoutDidBookSuccess:(BOOL)isSuccessed
                      message:(NSString*)message {
    if (!isSuccessed) {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [self showAllertWithTitle:@"SUCCESS" message:message okTitle:@"Great" okCompletion:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)showConfirmationPyamentAlertWithAmount:(NSString *)amount andCompletion:(void (^)(void))completion {
    
    NSString *title = @"BOOK CONFIRMATION";
    NSString *message = [NSString stringWithFormat:@"Your card will be charged %@ for booking a workout. Confirm withdrawal of funds?", amount];
    
    [self showAllertWithTitle:title message:message yesCompletion:^{
        if (completion) {
            completion();
        }
    } noCompletion:nil];
}

- (void)creditCardNotFound {
    [self showAddCreditCard];
}

- (void)proUserCreditCardNotFound {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    addCreditCardVC.modeType = AddCreditCardtProUserModeTypePostWorkout;
    [self.navigationController pushViewController:addCreditCardVC animated:YES];
}

- (void)showLoader {
    [SharedAppDelegate showLoading];
}

- (void)hideLoader {
    [SharedAppDelegate closeLoading];
}

#pragma mark - WorkoutDetailsViewOutput

- (void)bookWorkoutNowDidTap {
    if (self.model.isWokoutFree) {
        [self.model bookFreeWorkout];
    } else {
        [self.model bookWorkoutWithPassword:nil];
    }
}

- (void)payBookedWorkoutDidTap {
    [self.model payBookedWorkoutWithPassword:nil];
}

- (void)showVisitorsDidTap {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListOfWorkoutVisitorsViewController *visitorsVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ListOfWorkoutVisitorsViewController class])];
    visitorsVC.workoutID = self.workoutUID;
    [self.navigationController pushViewController:visitorsVC animated:YES];
}

#pragma mark - WorkoutDetailsModuleInput

- (void)setupWorkout:(id)workout {
    self.workoutUID = workout;
}

#pragma mark - WorkoutDetailsTitleSectionAdapterOutput

- (NSString*)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model titleText];
}

#pragma mark - WorkoutDetailsMainSectionAdapterOutput

- (NSInteger)mainRowsCount {
    return self.displayModels.count;
}

- (id)workoutDisplayModelAtIndexPath:(NSIndexPath*)indexPath {
    return self.displayModels[indexPath.row];
}

#pragma mark - WorkoutDetailsAdditionalSectionAdapterOutput

- (NSString*)additionalTextAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model additionalInfoText];
}

#pragma mark - Credit Cards

- (void)showAddCreditCard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditCardVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditCardVC.moduleDelegate = self;
    addCreditCardVC.modeType = AddCreditCardtModeTypePostWorkout;
    [self.navigationController pushViewController:addCreditCardVC animated:YES];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popViewControllerAnimated:YES];
//    self.model 
}

#pragma mark - Private

- (void)showEnterPasswordDialogWithType:(WorkoutDetailsButtonType)type {
    
    EditDialogViewController *dlgDialog = [[EditDialogViewController alloc] initWithNibName:@"EditDialogViewController" bundle:nil];
    dlgDialog.providesPresentationContextTransitionStyle = YES;
    dlgDialog.definesPresentationContext = YES;
    [dlgDialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDialog.delegate = self;
    
    dlgDialog.type = @"password";
    dlgDialog.content = @"";
    
    self.type = type;
    
    [self presentViewController:dlgDialog animated:NO completion:nil];
}

#pragma mark - EditDialogViewControllerDelegate

- (void)setContent:(NSString*)type msg:(NSString*)content {
    
    if ([type isEqualToString:@"password"]) {
        
        switch (self.type) {
            case BookNowButtonType:
                [self.model bookWorkoutWithPassword:content];
                break;
            case PayBoockedButtonType:
                [self.model payBookedWorkoutWithPassword:content];
                break;
            default:
                break;
        }
    }
}

@end
