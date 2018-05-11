//
//  ProsViewController.m
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsViewController.h"
#import "ProsSectionAdapter.h"
#import "ProsMainSectionAdapter.h"
#import "ProsTableViewAdapter.h"
#import "ProsModuleProtocols.h"
#import "ProsModel.h"
#import "ProsView.h"

@interface ProsViewController () <ProsModelOutput, ProsViewOutput, ProsMainSectionAdapterOutput>

@property (nonatomic, weak) IBOutlet ProsView *contentView;

@property (nonatomic, strong) id <ProsModelInput, ProsModelDataSource> model;
@property (nonatomic, strong) id <ProsTableViewAdapterInput> tableViewAdapter;

@end

@implementation ProsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
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
    
}

@end
