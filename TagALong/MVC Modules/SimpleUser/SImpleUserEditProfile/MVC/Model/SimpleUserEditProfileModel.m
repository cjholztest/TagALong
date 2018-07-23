//
//  SImpleUserEditProfileModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileModel.h"
#import "PaymentClient+CreditCard.h"
#import "SimpleUserProfileMapper.h"

@interface SimpleUserEditProfileModel()

@property (nonatomic, weak) id <SimpleUserEditProfileModelOutput> output;

@end

@implementation SimpleUserEditProfileModel

- (instancetype)initWithOutput:(id<SimpleUserEditProfileModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SimpleUserEditProfileModelInput

- (void)loadDataForCreditWithCompletion:(void (^)(NSString *))completion {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        NSString *result = @"no credit";
        
        if (cards.count != 0) {
            NSDictionary *card = cards.firstObject;
            result = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
            [weakSelf.output creditCardDataDidLoad:result];
        }
        if (completion) {
            completion(result);
        }
    }];
}

- (void)loadCrediCards {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient listOfCrediCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        NSString *cardInfo = @"no credit card";
        
        if (cards.count != 0) {
            NSDictionary *card = cards.firstObject;
            cardInfo = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
        }
        
        [weakSelf.output creditCardsDidLoadSuccess:(error == nil) cardInfo:cardInfo];        
    }];
}

- (void)updateAreaRadius:(BOOL)isEnabled miles:(NSString*)miles {
    
    NSNumber *limit = isEnabled ? @(miles.integerValue) : @(-1);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_PROFILE_UPDATE];
    
    NSDictionary *params = @{ @"pro_search_radius" : limit };
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        BOOL isSuccess = NO;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            isSuccess = YES;
            [self.output areaRadiusDidUpdateSuccess:isSuccess message:@"Changes did save successfully"];
        }  else if(res_code == RESULT_ERROR_PASSWORD){
        
            
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST){
            
        }  else if(res_code == RESULT_ERROR_PARAMETER){
            
        }
        [self.output areaRadiusDidUpdateSuccess:isSuccess message:@"Undefined error. Please, try again or later"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [self.output areaRadiusDidUpdateSuccess:NO message:error.localizedDescription];
    }];
}

- (void)saveProfile:(SimpleUserProfile*)profile {
    [self updateProfile:profile];
}

- (UIImage *)compressedImageFrom:(UIImage*)original scale:(CGFloat)scale {
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

- (void)uploadImage:(UIImage*)image scale:(float)scale {
    if (image == nil)
        return;
    
    __weak typeof(self)weakSelf = self;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_FILE_UPLOAD];
    
    NSData *fileData = image? UIImageJPEGRepresentation(image, scale):nil;
    
    [manager POST:url parameters:nil  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:API_REQ_KEY_UPFILE
                                    fileName:@"img.png"
                                    mimeType:@"multipart/form-data"];
        }
    }
         progress: nil success:^(NSURLSessionTask *task, id responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
             
             [SharedAppDelegate closeLoading];
             
             int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
             if (res_code == RESULT_CODE_SUCCESS) {
                 
                 NSString *photoUrl = [responseObject objectForKey:API_RES_KEY_FILE_URL];
                 [weakSelf.output photoDidLoadWithUrl:photoUrl];
                 
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

- (void)updateProfile:(SimpleUserProfile*)profile {
    
    __weak typeof(self)weakSelf = self;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_USER_PROFILE_UPDATE];
    
    NSDictionary *params = [SimpleUserProfileMapper jsonFromSimpleUserProfile:profile];
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [SharedAppDelegate closeLoading];
        
        BOOL success = NO;
        NSString *errorMessage = nil;
        
        int res_code = [[responseObject objectForKey:API_RES_KEY_RESULT_CODE] intValue];
        if (res_code == RESULT_CODE_SUCCESS) {
            success = YES;
        }  else if(res_code == RESULT_ERROR_PASSWORD) {
            errorMessage = @"The password is incorrect.";
        }  else if(res_code == RESULT_ERROR_USER_NO_EXIST) {
            errorMessage = @"User does not exist.";
        }  else if(res_code == RESULT_ERROR_PARAMETER) {
            errorMessage = @"The request parameters are incorrect.";
        }
        
        [weakSelf.output profileDidUpdate:success errorMessage:errorMessage];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SharedAppDelegate closeLoading];
        [weakSelf.output profileDidUpdate:NO errorMessage:@"Failed to communicate with the server"];
    }];
}


- (void)checkCreditsWithCompletion:(void(^)(BOOL isCreditCradExists))completion {
    
}

#pragma mark - Private

@end
