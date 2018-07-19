//
//  AreaWorkoutViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "AreaWorkoutViewController.h"
#import "TypeWorkoutCollectionViewCell.h"

@interface AreaWorkoutViewController (){
    NSArray *arrAreaImg;
    NSArray *arrAreaName;
    NSInteger arrSels[6];
}

@property (strong, nonatomic) IBOutlet UICollectionView *clArea;

@end

@implementation AreaWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrAreaImg = [NSArray arrayWithObjects:@"ic_cardio.png", @"ic_strength.png", @"ic_intensity.png", @"ic_balance.png", @"ic_weights.png", @"stopwatch-icon.png", nil];
    arrAreaName = [NSArray arrayWithObjects:@"Cardio", @"Strength", @"High Intensity", @"Balance", @"Weights", @"Intervals", @"Other", nil];
    
    static NSString * const identifier = @"TypeWorkoutCollectionViewCell";
    [_clArea registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    
    for (NSInteger i = 0; i < 6; i++)
        arrSels[i] = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrAreaImg.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = (collectionView.bounds.size.width - 20) / 2;
    return CGSizeMake(width, 110);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TypeWorkoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeWorkoutCollectionViewCell" forIndexPath:indexPath];
    
    cell.ivSport.image = [UIImage imageNamed:arrAreaImg[indexPath.row]];
    cell.lblName.text = arrAreaName[indexPath.row];
    
    if (arrSels[indexPath.row] == 1) {
        //[cell.ivSport setAlpha:0.5];
        [cell.ivSelBG setHidden:NO];
        [cell.lblName setAlpha:0.5];
    } else {
        //[cell.ivSport setAlpha:1];
        [cell.ivSelBG setHidden:YES];
        [cell.lblName setAlpha:1];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (arrSels[indexPath.row] == 1) {
        arrSels[indexPath.row] = 0;
    } else {
        arrSels[indexPath.row] = 1;
    }
    [_clArea reloadData];
    
    _categories = @"";
    for (int i = 0; i < arrAreaName.count; i++) {
        if (arrSels[i] == 1) {
            _categories = [NSString stringWithFormat:@"%@,%d", _categories, (i + 1)];
        }
    }
    _categories = [_categories stringByTrimmingCharactersInSet:
              [NSCharacterSet characterSetWithCharactersInString:@","]];
}

@end
