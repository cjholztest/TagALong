//
//  TypeWorkoutViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "TypeWorkoutViewController.h"
#import "TypeWorkoutCollectionViewCell.h"

@interface TypeWorkoutViewController (){
    NSArray *arrTypeImg;
    NSArray *arrTypeName;
    NSInteger nCurSel;
    NSInteger arrSels[6];
}
@property (strong, nonatomic) IBOutlet UICollectionView *clType;

@end

@implementation TypeWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nCurSel = -1;
    
    // Do any additional setup after loading the view, typically from a nib.
    
//    arrTypeImg = [NSArray arrayWithObjects:@"ic_running.png", @"ic_cycling.png", @"ic_yoga.png", @"ic_pilates.png", @"ic_crossfit.png", @"ic_martial.png", @"ic_dance.png", @"ic_combo.png", @"ic_youth.png", @"ic_other_sport.png", nil];
//    arrTypeName = [NSArray arrayWithObjects:@"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Martial Arts", @"Dance", @"Combo", @"Youth", @"Other sport/Equipment", nil];
    
    arrTypeImg = [NSArray arrayWithObjects:@"ic_running.png", @"ic_cycling.png", @"ic_yoga.png", @"ic_pilates.png", @"ic_crossfit.png", @"ic_other_sport.png", nil];
    arrTypeName = [NSArray arrayWithObjects:@"Running", @"Cycling", @"Yoga", @"Pilates", @"Crossfit", @"Other", nil];
    
    static NSString * const identifier = @"TypeWorkoutCollectionViewCell";
    [_clType registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    for (NSInteger i = 0; i < 6; i++)
        arrSels[i] = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrTypeImg.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = (collectionView.bounds.size.width - 20) / 2;
    return CGSizeMake(width, 110);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TypeWorkoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeWorkoutCollectionViewCell" forIndexPath:indexPath];
    
    cell.ivSport.image = [UIImage imageNamed:arrTypeImg[indexPath.row]];
    cell.lblName.text = arrTypeName[indexPath.row];
    
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
    [_clType reloadData];
    
    self.sport_uid = @"";
    
    for (int i = 0; i < arrTypeName.count; i++) {
        if (arrSels[i] == 1) {
            self.sport_uid = [NSString stringWithFormat:@"%@,%d", self.sport_uid, (i + 1)];
        }
    }
    self.sport_uid = [self.sport_uid stringByTrimmingCharactersInSet:
                   [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    nCurSel = indexPath.row;
    //self.sport_uid = [NSString stringWithFormat:@"%ld", (nCurSel + 1)];
    //[_clType reloadData];
}


@end
