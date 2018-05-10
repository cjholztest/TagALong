//
//  ProsViewController.m
//  TagALong
//
//  Created by User on 5/10/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsViewController.h"
#import "ProsModuleProtocols.h"
#import "ProsModel.h"
#import "ProsView.h"

@interface ProsViewController () <ProsModelOutput, ProsViewOutput, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id <ProsModelInput, ProsModelDataSource> model;
@property (nonatomic, weak) IBOutlet ProsView *contentView;

@end

@implementation ProsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup {
    self.model = [[ProsModel alloc] initWithOutput:self];
    self.contentView.output = self;
    self.contentView.tableView.delegate = self;
    self.contentView.tableView.dataSource = self;
}

#pragma mark - ProsModelOutput

- (void)prosDidLoadSuccessfully {
    
}

- (void)prosDidLoadWithError:(NSString*)errorMessage {
    
}

#pragma mark - ProsViewOutput

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model athletesCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    id athlete = [self.model athleteAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
