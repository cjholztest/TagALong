//
//  ExpertUserProfileEditViewController.m
//  TagALong
//
//  Created by PJH on 9/7/17.
//  Copyright © 2017 PJH. All rights reserved.
//

#import "ExpertUserProfileEditViewController.h"
#import "UserProfilePlanTableViewCell.h"
#import "EditDialogViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BSImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "BookWorkoutViewController.h"

#define LEVEL_GYM       1
#define LEVEL_PRO       2
#define LEVEL_TRAINER   3

#define IMAGE_MAX_SIZE 512
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define IS_IOS8_OR_ABOVE                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
static const NSInteger kMaxImageCnt = 1;
@interface ExpertUserProfileEditViewController () <UIImagePickerControllerDelegate, EditDialogViewControllerDelegate>{
    NSInteger nCurSelLevel;
    NSString *file_url;
    NSString *file_name;
    NSString *nickname ;
    NSString *phone ;
    NSString *location ;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *ivProfile;
@property (weak, nonatomic) IBOutlet UITableView *tvSchedule;
@property (strong, nonatomic) IBOutlet UILabel *lbLevel;
@property (strong, nonatomic) IBOutlet UIControl *vwGYM;
@property (strong, nonatomic) IBOutlet UIControl *vwPRO;
@property (strong, nonatomic) IBOutlet UIControl *vwTRAINER;
@property (strong, nonatomic) IBOutlet UILabel *lblArea;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) BSImagePickerController *imagePicker;
@property (nonatomic, strong) NSString *ProfileUrl;
@end

@implementation ExpertUserProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    file_name = @"";
    nickname = self.nickname;
    phone = self.phone;
    location = self.location;
    file_url = self.url;
    
    nCurSelLevel = [self.level intValue];
    [self setLevel];
    _lblArea.text = location;
    _lblPhone.text = phone;
    _lblTitle.text = nickname;
    
    _ivProfile.layer.cornerRadius = _ivProfile.bounds.size.width / 2;
    [_ivProfile sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];

    [self.tvSchedule registerNib:[UINib nibWithNibName:@"UserProfilePlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserProfilePlanTableViewCell"];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrSchedule.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"UserProfilePlanTableViewCell";
    UserProfilePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic  = self.arrSchedule[indexPath.row];
    
//    cell.lblTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (indexPath.row * 15 ) / 60, (indexPath.row * 15 ) % 60];
    cell.lblTime.text = [dic objectForKey:API_RES_KEY_START_TIME];
    
//    NSString *workout = [dic objectForKey:@"workout"];
//    
//    if ([workout isEqualToString:@"1"]) {
//        cell.vwBG.backgroundColor = [UIColor colorWithRed:(255/255.f) green:(210/255.f) blue:(0/255.f) alpha:1.0];
//    } else {
//        cell.vwBG.backgroundColor = [UIColor whiteColor];
//    }
    
    NSString *star = [dic objectForKey:@"star_mark"];
    if ([star isEqualToString:@"1"]) {
        [cell.ivStar setHidden:NO];
        NSString *title = [dic objectForKey:API_RES_KEY_TITLE];
        NSString *loc = [dic objectForKey:API_RES_KEY_USER_LOCATION];
        cell.lblTitle.text = [NSString stringWithFormat:@"%@\n%@", title, loc];
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
    
    NSDictionary *dic = _arrSchedule[indexPath.row];
    BookWorkoutViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BookWorkoutViewController"];
    vc.workout_id = [dic objectForKey:API_RES_KEY_WORKOUT_UID];
    vc.bProfile = true;
    [self.vcParent.navigationController pushViewController:vc animated:YES];

}

//EditDialogViewController Delegate
-(void)setContent:(NSString *)type msg:(NSString *)content{
    if ([type isEqualToString:@"area"]) {
        _lblArea.text = content;
    } else if ([type isEqualToString:@"phone"]) {
        _lblPhone.text = content;
    }
}

#pragma mark - user defined functions
-(void)setLevel{
    [_vwGYM setAlpha:1.0];
    [_vwPRO setAlpha:1.0];
    [_vwTRAINER setAlpha:1.0];
    
    if (nCurSelLevel == LEVEL_GYM) {
        [_vwGYM setAlpha:0.5];
        _lbLevel.text = @"GYM";
    } else if (nCurSelLevel == LEVEL_PRO) {
        [_vwPRO setAlpha:0.5];
        _lbLevel.text = @"PRO";
    } else if (nCurSelLevel == LEVEL_TRAINER) {
        [_vwTRAINER setAlpha:0.5];
        _lbLevel.text = @"TRAINER";
    }
}

-(void)showEditDialog:(NSString*)type msg:(NSString*)msg{
    EditDialogViewController *dlgDialog = [[EditDialogViewController alloc] initWithNibName:@"EditDialogViewController" bundle:nil];
    dlgDialog.providesPresentationContextTransitionStyle = YES;
    dlgDialog.definesPresentationContext = YES;
    [dlgDialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    dlgDialog.delegate = self;
    
    dlgDialog.type = type;
    dlgDialog.content = msg;
    [self presentViewController:dlgDialog animated:NO completion:nil];

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

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *imgData;
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
        UIImage *compressimage = [self compressForUpload:thumb scale:0.5];
        imgData = UIImageJPEGRepresentation(compressimage, 0.5);
        CGImageRelease(image);
        
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     
                                 }];
        
        [self uploadImage:thumb scale:0.5];
    }
    else
    {
        NSMutableArray *arrData = [NSMutableArray array];
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //UIImage *resizeImage = [Util imageWithImage:outputImage convertToWidth:self.ivImage.frame.size.width];
        UIImage *compressimage = [self compressForUpload:outputImage scale:0.5];
        imgData = UIImageJPEGRepresentation(compressimage, 0.5);
        
//        _ivProfile.image = [UIImage imageWithData:imgData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self uploadImage:outputImage scale:0.5];
    }
    
}

#pragma mark - click events
- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)onClickconfirm:(id)sender {
    [self ReqUpdateInfo];
}

//level
- (IBAction)onClickTraniner:(id)sender {
    nCurSelLevel = LEVEL_TRAINER;
    [self setLevel];
}

- (IBAction)onClickPro:(id)sender {
    nCurSelLevel = LEVEL_PRO;
    [self setLevel];
}

- (IBAction)onClickGym:(id)sender {
    nCurSelLevel = LEVEL_GYM;
    [self setLevel];
    
}

//지역편집
- (IBAction)onClickAreaEdit:(id)sender {
    [self showEditDialog:@"area" msg:_lblArea.text];
}

//전화번호 편집
- (IBAction)onClickPhoneEdit:(id)sender {
    [self showEditDialog:@"phone" msg:_lblPhone.text];
}

//////////

//프로필 사진추가
- (IBAction)onClickGetPhoto:(id)sender {
  
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
//             self.imagePicker.maximumNumberOfImages = kMaxImageCnt - self.arM_Photo.count;
             
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
                                             
                                             NSMutableArray *arrData = [NSMutableArray array];
                                             for( NSInteger i = 0; i < assets.count; i++ )
                                             {
                                                 ALAsset *asset = assets[i];
                                                 
                                                 ALAssetRepresentation *rep = [asset defaultRepresentation];
                                                 CGImageRef iref = [rep fullScreenImage];
                                                 if (iref)
                                                 {
                                                     NSData *imgData;
                                                     UIImage *image = [UIImage imageWithCGImage:iref];
                                                     UIImage *compressimage = [self compressForUpload:image scale:0.5];
                                                     imgData = UIImageJPEGRepresentation(compressimage, 0.5);
                                                     
                                                     [self uploadImage:image scale:0.5];
                                                 }
                                             }
                                             
                                         }];
         }
     }];
}

#pragma mark - Network
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
             
             //_ivProfile.image = [UIImage imageWithData:fileData];
             file_url = [responseObject objectForKey:API_RES_KEY_FILE_URL];
             [_ivProfile sd_setImageWithURL:[NSURL URLWithString:file_url] placeholderImage:[UIImage imageNamed:@"ic_profile_black"]];

             file_name = [responseObject objectForKey:API_RES_KEY_FILE_NAME];
              
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
    
    nickname = _lblTitle.text;
    phone = _lblPhone.text;
    location = _lblArea.text;
    
    CLLocationCoordinate2D code = [Commons geoCodeUsingAddress:location];
    double latitude = code.latitude;
    double longitude = code.longitude;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             API_RES_KEY_TYPE               :   API_TYPE_EXPERT_UPDATE_PROFILE,
                             API_REQ_KEY_EXPERT_UID         :   [NSString stringWithFormat:@"%d", Global.g_expert.export_uid],
                             API_REQ_KEY_EXPORT_NCK_NM      :   nickname,
                             API_RES_KEY_EXPORT_LAST_NAME   :   nickname,
                             API_REQ_KEY_EXPERT_PHONE       :    phone,
                             API_REQ_KEY_LEVEL              :    [NSString stringWithFormat:@"%ld", (long)nCurSelLevel],
                             API_REQ_KEY_USER_LOCATION      :    location,
                             API_REQ_KEY_USER_LATITUDE      :   [NSString stringWithFormat:@"%f", latitude],
                             API_REQ_KEY_USER_LONGITUDE     :   [NSString stringWithFormat:@"%f", longitude],
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
           
            NSMutableDictionary *dic_contents = [NSMutableDictionary dictionary];
            
            [dic_contents setObject:_lblArea.text forKey:@"address"];
            [dic_contents setObject:_lblPhone.text forKey:@"phone"];
            [dic_contents setObject:[NSString stringWithFormat:@"%ld", (long)nCurSelLevel] forKey:@"level"];
            [dic_contents setObject: file_url forKey:@"profile"];
            
            [self.delegate setEditDate:dic_contents];
            
            [self.navigationController popViewControllerAnimated:NO];
            
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
