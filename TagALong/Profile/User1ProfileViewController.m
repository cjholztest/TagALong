//
//  User1ProfileViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "User1ProfileViewController.h"
#import "Daysquare.h"
#import "BookWorkoutViewController.h"
#import "UserProfilePlanTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "BSImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "BookWorkoutViewController.h"

@interface User1ProfileViewController ()<UIImagePickerControllerDelegate>{
    NSString *file_url;
    NSString *file_name;
    NSString *nickname;
    NSString *phone;
    NSData *imgData;
}

@property (weak, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UIView *vwLevel;

@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tvSchedule;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lctvScheduleHeight;

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) BSImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIView *vwNoData;
@property (nonatomic, strong) NSMutableArray *arM_Photo;
@property (nonatomic, strong) NSMutableArray *arrWorkout;
@end

static const NSInteger kMaxImageCnt = 1;
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define IS_IOS8_OR_ABOVE                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation User1ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calendarViewDidChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
    
    NSString *seldate = [formatter stringFromDate:self.calendarView.selectedDate];
    [_tvSchedule setContentOffset:CGPointMake(0, 0) animated:YES];
    [self ReqGetUserProfile:seldate];
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrWorkout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"UserProfilePlanTableViewCell";
    UserProfilePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic  = _arrWorkout[indexPath.row];
    
//    cell.lblTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (indexPath.row * 15 ) / 60, (indexPath.row * 15 ) % 60];
    cell.lblTime.text = [dic objectForKey:API_RES_KEY_START_TIME];
    
//    NSString *workout = [dic objectForKey:@"workout"];
//    
//    if ([workout isEqualToString:@"1"]) {
//        cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
//    } else {
//        cell.vwBG.backgroundColor = [UIColor whiteColor];
//    }

    cell.vwBG.backgroundColor = [UIColor whiteColor];
    
    NSString *star = [dic objectForKey:@"star_mark"];
    if ([star isEqualToString:@"1"]) {
        [cell.ivStar setHidden:NO];
        NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
        NSString *location = [dic objectForKey:API_RES_KEY_USER_LOCATION];
        cell.lblTitle.text = [NSString stringWithFormat:@"%@\n%@", title, location];
        cell.lblTitle.textAlignment = NSTextAlignmentLeft;
    } else {
        [cell.ivStar setHidden:YES];
        cell.lblTitle.text = @"";
        cell.lblTitle.textAlignment = NSTextAlignmentCenter;
    }
   
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = _arrWorkout[indexPath.row];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    vc.bProfile = true;
    [self.vcParent.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - user defined functions
-(void)initUI{
    _arrWorkout = [[NSMutableArray alloc]  init];
    _ivProfile.layer.cornerRadius = _ivProfile.bounds.size.width / 2;
    
//    [self initData];
    [_vwNoData setHidden:YES];
    //[self.calendarView setSingleRowMode:YES];
    //self.calendarView.singleRowMode = YES;
    
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.tvSchedule registerNib:[UINib nibWithNibName:@"UserProfilePlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserProfilePlanTableViewCell"];
    
    NSDate *curdate = [NSDate date];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateformat stringFromDate:curdate];
    //[self.calendarView jumpToDate:curdate];
    [self ReqGetUserProfile:today];
}

- (void)initData{
    for (int i = 0; i < 96 ; i++) {
        NSMutableDictionary *dics = [NSMutableDictionary dictionary];
        [dics setObject:@"" forKey:@"workout_uid"];
        [dics setObject:@"0" forKey:@"star_mark"];
        [dics setObject:@"" forKey:@"start_time"];
        [dics setObject:@"" forKey:@"duration"];
        [dics setObject:@"" forKey:@"title"];
        [dics setObject:@"0" forKey:@"workout"];
        [dics setObject:@"" forKey:@"location"];
        
        [_arrWorkout addObject:dics];
    }
}

-(void)setUserInfo:(NSDictionary*)dicInfo{
    NSString *first_name = @"";
    NSString *last_name = @"";
    if (![[dicInfo objectForKey:API_RES_KEY_USR_NCK_NM] isEqual:[NSNull null]]) {
        first_name = [dicInfo objectForKey:API_RES_KEY_USR_NCK_NM];
    }
    
    if (![[dicInfo objectForKey:API_RES_KEY_USER_LAST_NAME] isEqual:[NSNull null]]) {
        last_name = [dicInfo objectForKey:API_RES_KEY_USER_LAST_NAME];
    }
    
    nickname = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
    NSString *age = [dicInfo objectForKey:API_RES_KEY_USER_AGE];
    NSString *location = [dicInfo objectForKey:API_RES_KEY_USER_LOCATION];
    phone = [dicInfo objectForKey:API_RES_KEY_USR_PHONE];
    _lblAge.text = [NSString stringWithFormat:@"%@ years old   %@", age, location];
    
    _lblLevel.text = @"INDIVIDUAL";
    
    if ([[dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG] isEqual:[NSNull null]]) {
        _ivProfile.image = [UIImage imageNamed:@"ic_profile_black"];
    } else {
        NSString *url = [dicInfo objectForKey:API_RES_KEY_USER_PROFILE_IMG];
        [_ivProfile sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTitle" object:self userInfo:@{@"title": nickname}];

}

- (UIImage *)compressForUpload:(UIImage *)original scale:(CGFloat)scale
{
    // Calculate new size given scale factor.
    CGSize originalSize = original.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

- (IBAction)onClickProfile:(id)sender {
    
    NSString *myuid = [NSString stringWithFormat:@"%d", Global.g_user.user_uid];
    
    if (![myuid isEqualToString:self.user_id]) {
        return;
    }
    
    [OHActionSheet showSheetInView:self.view
                             title:nil
                 cancelButtonTitle:@"Cancel"
            destructiveButtonTitle:nil
                 otherButtonTitles:@[@"Photo shoot", @"Album"]
                        completion:^(OHActionSheet* sheet, NSInteger buttonIndex)
     {
         //         if( kMaxImageCnt <= self.arM_Photo.count )
         //         {
         //             NSString *str_Msg = [NSString stringWithFormat:@"최대 %ld장의 이미지 등록이 가능합니다", kMaxImageCnt];
         //             [self.navigationController.view makeToast:str_Msg withPosition:kPositionCenter];
         //             return;
         //         }
         
         
         if( buttonIndex == 0 )
         {
             UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
             imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
             imagePickerController.delegate = self;
             imagePickerController.allowsEditing = YES;
             
             if(IS_IOS8_OR_ABOVE)
             {
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     [self presentViewController:imagePickerController animated:YES completion:nil];
                 }];
             }
             else
             {
                 [self presentViewController:imagePickerController animated:YES completion:nil];
             }
         }
         else if( buttonIndex == 1 )
         {
             self.imagePicker = [[BSImagePickerController alloc] init];
             self.imagePicker.maximumNumberOfImages = kMaxImageCnt - self.arM_Photo.count;
             
             [self presentImagePickerController:self.imagePicker
                                       animated:YES
                                     completion:nil
                                         toggle:^(ALAsset *asset, BOOL select) {
                                             if(select)
                                             {
                                                 NSLog(@"Image selected");
                                             }
                                             else
                                             {
                                                 NSLog(@"Image deselected");
                                             }
                                         }
                                         cancel:^(NSArray *assets) {
                                             NSLog(@"User canceled...!");
                                             [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                                         }
                                         finish:^(NSArray *assets) {
                                             NSLog(@"User finished :)!");
                                             [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                                             
                                             //                                             NSMutableArray *arrData = [NSMutableArray array];
                                             for( NSInteger i = 0; i < assets.count; i++ )
                                             {
                                                 ALAsset *asset = assets[i];
                                                 
                                                 ALAssetRepresentation *rep = [asset defaultRepresentation];
                                                 CGImageRef iref = [rep fullScreenImage];
                                                 if (iref)
                                                 {
                                                     UIImage *image = [UIImage imageWithCGImage:iref];
                                                     UIImage *compressimage = [self compressForUpload:image scale:0.5];
                                                     imgData = UIImageJPEGRepresentation(image, 0.5);
                                                     [self.arM_Photo addObject:imgData];
                                                     
//                                                     _ivProfile.image = [UIImage imageWithData:imageData];
                                                     [self uploadImage:image scale:0.5];
                                                 }
                                             }
                                             
                                         }];
         }
     }];

}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
    {
        self.videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        //        UIImage *compressimage = [self compressForUpload:thumb scale:0.5];
        imgData = UIImageJPEGRepresentation(thumb, 0.5);
        CGImageRelease(image);
        
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     
                                 }];
        [self uploadImage:thumb scale:0.5];
    }
    else
    {
        //        NSMutableArray *arrData = [NSMutableArray array];
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //UIImage *resizeImage = [Util imageWithImage:outputImage convertToWidth:self.ivImage.frame.size.width];
        UIImage *compressimage = [self compressForUpload:outputImage scale:0.5];
        imgData = UIImageJPEGRepresentation(outputImage, 0.5);
        
//        _ivProfile.image = [UIImage imageWithData:imageData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self uploadImage:outputImage scale:0.5];
    }
}

#pragma mark - Network
-(void)ReqGetUserProfile:(NSString*)date{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_USER_GET_PROFILE,
                             API_REQ_KEY_USER_UID           :   self.user_id,
                             API_REQ_KEY_TARGET_DATE        :   date,
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
            
            [self setUserInfo:[responseObject objectForKey:API_RES_KEY_USER_INFO]];
            
            NSArray *arrData = [responseObject objectForKey:API_RES_KEY_WORKOUT_LIST];
            
            if (_arrWorkout.count > 0) {
                [_arrWorkout removeAllObjects];
            }
            
//            [self initData];
            
            for (int i = 0; i < arrData.count; i++) {
                NSDictionary *dic = arrData[i];
                NSInteger starttime = [[dic objectForKey:API_REQ_KEY_START_TIME] intValue];
                NSInteger duration = [[dic objectForKey:API_REQ_KEY_DURATION] intValue];
                
                for (int k = 0; k < duration; k++) {
                    //NSMutableDictionary *dic_workout = [_arrWorkout[starttime + k] mutableCopy];
                    NSMutableDictionary *dic_workout = [[NSMutableDictionary alloc] init];
                    
                    NSString *workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
                    NSString *star_mark = [dic objectForKey:API_RES_KEY_STAR_MARK];
                    NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
                    NSString *location = [dic objectForKey:API_RES_KEY_USER_LOCATION];
                    
                    [dic_workout setObject:workout_id forKey:API_RES_KEY_WORKOUT_UID];
                    [dic_workout setObject:star_mark forKey:API_RES_KEY_START_TIME];
                    if (k == 0) {
                        [dic_workout setObject:location forKey:API_RES_KEY_USER_LOCATION];
                        [dic_workout setObject:@"1" forKey:@"star_mark"];
                        [dic_workout setObject:title forKey:API_RES_KEY_TITLE];
                    } else {
                        [dic_workout setObject:@"" forKey:API_RES_KEY_USER_LOCATION];
                        [dic_workout setObject:@"0" forKey:@"star_mark"];
                        [dic_workout setObject:@"" forKey:API_RES_KEY_TITLE];
                    }
                    
                    if ((starttime * 15) / 60 > 12) {
                        [dic_workout setObject:[NSString stringWithFormat:@"%02ld:%02ld pm", ((starttime + k) * 15 ) / 60 - 12, ((starttime + k) * 15 ) % 60] forKey:API_RES_KEY_START_TIME];
                    } else {
                        [dic_workout setObject:[NSString stringWithFormat:@"%02ld:%02ld am", ((starttime + k) * 15 ) / 60, ((starttime + k) * 15 ) % 60] forKey:API_RES_KEY_START_TIME];
                    }

                    [dic_workout setObject:@"1" forKey:@"workout"];
                    
//                    [_arrWorkout removeObjectAtIndex:starttime + k];
//                    [_arrWorkout insertObject:dic_workout atIndex:starttime + k];
                    [_arrWorkout addObject:dic_workout];
                }
            }
            
            if (arrData.count > 0) {
                [_vwNoData setHidden:YES];
            } else {
                [_vwNoData setHidden:NO];
            }
            
            [_tvSchedule reloadData];
            
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

- (void)uploadImage:(UIImage*)image scale:(float)scale {
    if (image == nil)
        return;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params  = @{
                              API_REQ_KEY_TYPE             :   API_TYPE_FILE_UPLOAD,
                              };
    
    NSData *fileData = image? UIImageJPEGRepresentation(image, scale):nil;
    
    [manager POST:SERVER_URL parameters:params  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:API_REQ_KEY_UPFILE
                                    fileName:@"img.png"
                                    mimeType:@"multipart/form-data"];
        }
    }
         progress: nil success:^(NSURLSessionTask *task, id respObject) {
             
             NSLog(@"JSON: %@", respObject);
             NSError* error;
             NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
                                                                            options:kNilOptions
                                                                              error:&error];
             [SharedAppDelegate closeLoading];
             
             int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
             if (res_code == RESULT_CODE_SUCCESS) {
                 
//                 _ivProfile.image = [UIImage imageWithData:fileData];
                 file_url = [responseObject objectForKey:API_RES_KEY_FILE_URL];
                 [_ivProfile sd_setImageWithURL:[NSURL URLWithString:file_url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];
                 
                 file_name = [responseObject objectForKey:API_RES_KEY_FILE_NAME];
                 
                 [self ReqUpdateInfo];
             } else if (res_code == RESULT_ERROR_PARAMETER){
                 [Commons showToast:@"parameter error"];
             } else if (res_code == RESULT_ERROR_FILE_UPLOAD){
                 [Commons showToast:@"Failed file upload"];
             } else {
                 
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [SharedAppDelegate closeLoading];
             [Commons showToast:@"Failed to communicate with the server"];
         }];
}

-(void)ReqUpdateInfo{
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_USER_PROFILE_UPDATE,
                             API_REQ_KEY_USER_UID           :   self.user_id,
                             API_RES_KEY_USR_NCK_NM         :   nickname,
                             API_RES_KEY_USER_LAST_NAME     :   nickname,
                             API_RES_KEY_USR_PHONE          :    phone,
                             API_REQ_KEY_USER_PROFILE_IMG   :   file_name
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
            _ivProfile.image = [UIImage imageWithData:imgData];
            [Commons showToast:@"Your profile has changed"];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
            [Commons showToast:@"The password is incorrect."];
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            [Commons showToast:@"User does not exist."];
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            [Commons showToast:@"The request parameters are incorrect."];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}


@end
