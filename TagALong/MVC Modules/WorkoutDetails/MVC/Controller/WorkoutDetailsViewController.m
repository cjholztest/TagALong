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
WorkoutDetailsAdditionalSectionAdapterOutput
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
    
    [SharedAppDelegate showLoading];
    [self.model loadDetaisForWorkout:self.workoutUID];
}

#pragma mark - WorkoutDetailsModelOutput

- (void)workoutDetaisDidLoadSuccess:(BOOL)isSuccessed
                            message:(NSString*)message
                      displayModels:(NSArray*)displayModels
                profileDisplayModel:(WorkoutDetailsViewDisplayModel*)profileDisplayModel {
    
    [SharedAppDelegate closeLoading];
    
    if (!isSuccessed) {
        [self showAllertWithTitle:@"ERROR" message:message okCompletion:nil];
        return;
    }
    
    self.displayModels = displayModels;
    
    [self.contentView.tableView reloadData];
    [self.contentView setupWithProfileInfo:profileDisplayModel];
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

@end
