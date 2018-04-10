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
@property (weak, nonatomic) IBOutlet UILabel *noVisitorsLabel;
@property (nonatomic, strong) NSArray *visitorsList;

@end

@implementation ListOfWorkoutVisitorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.workoutID) {
        [self updateVisitorsList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.visitorsList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WorkoutVisitorTableViewCellIdentifier";
    WorkoutVisitorTableViewCell *cell = (WorkoutVisitorTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *firstName = self.visitorsList[indexPath.row][API_REQ_KEY_USER_NICKNAME];
    NSString *lastName = self.visitorsList[indexPath.row][API_REQ_KEY_USER_LAST_NAME];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    NSString *photoURL = self.visitorsList[indexPath.row][API_REQ_KEY_USER_PROFILE_IMG];
    if (photoURL) {
        [cell.profileIconImageView sd_setImageWithURL:[NSURL URLWithString:photoURL]
                                     placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *footerIdentifier = @"VisitorFooterView";
    UIView *footerView = [tableView dequeueReusableCellWithIdentifier:footerIdentifier];
    if (!footerView) {
        footerView = [UIView new];
    }
    return footerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Network

- (void)updateVisitorsList {
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"booked_users"];
    NSDictionary *params = @{ API_REQ_KEY_WORKOUT_UID: self.workoutID };
    __weak typeof(self)weakSelf = self;
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [SharedAppDelegate closeLoading];
        weakSelf.visitorsList = (NSArray*)responseObject;
        [weakSelf.tableView reloadData];
        
        BOOL isVisitorsListEmpty = weakSelf.visitorsList.count == 0 || !weakSelf.visitorsList;
        [weakSelf.tableView setHidden:isVisitorsListEmpty];
        [weakSelf.noVisitorsLabel setHidden:!isVisitorsListEmpty];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

@end
