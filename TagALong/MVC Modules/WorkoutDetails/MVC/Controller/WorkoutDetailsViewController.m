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

- (void)setup {
    self.model = [[WorkoutDetailsModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    WorkoutDetailsTableViewAdapter *tableAdapter = [[WorkoutDetailsTableViewAdapter alloc] init];
    
    tableAdapter.sectionAdapters = [NSMutableArray<WorkoutDetailsSectionAdapter> arrayWithObjects:
                                    [[WorkoutDetailsMainSectionAdapter alloc] initWithOutput:self],
                                    [[WorkoutDetailsAdditionalSectionAdapter alloc] initWithOutput:self], nil];
    
    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - WorkoutDetailsModelOutput

#pragma mark - WorkoutDetailsViewOutput

#pragma mark - WorkoutDetailsModuleInput

- (void)setupWorkout:(id)workout {
    self.workoutUID = workout;
}

#pragma mark - WorkoutDetailsMainSectionAdapterOutput

- (NSInteger)reviewRowsCount {
    return 0;
}

- (id)infoDisplayModelAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}

#pragma mark - WorkoutDetailsAdditionalSectionAdapterOutput

- (NSInteger)additionalRowsCount {
    return 0;
}

- (id)additionalDisplayModelAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}

@end
