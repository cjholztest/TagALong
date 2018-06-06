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
#import "ProsTableViewAdapter.h"
#import "ProsModuleProtocols.h"
#import "ProsModel.h"
#import "ProsView.h"
#import "AthleteInfoViewController.h"

@interface ProsViewController () <ProsModelOutput, ProsViewOutput, ProsMainSectionAdapterOutput>

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

#pragma mark - Setup

- (void)setup {
    
    self.contentView.output = self;
    self.model = [[ProsModel alloc] initWithOutput:self];
    
    ProsMainSectionAdapter *mainSection = [[ProsMainSectionAdapter alloc] initWithOutput:self];
    
    ProsTableViewAdapter *prosTableViewAdapter = [ProsTableViewAdapter new];
    [prosTableViewAdapter.sectionAdapters addObject:mainSection];
    
    self.tableViewAdapter = prosTableViewAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - ProsModelOutput

- (void)prosDidLoadSuccessfully {
    [self.contentView.tableView reloadData];
}

- (void)prosDidLoadWithError:(NSString*)errorMessage {
    
}

#pragma mark - ProsViewOutput

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

@end
