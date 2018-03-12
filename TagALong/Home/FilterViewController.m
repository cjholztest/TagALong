//
//  FilterViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterCollectionViewCell.h"

typedef enum PickerType {
    from,
    to
} PickerType;

@interface FilterViewController ()<UIScrollViewDelegate>{

    NSArray *arrLevel;
    NSArray *arrLevelIndex;
    NSArray *arrTraining;
    NSArray *arrWorkout;
    NSArray *arrDistance;
    
    NSInteger arrLevelSel[4];
    NSInteger arrTrainingSel[10];
    NSInteger arrWorkoutSel[18];

    NSInteger ncurDisSel;
    NSString *strDistance;
    
    NSInteger datePickerType; //1: From, 2: To
    PickerType pickerType;
    
    NSDateFormatter *formatter;
}

@property (weak, nonatomic) IBOutlet UICollectionView *clLevel;
@property (weak, nonatomic) IBOutlet UICollectionView *clTraining;
@property (weak, nonatomic) IBOutlet UICollectionView *clWorkout;
@property (weak, nonatomic) IBOutlet UILabel *lbldis1;
@property (weak, nonatomic) IBOutlet UILabel *lbldis2;
@property (weak, nonatomic) IBOutlet UILabel *lbldis3;
@property (weak, nonatomic) IBOutlet UILabel *lbldis4;
@property (weak, nonatomic) IBOutlet UILabel *lbldis5;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *workoutTypeCollectionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *focusOnCollectionHeight;

@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([Global.g_user.user_login isEqualToString:@"2"]) {
        arrLevel = [NSArray arrayWithObjects:@"Trainer", @"Classes", @"Individual", nil];
    } else {
        arrLevel = [NSArray arrayWithObjects:@"Pro", @"Trainer", @"Classes", @"Individual", nil];
    }
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    arrLevelIndex = [NSArray arrayWithObjects:@"2", @"3", @"1", @"0", nil];
    arrTraining = [NSArray arrayWithObjects:@"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    arrWorkout = [NSArray arrayWithObjects:@"Cardio", @"Strength", @"Balance", @"Interval", @"High Intensity", @"Weights", nil];
    arrDistance = [NSArray arrayWithObjects:@"0.25", @"2", @"5", @"10", nil];
    
    [self initData];
    
    static NSString * const identifier = @"FilterCollectionViewCell";
    [_clLevel registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    [_clTraining registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    [_clWorkout registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    
    _workoutTypeCollectionHeight.constant = 35 * arrTraining.count/2 + 10 * arrTraining.count/2;
    _focusOnCollectionHeight.constant = 35 * arrWorkout.count/2 + 10 * arrWorkout.count/2;
    
    if (self.startDate != 0) {
        _fromLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
    }
    
    if (self.endDate != 0) {
        _toLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_endDate]];
    }
}

-(void)configureDatePicker {
    _datePicker.minimumDate = [NSDate date];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fromButtonTapped:(id)sender {
    pickerType = from;
    [UIView animateWithDuration:0.25 animations:^{
        [_datePickerView setHidden:NO];
    }];
}

- (IBAction)toButtonTapped:(id)sender {
    pickerType = to;
    [UIView animateWithDuration:0.25 animations:^{
        [_datePickerView setHidden:NO];
    }];
}

- (IBAction)onClickDateConfirm:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [_datePickerView setHidden:YES];
    }];
    
    NSString *dateString = [formatter stringFromDate:_datePicker.date];
    
    if (pickerType == from) {
        _startDate = [self.datePicker.date timeIntervalSince1970];
        self.fromLabel.text = dateString;
    } else {
        _endDate = [self.datePicker.date timeIntervalSince1970];;
        self.toLabel .text = dateString;
    }
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (collectionView == _clLevel) {
        return arrLevel.count;
    } else if (collectionView == _clTraining){
        return arrTraining.count;
    } else if (collectionView == _clWorkout){
        return arrWorkout.count;
    }
    return 0;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger width = (collectionView.bounds.size.width - 10) / 2;
    return CGSizeMake(width, 35);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];
    
    if (collectionView == _clLevel) {
        cell.lblName.text = arrLevel[indexPath.row];
        cell.lcNameLeft.constant = 8.0f;
        if (arrLevelSel[indexPath.row] == 1) {
            [cell.ivCheck setHidden:NO];
        } else {
            [cell.ivCheck setHidden:YES];
        }
        return cell;
    } else if (collectionView == _clTraining){
        cell.lblName.text = arrTraining[indexPath.row];
        cell.lcNameLeft.constant = 8.0f;
        if (arrTrainingSel[indexPath.row] == 1) {
            [cell.ivCheck setHidden:NO];
        } else {
            [cell.ivCheck setHidden:YES];
        }
        return cell;
    } else if (collectionView == _clWorkout){
        cell.lblName.text = arrWorkout[indexPath.row];
        cell.lcNameLeft.constant = 8.0f;
        if (arrWorkoutSel[indexPath.row] == 1) {
            [cell.ivCheck setHidden:NO];
        } else {
            [cell.ivCheck setHidden:YES];
        }
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _clLevel) {
        if (arrLevelSel[indexPath.row] == 1) {
            arrLevelSel[indexPath.row] = 0;
        } else {
            arrLevelSel[indexPath.row] = 1;
        }
        [_clLevel reloadData];
    } else if (collectionView == _clTraining){
        if (arrTrainingSel[indexPath.row] == 1) {
            arrTrainingSel[indexPath.row] = 0;
        } else {
            arrTrainingSel[indexPath.row] = 1;
        }

        [_clTraining reloadData];
    } else if (collectionView == _clWorkout){
        if (arrWorkoutSel[indexPath.row] == 1) {
            arrWorkoutSel[indexPath.row] = 0;
        } else {
            arrWorkoutSel[indexPath.row] = 1;
        }
        [_clWorkout reloadData];
    }
}

#pragma mark - user defined functions

-(void)initData{
    [self clearData];
  
    NSArray *arr1 = [self.level_filter componentsSeparatedByString:@","];
    for (int i = 0; i < arr1.count; i++) {
        NSString *temp = [arr1 objectAtIndex:i];
        
        for (int k = 0; k < arrLevelIndex.count; k++) {
            if ([temp isEqualToString:arrLevelIndex[k]]) {
                arrLevelSel[k] = 1;
            }
        }
    }

    NSArray *arr2 = [self.sport_filter componentsSeparatedByString:@","];
    for (int i = 0; i < arr2.count; i++) {
        NSInteger training_index = [[arr2 objectAtIndex:i] intValue];
        if (training_index != 0) {
            arrTrainingSel[training_index - 1] = 1;
        }
        
    }
    
    NSArray *arr3 = [self.cate_filter componentsSeparatedByString:@","];
    for (int i = 0; i < arr3.count; i++) {
        NSInteger workout_index = [[arr3 objectAtIndex:i] intValue];
        if (workout_index != 0) {
            arrWorkoutSel[workout_index - 1] = 1;
        }
    }
    
    for (int i=0; i < arrDistance.count; i++) {
        if ([self.distance_limit isEqualToString:arrDistance[i]]) {
            ncurDisSel = i;
            strDistance = self.distance_limit;
        }
    }

    _lbldis1.textColor = [UIColor blackColor];
    _lbldis2.textColor = [UIColor blackColor];
    _lbldis3.textColor = [UIColor blackColor];
    _lbldis4.textColor = [UIColor blackColor];
    _lbldis5.textColor = [UIColor blackColor];
    if (ncurDisSel == 0) {
        _lbldis1.textColor = [UIColor blueColor];
    } else if (ncurDisSel == 1) {
        _lbldis2.textColor = [UIColor blueColor];
    } else if (ncurDisSel == 2) {
        _lbldis3.textColor = [UIColor blueColor];
    } else if (ncurDisSel == 3) {
        _lbldis4.textColor = [UIColor blueColor];
    } else if (ncurDisSel == 4) {
        _lbldis5.textColor = [UIColor blueColor];
    }
}

-(void)clearData{
    for (int i = 0; i < arrLevel.count; i++) {
        arrLevelSel[i] = 0;
    }
    for (int i = 0; i < arrTraining.count; i++) {
        arrTrainingSel[i] = 0;
    }
    
    for (int i = 0; i < arrWorkout.count; i++) {
        arrWorkoutSel[i] = 0;
    }
    
    ncurDisSel = -1;
    strDistance = @"";
    _lbldis1.textColor = [UIColor blackColor];
    _lbldis2.textColor = [UIColor blackColor];
    _lbldis3.textColor = [UIColor blackColor];
    _lbldis4.textColor = [UIColor blackColor];
    _lbldis5.textColor = [UIColor blackColor];
}

#pragma mark - click events
- (IBAction)onClickReset:(id)sender {

    [self clearData];
    [_clLevel reloadData];
    [_clWorkout reloadData];
    [_clTraining reloadData];
    self.fromLabel.text = @"";
    self.toLabel.text = @"";
    _startDate = 0;
    _endDate = 0;
}


- (IBAction)onClickClose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickDistance:(id)sender {
    NSInteger selindex = [sender tag];
    
    _lbldis1.textColor = [UIColor blackColor];
    _lbldis2.textColor = [UIColor blackColor];
    _lbldis3.textColor = [UIColor blackColor];
    _lbldis4.textColor = [UIColor blackColor];
    _lbldis5.textColor = [UIColor blackColor];
    switch (selindex) {
        case 1:
            strDistance = arrDistance[0];
            _lbldis1.textColor = [UIColor blueColor];
            break;
        case 2:
            strDistance = arrDistance[1];
            _lbldis2.textColor = [UIColor blueColor];
            break;
        case 3:

            strDistance = arrDistance[2];
            _lbldis3.textColor = [UIColor blueColor];
            break;
        case 4:
            strDistance = arrDistance[3];
            _lbldis4.textColor = [UIColor blueColor];
            break;
        case 5:
            strDistance = arrDistance[4];
            _lbldis5.textColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}


- (IBAction)onClickApply:(id)sender {
    
    NSString *strlevel = @"";
    NSString *strsport = @"";
    NSString *strcat = @"";
    
    for (int i = 0; i < arrLevel.count; i++) {
        if (arrLevelSel[i] == 1) {
            strlevel = [NSString stringWithFormat:@"%@,%@", strlevel, arrLevelIndex[i]];
        }
    }
    strlevel = [strlevel stringByTrimmingCharactersInSet:
                               [NSCharacterSet characterSetWithCharactersInString:@","]];

    for (int i = 0; i < arrTraining.count; i++) {
        if (arrTrainingSel[i] == 1) {
            strsport = [NSString stringWithFormat:@"%@,%d", strsport, (i + 1)];
        }
    }
    strsport = [strsport stringByTrimmingCharactersInSet:
                [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    for (int i = 0; i < arrWorkout.count; i++) {
        if (arrWorkoutSel[i] == 1) {
            strcat = [NSString stringWithFormat:@"%@,%d", strcat, (i + 1)];
        }

    }
    strcat = [strcat stringByTrimmingCharactersInSet:
                [NSCharacterSet characterSetWithCharactersInString:@","]];

    [self.delegate setFilter:strlevel sport:strsport cat:strcat distance:strDistance startDate:_startDate endDate:_endDate];

    [self.navigationController popViewControllerAnimated:NO];
}

@end
