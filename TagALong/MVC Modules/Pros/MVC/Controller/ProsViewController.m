//
//  ProsViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsViewController.h"
#import "ProsSectionAdapter.h"
#import "ProsMainSectionAdapter.h"
#import "NoContentSectionAdapter.h"
#import "ProsTableViewAdapter.h"
#import "ProsModel.h"
#import "ProsView.h"
#import "AthleteInfoViewController.h"
#import "ProsFilterViewController.h"
#import "UIViewController+Storyboard.h"

@interface ProsViewController ()
<
ProsModelOutput,
ProsViewOutput,
ProsMainSectionAdapterOutput,
NoContentSectionAdapterOutput,
ProsFilterModuleOutput
>

@property (nonatomic, weak) IBOutlet ProsView *contentView;

@property (nonatomic, strong) id <ProsModelInput, ProsModelDataSource> model;
@property (nonatomic, strong) id <ProsTableViewAdapterInput> tableViewAdapter;

@end

@implementation ProsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.model loadPros];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(showProsFilter)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Setup

- (void)setup {
    
    self.contentView.output = self;
    self.model = [[ProsModel alloc] initWithOutput:self];
    
    ProsMainSectionAdapter *mainSection = [[ProsMainSectionAdapter alloc] initWithOutput:self];
    NoContentSectionAdapter *noContentSection = [[NoContentSectionAdapter alloc] initWithOutput:self];
    
    ProsTableViewAdapter *prosTableViewAdapter = [ProsTableViewAdapter new];
    [prosTableViewAdapter.sectionAdapters addObject:mainSection];
    [prosTableViewAdapter.sectionAdapters addObject:noContentSection];
    
    self.tableViewAdapter = prosTableViewAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProsModelOutput

- (void)prosDidLoadSuccessfully {
    NSString *title = nil;
    if (self.model.isCurrentProUserAloneInArea) {
        title = @"You are the only Pro Athlete in your area.";
    } else {
        title = @"Athletes Registered in your Area.";
    }
    
    self.contentView.titleLabel.text = title;
    [self.contentView.tableView reloadData];
}

- (void)prosDidLoadWithError:(NSString*)errorMessage {
    
}

#pragma mark - ProsViewOutput

#pragma mark - NoContentSectionAdapterOutput

- (BOOL)isNoContentVisible {
    return [self.model athletesCount] == 0;
}

#pragma mark - ProsMainSectionAdapterOutput

- (NSInteger)rowsCount {
    return [self.model athletesCount];
}

- (id)rowDisplayModelAtIndexPath:(NSIndexPath*)indexPath {
    return [self.model athleteAtIndex:indexPath.row];
}

- (void)didTouchRowAtIndexPath:(NSIndexPath*)indexPath {
    AthleteInfoViewController *athleteVC = [[UIStoryboard storyboardWithName:NSStringFromClass(AthleteInfoViewController.class) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(AthleteInfoViewController.class)];
    AthleteDataModel *athlete = [self.model athleteDetailsAtIndex:indexPath.row];
    [athleteVC setupWithAthlete:athlete];
    [self.navigationController pushViewController:athleteVC animated:YES];
}

#pragma mark - ProsModuleInput

- (void)radiusDidChangeTo:(NSString*)miles {
    [self.model loadProsInRadius:miles];
}

#pragma mark - ProsFilterModuleOutput

#pragma mark - Actions

- (void)showProsFilter {
    
    ProsFilterViewController *vc = (ProsFilterViewController*)ProsFilterViewController.fromStoryboard;
    vc.moduleOutput = self;
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationVC animated:YES completion:nil];
}

@end
