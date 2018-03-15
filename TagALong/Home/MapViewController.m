//
//  MapViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "MapViewController.h"

#import <MapKit/MKUserLocation.h>
#import "BookWorkoutViewController.h"
#import <MapKit/MKAnnotationView.h>
#import <MapKit/MKPinAnnotationView.h>
#import <MapKit/MKPointAnnotation.h>
#import "FilterViewController.h"
#import "DateSelectDialog.h"
#import <CCHMapClusterController/CCHMapClusterController.h>
#import <CCHMapClusterController/CCHMapClusterControllerDelegate.h>
#import <CCHMapClusterController/CCHMapClusterAnnotation.h>
#import "ClusterAnnotationView.h"
#import "MapClusterListViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, DateSelectDialogDelegate, FilterViewControllerDelegate, CCHMapClusterControllerDelegate>{
    
    MKCoordinateSpan m_span;
    CLLocationManager *locationMng;
    CLLocation *curLocation;
    NSArray *arrSportImg;
    NSArray *arrSportImg1;
    NSArray *arrSportBlueImg;
    NSArray *arrSportYellowImg;
    CLLocationCoordinate2D noLocation;
    NSString *workout_uid;
    NSString *searchdate;
}
@property (nonatomic, strong) NSMutableArray *arrSportList;
@property (strong, nonatomic) IBOutlet UIView *vwPopup;
@property (strong, nonatomic) IBOutlet MKMapView *mvMap;

//popup view
@property (weak, nonatomic) IBOutlet UIImageView *ivSport;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lcvwDateHeight;
@property (weak, nonatomic) IBOutlet UIImageView *icProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
//@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIView *vwSportBG;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIView *vwFilter;
@property (nonatomic, strong) CCHMapClusterController *mapClusterController;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_vwPopup setHidden:YES];
    _icProfile.layer.cornerRadius = _icProfile.frame.size.width / 2;
    
    _mvMap.delegate = self;
    _level_filter = @"";
    _sport_filter = @"";
    _cate_filter = @"";
    _distance_limit = @"";
    
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    searchdate = [dateFormatter stringFromDate:[NSDate date]];
//
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    [formatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
//    formatter1.dateStyle = kCFDateFormatterLongStyle;
//    formatter1.timeStyle = NSDateFormatterNoStyle;
//    _lblDate.text = [formatter1 stringFromDate:[NSDate date]];
    
    arrSportImg = [NSArray arrayWithObjects: @"icon_running_white.png", @"icon_bike_white.png", @"icon_yoga_white.png", @"icon_pilates_white.png",@"icon_crossfit_white.png", @"icon_arts_white.png",  @"icon_dance_white.png", @"icon_combo_white.png", @"icon_youth_white.png",@"icon_other_white.png", nil];
    
    arrSportImg1 = [NSArray arrayWithObjects: @"icon_running.png", @"icon_bike.png", @"icon_yoga.png", @"icon_pilates.png",@"icon_crossfit.png", @"icon_arts.png",  @"icon_dance.png", @"icon_combo.png", @"icon_youth.png",@"icon_other.png", nil];

    arrSportBlueImg = [NSArray arrayWithObjects: @"icon_running_blue.png", @"icon_bike_blue.png", @"icon_yoga_blue.png", @"icon_pilates_blue.png",@"icon_crossfit_blue.png", @"icon_arts_blue.png",  @"icon_dance_blue.png", @"icon_combo_blue.png", @"icon_youth_blue.png",@"icon_other_blue.png", nil];

    arrSportYellowImg = [NSArray arrayWithObjects: @"icon_running_yellow.png", @"icon_bike_yellow.png", @"icon_yoga_yellow.png", @"icon_pilates_yellow.png",@"icon_crossfit_yellow.png", @"icon_arts_yellow.png",  @"icon_dance_yellow.png", @"icon_combo_yellow.png", @"icon_youth_yellow.png",@"icon_other_yellow.png", nil];

    _arrSportList = [[NSMutableArray alloc]  init];
    [self initControl];
    
    self.mapClusterController = [[CCHMapClusterController alloc] initWithMapView:self.mvMap];
    self.mapClusterController.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self addFilterBarButton];
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg_profile_top"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent: YES];
    [self.navigationController.navigationBar setShadowImage:  [UIImage new]];
    [self.navigationController.navigationBar setBarTintColor: UIColor.blackColor];
    
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundColor: UIColor.clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initControl {
    _mvMap.showsUserLocation = YES;
    
    locationMng = [[CLLocationManager alloc] init];
    locationMng.delegate = self;
    locationMng.distanceFilter = kCLDistanceFilterNone;
    locationMng.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationMng requestWhenInUseAuthorization];
//    NSUInteger code = [CLLocationManager authorizationStatus];
//    if (code == kCLAuthorizationStatusNotDetermined && ([locationMng respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationMng respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
//        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]) {
//            [locationMng requestAlwaysAuthorization];
//        } else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
//            [locationMng requestWhenInUseAuthorization];
//        } else {
//            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
//        }
//    }
    [locationMng startUpdatingLocation];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureMap:)];
    [_mvMap addGestureRecognizer:tapRec];

    Global.g_user.user_latitude = [Preference getString:PREFCONST_LATITUDE default:nil];
    Global.g_user.user_longitude = [Preference getString:PREFCONST_LONGTITUDE default:nil];

    if (Global.g_user.user_latitude == nil) {
        Global.g_user.user_latitude = @"38";
    }
    
    if (Global.g_user.user_longitude == nil) {
        Global.g_user.user_longitude = @"-101";
    }
    _mvMap.showsUserLocation = YES;
    MKCoordinateSpan span = [self spanByStatus:[CLLocationManager authorizationStatus]];
    [self updateNoLocationMapAppearanceByState:span];
    
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [self ReqWorkoutList];

        NSString *address_uid = [Preference getString:PREFCONST_ADDRESS_UID default:nil];
        if ([address_uid isEqualToString:@""]) {
            double lat =  locationMng.location.coordinate.latitude;
            double lnd =  locationMng.location.coordinate.longitude;
            
            Global.g_user.user_latitude = [NSString stringWithFormat:@"%f", lat];
            Global.g_user.user_longitude = [NSString stringWithFormat:@"%f", lnd];
            
            [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
            [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];

        }
        if (@available(iOS 11.0, *)) {
            [self setMyPosSetting];
        }
    } else {
        //[self ReqWorkoutList];
        [self ReqExportWorkoutList];
    }
}

-(void)addFilterBarButton {
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action: @selector(onClickFilter:)];
    
    self.vcParent.navigationItem.rightBarButtonItem = filterButton;
}

-(void)setMyPosSetting{
    
    CLLocationCoordinate2D tapPoint = CLLocationCoordinate2DMake([Global.g_user.user_latitude doubleValue], [Global.g_user.user_longitude doubleValue]);
    MKPointAnnotation *ptAnno = [[MKPointAnnotation alloc] init];
    ptAnno.coordinate = tapPoint;
    ptAnno.title = @"-1";
    
    UIImage *img = [UIImage imageNamed:@"ic_me.png"];
    
    [[_mvMap viewForAnnotation:ptAnno] setImage:img];
    [_mvMap viewForAnnotation:ptAnno].userInteractionEnabled = NO;
    [_mvMap viewForAnnotation:ptAnno].enabled = NO;
    [_mvMap addAnnotation:ptAnno];
}

//fiterview delegate
-(void) setFilter:(NSString *)level sport:(NSString *)sport cat:(NSString *)cat distance:(NSString *)distance startDate:(NSTimeInterval)startDate endDate:(NSTimeInterval)endDate {
    _level_filter = level;
    _sport_filter = sport;
    _cate_filter = cat;
    _distance_limit = distance;
    _startDate = startDate;
    _endDate = endDate;
    
    [self ReqWorkoutList];
}

//DateSelect Delegate
- (void) setDate:(NSString *)date date2:(NSString *)date2{
    _lblDate.text = date2;
    searchdate = date;
    
    //[self ReqWorkoutList];
    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [self ReqWorkoutList];
    } else {
        [self ReqExportWorkoutList];
    }
}

- (void)updateNoLocationMapAppearanceByState:(MKCoordinateSpan)span {
    noLocation = CLLocationCoordinate2DMake([Global.g_user.user_latitude doubleValue], [Global.g_user.user_longitude  doubleValue]);
    [_mvMap setCenterCoordinate:noLocation];
    MKCoordinateRegion region;
    region = MKCoordinateRegionMake(noLocation, span);
    MKCoordinateRegion adjustedRegion = [_mvMap regionThatFits:region];
    [_mvMap setRegion:adjustedRegion animated:YES];
}

- (MKCoordinateSpan)spanByStatus:(CLAuthorizationStatus)status {
    return status == kCLAuthorizationStatusDenied ? MKCoordinateSpanMake(150, 150) : MKCoordinateSpanMake(3, 3);
}

#pragma mark - UITapGestureRecognizerDelegate

- (IBAction)handleGestureMap:(UITapGestureRecognizer *)recognizer {
//    CGPoint point = [recognizer locationInView:_mvMap];
//    CLLocationCoordinate2D tapPoint = [_mvMap convertPoint:point toCoordinateFromView:self.view];
//    
//    MKPointAnnotation *ptAnno = [[MKPointAnnotation alloc] init];
//    ptAnno.coordinate = tapPoint;
//    UIImage *img = [UIImage imageNamed:@"ic_mark1.png"];
//    [[_mvMap viewForAnnotation:ptAnno] setImage:img];
//
//    [_mvMap addAnnotation:ptAnno];
    workout_uid = @"";
    [self.vwPopup setHidden:YES];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    curLocation = userLocation.location;
//        float latitude = curLocation.coordinate.latitude;
//        float longitude = curLocation.coordinate.longitude;
    
    //[_mvMap setCenterCoordinate:curLocation.coordinate animated:YES];
    m_span = _mvMap.region.span;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    curLocation = [[CLLocation alloc] initWithLatitude:_mvMap.centerCoordinate.latitude
                                             longitude:_mvMap.centerCoordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    MKCoordinateSpan span = [self spanByStatus:status];
    [self updateNoLocationMapAppearanceByState:span];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    MKAnnotationView *pinView = nil;
    NSString *uniqueImageName = nil;
    
    if(annotation != mapView.userLocation) {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];

        int index = [[annotation title] intValue];
        if (index < 0){
            uniqueImageName = @"ic_me.png";
            pinView.image = [UIImage imageNamed:@"ic_me.png"];    //as suggested by Squatch
            return pinView;
        }
        

        NSDictionary *dic = _arrSportList[index];
        
        NSArray *sports = [[NSArray alloc] initWithObjects:[dic objectForKey:API_RES_KEY_SPORT_UID], nil];
        int sport_uid = [sports.firstObject intValue];
        pinView.canShowCallout = NO;
        pinView.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];    //as suggested by Squatch
        
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        if ( [level isEqual:[NSNull null]] )  { //individual
            uniqueImageName = arrSportImg[sport_uid - 1];
            pinView.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
        } else if ([level isEqualToString:@"1"]) { //gym
            uniqueImageName = arrSportBlueImg[sport_uid - 1];
            pinView.image = [UIImage imageNamed:arrSportBlueImg[sport_uid - 1]];
        } else if ([level isEqualToString:@"2"]) { //pro
            uniqueImageName = arrSportYellowImg[sport_uid - 1];
            pinView.image = [UIImage imageNamed:arrSportYellowImg[sport_uid - 1]];
        } else if ([level isEqualToString:@"3"]) { //trainer
            uniqueImageName = arrSportBlueImg[sport_uid - 1];
            pinView.image = [UIImage imageNamed:arrSportBlueImg[sport_uid - 1]];
        }
        
//        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
//        if ( [level isEqual:[NSNull null]] )  { //individual
//            pinView.image = [UIImage imageNamed:arrSportImg[sport_uid - 1]];
//        } else if ([level isEqualToString:@"1"]) { //gym
//            pinView.image = [UIImage imageNamed:arrSportBlueImg[sport_uid - 1]];
//        } else if ([level isEqualToString:@"2"]) { //pro
//            pinView.image = [UIImage imageNamed:arrSportYellowImg[sport_uid - 1]];
//        } else if ([level isEqualToString:@"3"]) { //trainer
//            pinView.image = [UIImage imageNamed:arrSportBlueImg[sport_uid - 1]];
//        }
//        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        if ([annotation isKindOfClass:CCHMapClusterAnnotation.class]) {
            static NSString *identifier = @"clusterAnnotation";
            
            ClusterAnnotationView *clusterAnnotationView = (ClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
            if (clusterAnnotationView) {
                clusterAnnotationView.annotation = annotation;
            } else {
                clusterAnnotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
                clusterAnnotationView.canShowCallout = YES;
            }
            clusterAnnotationView.uniqueImageName = uniqueImageName;
            clusterAnnotationView.clusterImageName = @"icon_cluster_white";
            
            CCHMapClusterAnnotation *clusterAnnotation = (CCHMapClusterAnnotation *)annotation;
            clusterAnnotationView.count = clusterAnnotation.annotations.count;
            clusterAnnotationView.blue = NO;
            clusterAnnotationView.uniqueLocation = clusterAnnotation.isUniqueLocation;
            pinView = clusterAnnotationView;
        }
        pinView.canShowCallout = NO;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        if (@available(iOS 11.0, *)) {} else {
            if ([Global.g_user.user_login isEqualToString:@"1"]) {
                static NSString *defaultPinID = @"com.invasivecode1.pin";
                pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
                if ( pinView == nil )
                    pinView = [[MKAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:defaultPinID];

                pinView.canShowCallout = YES;
                pinView.image = [UIImage imageNamed:@"ic_me.png"];    //as suggested by Squatch
                pinView.enabled = NO;
                pinView.userInteractionEnabled = NO;
            }
        }
    }
    return pinView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
     [mapView deselectAnnotation:view.annotation animated:YES];
    
    if ([view.annotation isKindOfClass:CCHMapClusterAnnotation.class]) {
        CCHMapClusterAnnotation *clusterAnnotation = (CCHMapClusterAnnotation*)view.annotation;
        if (clusterAnnotation.annotations.allObjects.count > 1) {
            NSLog(@"---> Cluster with group did tap...");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            NSArray *sportList = [self filteredWorkoutsByClusterAnnotation:clusterAnnotation.annotations.allObjects];
            
            MapClusterListViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(MapClusterListViewController.class)];
            vc.arrSportList = sportList;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    
    if([view.annotation isKindOfClass:[MKUserLocation class]]) {
        NSString *address_uid = [Preference getString:PREFCONST_ADDRESS_UID default:nil];
        if ([Global.g_user.user_login isEqualToString:@"1"] ) {

            double lat = view.annotation.coordinate.latitude;
            double lng = view.annotation.coordinate.longitude;

            //현재 얻은 위치와 유저위치가 같으면 리턴
            double curlat = [Global.g_user.user_latitude doubleValue];
            double curlng = [Global.g_user.user_longitude doubleValue];

            if ([address_uid isEqualToString:@""]) {
                [self UpdateMePoss:lat longtigude:lng];
            } else {

                if ( fabs(lat - curlat) < 0.00000001 && fabs(lng - curlng) < 0.00000001) {

                } else {
                    [self showChangeDig:lat longtigude:lng];
                }

            }
        }
        return;
    }
    
    int index = view.annotation.title.intValue;
    if (index < 0) {
        if (@available(iOS 11.0, *)) {
            index = view.clusterAnnotationView.annotation.title.intValue;
        } else {
            return;
        }
    }
        //return;
    
    NSDictionary *dic = _arrSportList[index];
//    if ([Global.g_user.user_login isEqualToString:@"1"]) {
        [_vwPopup setHidden:NO];
    
        [self showPlayerInfo:dic];
//    } else {
//        BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
//        vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
//        [self.vcParent.navigationController pushViewController:vc animated:YES];
//    }
    
}

//-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    MKAnnotationView *ulv = [mapView viewForAnnotation:mapView.userLocation];
//    ulv.hidden = YES;
//}

#pragma mark - CCHMapClusterControllerDelegate

- (void)mapClusterController:(CCHMapClusterController *)mapClusterController willReuseMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation {
    ClusterAnnotationView *clusterAnnotationView = (ClusterAnnotationView *)[self.mvMap viewForAnnotation:mapClusterAnnotation];
    clusterAnnotationView.count = mapClusterAnnotation.annotations.count;
    clusterAnnotationView.uniqueLocation = mapClusterAnnotation.isUniqueLocation;
}

- (NSString *)mapClusterController:(CCHMapClusterController *)mapClusterController titleForMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
    NSUInteger numAnnotations = mapClusterAnnotation.annotations.count;
    NSString *unit = numAnnotations > 1 ? @"annotations" : @"annotation";
    return [NSString stringWithFormat:@"%tu %@", numAnnotations, unit];
}

#pragma mark - CLLocationManagerDelegate

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    curLocation = [locations lastObject];
//    _mvMap.centerCoordinate = curLocation.coordinate;
//}

#pragma mark - user defined functions
-(void)OhterPlayPosSet{
    // Remove all current items from the map
    [self.mapClusterController removeAnnotations:self.mapClusterController.annotations.allObjects withCompletionHandler:NULL];
    for (id<MKOverlay> overlay in self.mvMap.overlays) {
        [self.mvMap removeOverlay:overlay];
    }
    
    NSMutableArray *annotations = [NSMutableArray new];
    for (long i = _arrSportList.count - 1; i >= 0 ; i--) {
        NSDictionary *dic = _arrSportList[i];
        
        NSString *latitude = [dic objectForKey:API_RES_KEY_LATITUDE] ;
        NSString *longitude = [dic objectForKey:API_RES_KEY_LONGITUDE] ;
        CLLocationCoordinate2D tapPoint = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        MKPointAnnotation *ptAnno = [[MKPointAnnotation alloc] init];
        ptAnno.coordinate = tapPoint;
        NSArray *sports = [[NSArray alloc] initWithObjects:[dic objectForKey:API_RES_KEY_SPORT_UID], nil];
        int sport_uid = [sports.firstObject intValue];
        //int sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] intValue];
        ptAnno.title = [NSString stringWithFormat:@"%ld", i ];
        
        NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
        if ( [level isEqual:[NSNull null]] )  { //individual
            [[_mvMap viewForAnnotation:ptAnno] setImage:[UIImage imageNamed:arrSportImg[sport_uid - 1]]];
        } else if ([level isEqualToString:@"1"]) { //gym
            [[_mvMap viewForAnnotation:ptAnno] setImage:[UIImage imageNamed:arrSportBlueImg[sport_uid - 1]]];
        } else if ([level isEqualToString:@"2"]) { //pro
            [[_mvMap viewForAnnotation:ptAnno] setImage:[UIImage imageNamed:arrSportYellowImg[sport_uid - 1]]];
            
        } else if ([level isEqualToString:@"3"]) { //trainer
            [[_mvMap viewForAnnotation:ptAnno] setImage:[UIImage imageNamed:arrSportBlueImg[sport_uid - 1]]];
        }
        if (ptAnno) {
            [annotations addObject:ptAnno];
        }
//        [_mvMap addAnnotation:ptAnno];
    }
    if (annotations.count > 0) {
        [self.mapClusterController addAnnotations:annotations withCompletionHandler:NULL];
    }
}

-(void)showPlayerInfo:(NSDictionary *)dic{
    NSString *level = [[dic objectForKey:API_RES_KEY_LEVEL] stringValue];
    //NSInteger sport_uid = [[dic objectForKey:API_RES_KEY_SPORT_UID] integerValue];
    NSString *title = @"";
    NSString *first_name = @"";
    NSString *last_name = @"";
    NSInteger date = 0;
    NSString *amount = @"";
    NSString *location = @"";
    NSString *post_type = @"";
    
    NSArray *sports = [[NSArray alloc] initWithObjects:[dic objectForKey:API_RES_KEY_SPORT_UID], nil];
    int sport_uid = [sports.firstObject intValue];
    
    workout_uid = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    
    if (![[dic objectForKey:API_RES_KEY_TITLE] isEqual:[NSNull null]]) {
        title = [dic objectForKey:API_RES_KEY_TITLE];
    }
    
    post_type = [[dic objectForKey:API_RES_KEY_POST_TYPE] stringValue];
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
    
    if (![[dic objectForKey:API_RES_KEY_START_TIME] isEqual:[NSNull null]]) {
        date = [[dic objectForKey:API_RES_KEY_START_TIME] intValue];
    }
    
    if (![[dic objectForKey:API_RES_KEY_AMOUNT] isEqual:[NSNull null]]) {
        amount = [dic objectForKey:API_RES_KEY_AMOUNT];
    }
    
    if (![[dic objectForKey:API_RES_KEY_USER_LOCATION] isEqual:[NSNull null]]) {
        location = [dic objectForKey:API_RES_KEY_USER_LOCATION];
    }
    
    if ( [level isEqual:[NSNull null]] )  { //individual
        _lblLevel.text = @"INDIVIDUAL";
    } else if ([level isEqualToString:@"1"]) { //gym
        _lblLevel.text = @"GYM";
    } else if ([level isEqualToString:@"2"]) { //pro
        _lblLevel.text = @"PRO";
        
    } else if ([level isEqualToString:@"3"]) { //trainer
        _lblLevel.text = @"TRAINER";
    }
    
    //profile
    if ([post_type isEqualToString:@"1"]) {
        if ([[dic objectForKey:API_RES_KEY_USR_PROFILE] isEqual:[NSNull null]]) {
            _icProfile.image = [UIImage imageNamed:@"ic_profile_black"];
        } else {
            NSString *url = [dic objectForKey:API_RES_KEY_USR_PROFILE];
            [_icProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
        }

    } else {
        if ([[dic objectForKey:API_RES_KEY_EXPORT_PROFILE] isEqual:[NSNull null]]) {
            _icProfile.image = [UIImage imageNamed:@"ic_profile_black"];
        } else {
            NSString *url = [dic objectForKey:API_RES_KEY_EXPORT_PROFILE];
            [_icProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
        }
    }
    
    _ivSport.image = [UIImage imageNamed:arrSportImg1[sport_uid - 1]];
    _lblNickName.text = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    _lblDistance.text = title;
    
    if ((date * 15) / 60 > 12) {
        _lbldate.text = [NSString stringWithFormat:@"%02ld:%02ld pm", (date * 15) / 60 - 12 , (date * 15) % 60];
    } else {
        _lbldate.text = [NSString stringWithFormat:@"%02ld:%02ld am", (date * 15) / 60 , (date * 15) % 60];
    }

    
    _lblAmount.text = [NSString stringWithFormat:@"$%@", amount];
//    _lblLocation.text = location;
    
    if ( [level isEqual:[NSNull null]] )  { //individual
        _vwSportBG.backgroundColor = [UIColor whiteColor];
        _lblNickName.textColor = [UIColor whiteColor];
        _lblLevel.textColor = [UIColor blackColor];
    } else if ([level isEqualToString:@"1"]) { //gym
        _vwSportBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblNickName.textColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblLevel.textColor = [UIColor whiteColor];
    } else if ([level isEqualToString:@"2"]) { //pro
        _vwSportBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
        _lblNickName.textColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
        _lblLevel.textColor = [UIColor blackColor];
    } else if ([level isEqualToString:@"3"]) { //trainer
        _vwSportBG.backgroundColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblNickName.textColor = [UIColor colorWithRed:(9/255.f) green:(156/255.f) blue:(242/255.f) alpha:1.0];
        _lblLevel.textColor = [UIColor whiteColor];
    }
}

-(void)UpdateMePoss:(double)lat longtigude:(double)lnd{
    //위치를 옮기기전에 이전 위치자료를 삭제하여야 한다.
    CLLocationCoordinate2D tapPoint = CLLocationCoordinate2DMake([Global.g_user.user_latitude doubleValue], [Global.g_user.user_longitude doubleValue]);
    MKPointAnnotation *ptAnno = [[MKPointAnnotation alloc] init];
    ptAnno.coordinate = tapPoint;
    ptAnno.title = @"-1";
    
    [_mvMap removeAnnotation:ptAnno];
    
    Global.g_user.user_latitude = [NSString stringWithFormat:@"%f", lat];
    Global.g_user.user_longitude = [NSString stringWithFormat:@"%f", lnd];
    
    [_mvMap setCenterCoordinate:tapPoint];
    
    [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
    [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];
    
    //all delete
    NSInteger toRemoveCount = _mvMap.annotations.count;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
    for (id annotation in _mvMap.annotations)
        if (annotation != _mvMap.userLocation)
            [toRemove addObject:annotation];
    [_mvMap removeAnnotations:toRemove];
    [_mvMap reloadInputViews];
    
    //add
    if (@available(iOS 11.0, *)) {
        [self setMyPosSetting];
    }
    [self OhterPlayPosSet];

}

- (void)showChangeDig:(double)lat longtigude:(double)lnd{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Update Location"
                                 message:@"Do you want to change your location?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   [alert dismissViewControllerAnimated:NO completion:Nil];
                               }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [alert dismissViewControllerAnimated:NO completion:Nil];
                                    [self UpdateAddress:lat longtigude:lnd];
                                }];
    [alert addAction:noButton];
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - click events

- (IBAction)onClickBookNow:(id)sender {
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = workout_uid;
    [self.vcParent.navigationController pushViewController:vc animated:YES];

}

//filter click
- (IBAction)onClickFilter:(id)sender {
    FilterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FilterViewController"];
    vc.delegate = self;
    vc.level_filter = _level_filter;
    vc.sport_filter = _sport_filter;
    vc.cate_filter = _cate_filter;
    vc.distance_limit = _distance_limit;
    vc.startDate = _startDate;
    vc.endDate = _endDate;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onClickDate:(id)sender {
    
    DateSelectDialog *dlgDate = [[DateSelectDialog alloc] initWithNibName:@"DateSelectDialog" bundle:nil];
    dlgDate.providesPresentationContextTransitionStyle = YES;
    dlgDate.definesPresentationContext = YES;
    [dlgDate setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDate.delegate = self;
    
    [self presentViewController:dlgDate animated:NO completion:nil];
    
}

#pragma mark - Network

-(void)ReqWorkoutList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, @"list_workout"];
    
    NSNumber *start = [NSNumber numberWithDouble:self.startDate];
    NSNumber *end = [NSNumber numberWithDouble:self.endDate];
    
    NSDictionary *params = @{
                             API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude,
                             API_REQ_KEY_SORT_TYPE          :   @"distance",
                             API_REQ_KEY_LEVEL_FILTER       :   _level_filter,
                             API_REQ_KEY_SPORTS_FILTER      :   _sport_filter,
                             API_REQ_KEY_CATEGORIES_FILTER  :   _cate_filter,
                             API_REQ_KEY_DISTANCE_limit     :   _distance_limit,
                             API_REQ_KEY_IS_MAP             :   @"1",
                             //API_REQ_KEY_TARGET_DATE        :   searchdate,
                             API_REQ_KEY_START_DATE         :   start ?: 0,
                             API_REQ_KEY_END_DATE           :   end ?: 0,
                             };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            if (_arrSportList.count > 0) {
                [_arrSportList removeAllObjects];
                
                NSInteger toRemoveCount = _mvMap.annotations.count;
                NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
                for (id annotation in _mvMap.annotations)
                    if (annotation != _mvMap.userLocation)
                        [toRemove addObject:annotation];
                [_mvMap removeAnnotations:toRemove];
                [_mvMap reloadInputViews];
            }
            
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            [_arrSportList addObjectsFromArray:arr];
            
            [self OhterPlayPosSet];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

//-(void)ReqWorkoutList{
//
//    [SharedAppDelegate showLoading];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//
//    NSDictionary *params = @{
//                             API_RES_KEY_TYPE               :   API_TYPE_LIST_WORKOUT,
//                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%d", Global.g_user.user_uid],
//                             API_REQ_KEY_USER_LATITUDE      :   Global.g_user.user_latitude,
//                             API_REQ_KEY_USER_LONGITUDE     :   Global.g_user.user_longitude,
//                             API_REQ_KEY_SORT_TYPE          :   @"distance",
//                             API_REQ_KEY_LEVEL_FILTER       :   _level_filter,
//                             API_REQ_KEY_SPORTS_FILTER      :   _sport_filter,
//                             API_REQ_KEY_CATEGORIES_FILTER  :   _cate_filter,
//                             API_REQ_KEY_DISTANCE_limit     :   _distance_limit,
//                             API_REQ_KEY_IS_MAP             :   @"1",
//                             API_REQ_KEY_TARGET_DATE        :   searchdate,
//                             };
//
//    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
//        NSLog(@"JSON: %@", respObject);
//        NSError* error;
//        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
//                                                                       options:kNilOptions
//                                                                         error:&error];
//        [SharedAppDelegate closeLoading];
//
//        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
//        if (res_code == RESULT_CODE_SUCCESS) {
//
//            if (_arrSportList.count > 0) {
//                [_arrSportList removeAllObjects];
//
//                NSInteger toRemoveCount = _mvMap.annotations.count;
//                NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
//                for (id annotation in _mvMap.annotations)
//                    if (annotation != _mvMap.userLocation)
//                        [toRemove addObject:annotation];
//                [_mvMap removeAnnotations:toRemove];
//                [_mvMap reloadInputViews];
//            }
//
//            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
//            [_arrSportList addObjectsFromArray:arr];
//
//            [self OhterPlayPosSet];
//        }  else if(res_code == RESULT_ERROR_PASSWORD){
//            [Commons showToast:@"The password is incorrect."];
//
//        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
//            [Commons showToast:@"User does not exist."];
//
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error: %@", error);
//        [SharedAppDelegate closeLoading];
//    }];
//}

-(void)ReqExportWorkoutList{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_EXPORT_LIST_WORKOUT];
    
    NSDictionary *params = @{
                             API_REQ_KEY_EXPERT_UID         :   [NSString stringWithFormat:@"%d", Global.g_expert.export_uid],
                             //API_REQ_KEY_TARGET_DATE        :   searchdate,
                             };
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            if (_arrSportList.count > 0) {
                [_arrSportList removeAllObjects];
                
                NSInteger toRemoveCount = _mvMap.annotations.count;
                NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
                for (id annotation in _mvMap.annotations)
                    if (annotation != _mvMap.userLocation)
                        [toRemove addObject:annotation];
                [_mvMap removeAnnotations:toRemove];
                [_mvMap reloadInputViews];
            }
            
            NSArray *arr  = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            [_arrSportList addObjectsFromArray:arr];

            [self OhterPlayPosSet];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

-(void)UpdateAddress:(double)lat longtigude:(double)lnd{
    
    //위치를 옮기기전에 이전 위치자료를 삭제하여야 한다.
    CLLocationCoordinate2D tapPoint = CLLocationCoordinate2DMake([Global.g_user.user_latitude doubleValue], [Global.g_user.user_longitude doubleValue]);
    MKPointAnnotation *ptAnno = [[MKPointAnnotation alloc] init];
    ptAnno.coordinate = tapPoint;
    ptAnno.title = @"-1";
    
    [_mvMap removeAnnotation:ptAnno];
    
    NSString *address_uid = [Preference getString:PREFCONST_ADDRESS_UID default:nil];
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_UPDATE_ADDRESS,
                             API_REQ_KEY_USER_UID           :   [NSString stringWithFormat:@"%d", Global.g_user.user_uid],
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", lat],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", lnd],
                             API_REQ_KEY_ADDRESS_UID        :   address_uid,
                             };
    
    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id respObject) {
        NSLog(@"JSON: %@", respObject);
        NSError* error;
        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
                                                                       options:kNilOptions
                                                                         error:&error];
        [SharedAppDelegate closeLoading];
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            
            Global.g_user.user_latitude = [NSString stringWithFormat:@"%f", lat];
            Global.g_user.user_longitude = [NSString stringWithFormat:@"%f", lnd];

            [Preference setString:PREFCONST_LATITUDE value:Global.g_user.user_latitude];
            [Preference setString:PREFCONST_LONGTITUDE value:Global.g_user.user_longitude];

            //all delete
            NSInteger toRemoveCount = _mvMap.annotations.count;
            NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
            for (id annotation in _mvMap.annotations)
                if (annotation != _mvMap.userLocation)
                    [toRemove addObject:annotation];
            [_mvMap removeAnnotations:toRemove];
            [_mvMap reloadInputViews];

            //add
            if (@available(iOS 11.0, *)) {
                [self setMyPosSetting];
            }
            [self OhterPlayPosSet];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //CLLocation *currentLocation = newLocation;
    
    if (![[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude] isEqualToString: Global.g_user.user_longitude ] && ![[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude] isEqualToString: Global.g_user.user_latitude]) {
        Global.g_user.user_latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        Global.g_user.user_longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];

        [self UpdateMePoss:newLocation.coordinate.latitude longtigude:newLocation.coordinate.longitude];
    }
    
}

#pragma mark - Help Methods

- (NSArray*)filteredWorkoutsByClusterAnnotation:(NSArray*)clusterAnnotations {
    NSMutableArray *filteredArray = [NSMutableArray array];
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:clusterAnnotations];
    for (NSInteger i = 0; i < _arrSportList.count; i++) {
        if (annotations.count == 0) {
            break;
        }
        NSDictionary *workoutDict = _arrSportList[i];
        NSString *workoutLatitude = [workoutDict objectForKey:API_RES_KEY_LATITUDE];
        NSString *workoutLongitude = [workoutDict objectForKey:API_RES_KEY_LONGITUDE];
        CLLocationCoordinate2D workoutCoordinate = CLLocationCoordinate2DMake([workoutLatitude doubleValue], [workoutLongitude doubleValue]);
        for (NSInteger j = 0; j < annotations.count; j++) {
            MKPointAnnotation *pointAnnotatoin = annotations[j];
            if (pointAnnotatoin.coordinate.latitude == workoutCoordinate.latitude && pointAnnotatoin.coordinate.longitude == workoutCoordinate.longitude) {
                [filteredArray addObject:[workoutDict mutableCopy]];
                [annotations removeObjectAtIndex:j];
                break;
            }
        }
    }
    return filteredArray;
}

@end
