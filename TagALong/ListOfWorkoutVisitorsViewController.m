//
//  ListOfWorkoutVisitorsViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ListOfWorkoutVisitorsViewController.h"
#import "WorkoutVisitorTableViewCell.h"

@interface ListOfWorkoutVisitorsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListOfWorkoutVisitorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WorkoutVisitorTableViewCellIdentifier";
    WorkoutVisitorTableViewCell *cell = (WorkoutVisitorTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
