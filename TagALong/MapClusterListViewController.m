//
//  MapClusterListViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/15/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "MapClusterListViewController.h"
#import "ExportSportsListTableViewCell.h"
#import "SportsListTableViewCell.h"
#import "BookWorkoutViewController.h"

@interface MapClusterListViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *arrSportNM;
    NSArray *arrLevel;
    NSArray *arrSportImg;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapClusterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SportsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SportsListTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExportSportsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExportSportsListTableViewCell"];
    
    arrSportNM = [NSArray arrayWithObjects: @"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth",  @"Other Sports/Equipment", nil];
    arrLevel = [NSArray arrayWithObjects: @"Individual", @"Gym", @"Pro", @"Trainer", nil];
    arrSportImg = [NSArray arrayWithObjects: @"icon_running.png", @"icon_bike.png", @"icon_yoga.png", @"icon_pilates.png",@"icon_crossfit.png", @"icon_arts.png",  @"icon_dance.png", @"icon_combo.png", @"icon_youth.png",@"icon_other.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrSportList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        
        static NSString *CellIdentifier = @"SportsListTableViewCell";
        SportsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dic = _arrSportList[indexPath.row];
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        //NSInteger sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
        NSArray *sports = [[NSArray alloc] initWithObjects:[dic objectForKey:API_RES_KEY_SPORT_UID], nil];
        int sport_uid = [sports.firstObject intValue];
        NSString *distance = @"";
        NSString *startTime = @"";
        NSString *duration = @"";
        NSString *first_name = @"";
        NSString *last_name = @"";
        
        if (![[dic objectForKey:API_RES_KEY_DISTANCE] isEqual:[NSNull null]]) {
            distance = [dic objectForKey:API_RES_KEY_DISTANCE];
        }
        
        if (![[dic objectForKey:API_RES_KEY_START_TIME] isEqual:[NSNull null]]) {
            startTime = [dic objectForKey:API_RES_KEY_START_TIME];
        }
        
        
        if (![[dic objectForKey:API_RES_KEY_DURATION] isEqual:[NSNull null]]) {
            duration = [dic objectForKey:API_RES_KEY_DURATION];
        }
        
        NSString *post_type = [[dic objectForKey:API_RES_KEY_POST_TYPE] stringValue];
        if ([post_type isEqualToString:@"1"]) {
            if (![[dic objectForKey:@"title"] isEqual:[NSNull null]]) {
                NSString *title = [[dic objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
                //NSSet* badWords = [NSSet setWithObjects:@"(null))", nil];
                first_name = title;
                //first_name = [dic objectForKey:@"title"];
            }
            
            if (![[dic objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_USR_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_USER_LAST_NAME];
            }
            
        } else {
            if (![[dic objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_EXPORT_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
            }
        }
        
        if ( [level isEqual:[NSNull null]] )  { //individual
            cell.vwBG.backgroundColor = [UIColor whiteColor];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[0], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow3"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"1"]) { //gym
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[1], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        } else if ([level isEqualToString:@"2"]) { //pro
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[2], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblSportName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow2"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"3"]) { //trainer
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[3], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        }
        
        //profile
        
        if ([post_type isEqualToString:@"1"]) {
            if ([[dic objectForKey:API_RES_KEY_USR_PROFILE] isEqual:[NSNull null]]) {
                cell.ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
            } else {
                NSString *url = [dic objectForKey:API_RES_KEY_USR_PROFILE];
                [cell.ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
            }
        } else {
            if ([[dic objectForKey:API_RES_KEY_EXPORT_PROFILE] isEqual:[NSNull null]]) {
                cell.ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
            } else {
                NSString *url = [dic objectForKey:API_RES_KEY_EXPORT_PROFILE];
                [cell.ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
            }
        }
        
        cell.ivSport.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
//        [cell.bnProfile addTarget:self action:@selector(onClickUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        cell.bnProfile.tag = indexPath.row;
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"ExportSportsListTableViewCell";
        ExportSportsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dic = _arrSportList[indexPath.row];
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        //NSInteger sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
        NSArray *sports = [[NSArray alloc] initWithObjects:[dic objectForKey:API_RES_KEY_SPORT_UID], nil];
        int sport_uid = [sports.firstObject intValue];
        NSString* startTime = @"";
        NSString *first_name = @"";
        NSString *last_name = @"";
        
        if (![[dic objectForKey:API_RES_KEY_START_TIME] isEqual:[NSNull null]]) {
            startTime = [dic objectForKey:API_RES_KEY_START_TIME];
        }
        
        NSString *post_type = [[dic objectForKey:API_RES_KEY_POST_TYPE] stringValue];
        if ([post_type isEqualToString:@"1"]) {
            if (![[dic objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_USR_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_USER_LAST_NAME];
            }
            
        } else {
            if (![[dic objectForKey:API_RES_KEY_EXPORT_NCK_NM] isEqual:[NSNull null]]) {
                first_name = [dic objectForKey:API_RES_KEY_EXPORT_NCK_NM];
            }
            
            if (![[dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME] isEqual:[NSNull null]]) {
                last_name = [dic objectForKey:API_RES_KEY_EXPORT_LAST_NAME];
            }
        }
        
        if ( [level isEqual:[NSNull null]] )  { //individual
            cell.vwBG.backgroundColor = [UIColor whiteColor];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[0], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow3"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"1"]) { //gym
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[1], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
        } else if ([level isEqualToString:@"2"]) { //pro
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[2], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor blackColor];
            cell.lblSportName.textColor = [UIColor blackColor];
            cell.lblDistance.textColor = [UIColor blackColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow2"];
            cell.lblSportName.textColor = [UIColor blackColor];
        } else if ([level isEqualToString:@"3"]) { //trainer
            cell.vwBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
            cell.lblSportName.text = [NSString stringWithFormat:@"%@ / %@", arrLevel[3], arrSportNM[sport_uid - 1]];
            cell.lblName.textColor = [UIColor whiteColor];
            cell.lblSportName.textColor = [UIColor whiteColor];
            cell.lblDistance.textColor = [UIColor whiteColor];
            cell.ivArrow.image = [UIImage imageNamed:@"ic_right_arrow1"];
            cell.lblSportName.textColor = [UIColor whiteColor];
        }
        
        cell.ivSport.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
        
        //NSString *temp = [NSString stringWithFormat:@"%02ld:%02ld", (startTime * 15 ) / 60, (startTime * 15 ) % 60];
        //NSString *temp = [self startTime:startTime];
        cell.lblDistance.text = startTime;
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = _arrSportList[indexPath.row];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    if (Global.g_user.user_uid  == [[dic objectForKey:API_RES_KEY_USER_UID] intValue] || Global.g_expert.export_uid == [[dic objectForKey:API_RES_KEY_EXPERT_UID] intValue]) {
        vc.bProfile = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
