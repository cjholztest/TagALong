//
//  AthleteInfoViewController.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AthleteInfoViewController.h"
#import "AthleteInfoModel.h"
#import "AthleteInfoView.h"
#import "AthleteDataModel.h"
#import "UIViewController+Storyboard.h"
#import "SubmitOfferViewController.h"
#import "Pin.h"

@interface AthleteInfoViewController () <AthleteInfoModelOutput, AthleteInfoViewOutput, AthleteInfoModuleInput, SubmitOfferModuleOutput>

@property (nonatomic, weak) IBOutlet AthleteInfoView *contentView;
@property (nonatomic, strong) id <AthleteInfoModelInput> model;

@property (nonatomic, strong) AthleteDataModel *athlete;

@end

@implementation AthleteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    
    self.model = [[AthleteInfoModel alloc] initWithOuput:self];
    self.contentView.output = self;
    
    [self.contentView setupWithAthlete:self.athlete];
    [self movePinToLocation:self.athlete.locatoinCoordinate];
}

#pragma mark - AthleteInfoModelOutput

- (void)dataDidLoad {
    
}

#pragma mark - AthleteInfoViewOutput

- (void)tagALongButtonDidTap {
    
    SubmitOfferViewController *submitVC = (SubmitOfferViewController*)SubmitOfferViewController.fromStoryboard;
    submitVC.moduleOutput = self;
    [submitVC setupWithAthleteID:[self.athlete.userUID stringValue]];
    [self.navigationController pushViewController:submitVC animated:YES];
}

#pragma mark - AthleteInfoModuleInput

- (void)setupWithAthlete:(AthleteDataModel*)athlete {
    self.athlete = athlete;
}

#pragma mark - SubmitOfferModuleOutput

#pragma mark - Private

- (void)movePinToLocation:(CLLocationCoordinate2D)location {
    
    id annotation = [self.contentView.mapView.annotations lastObject];
    
    if (annotation) {
        [self.contentView.mapView removeAnnotation:annotation];
    }
    
    Pin *pin = [[Pin alloc] initWithCoordinate:location];
    
    [self.contentView.mapView addAnnotation:pin];
    [self.contentView.mapView showAnnotations:@[pin] animated:YES];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [self.contentView.mapView regionThatFits:viewRegion];
    
    if( location.latitude > -89 && location.latitude < 89 && location.longitude > -179 && location.longitude < 179 ){
        [self.contentView.mapView setRegion:adjustedRegion animated:YES];
    }
}

@end
