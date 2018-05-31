//
//  WorkoutDetailsViewController.m
//  TagALong
//
//  Created by User on 5/29/18.
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
AddCreditCardModuleDelegate
>

@property (nonatomic, weak) IBOutlet WorkoutDetailsView *contentView;
@property (nonatomic, strong) id <WorkoutDetailsModelInput> model;

@property (nonatomic, strong) id <WorkoutDetailsTableViewAdapterInput> tableViewAdapter;

@property (nonatomic, strong) NSString *workoutUID;
@property (nonatomic, strong) NSArray *displayModels;

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
    
//    self show
}

- (void)showConfirmationPyamentAlertWithCompletion:(void(^)(void))completion {
    
}

- (void)creditCardNotFound {
    [self showAddCreditCard];
}

- (void)showLoader {
    [SharedAppDelegate showLoading];
}

- (void)hideLoader {
    [SharedAppDelegate closeLoading];
}

#pragma mark - WorkoutDetailsViewOutput

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

@end
