//
//  ProUserEditProfileModel.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileModel.h"
#import "ProUserProfileMapper.h"
#import "ProUserProfile.h"
#import "PaymentClient+Customer.h"
#import "PaymentClient+CreditCard.h"

@interface ProUserEditProfileModel()

@property (nonatomic, weak) id <ProUserEditProfileModelOutput> output;

@end

@implementation ProUserEditProfileModel

- (instancetype)initWithOutput:(id<ProUserEditProfileModelOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserEditProfileModelInput

- (void)saveProfile:(ProUserProfile *)profile {
    [self updateProfile:profile];
}

- (UIImage *)compressedImageFrom:(UIImage *)original scale:(CGFloat)scale {
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

- (void)loadDataForBankCredentialsWithCompletion:(void (^)(NSString *))completion {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient expertPaymentDataWithCompletion:^(id responseObject, NSError *error) {
        
        BOOL isDataExists = [responseObject[@"exist"] boolValue];
        
        NSString *message = isDataExists ? @"update data" : @"no data";
        
        if (isDataExists) {
            [weakSelf.output bankDataDidLoad:message];
        }
        
        if (completion) {
            completion(message);
        }
        
    }];
}

- (void)loadDataForDebitWithCompletion:(void (^)(NSString *))completion {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient proUserDebitCardsWithCompletion:^(id responseObject, NSError *error) {
        
        NSArray *cards = responseObject;
        NSString *result = @"no debit";
        
        if (cards.count != 0) {
            NSDictionary *card = cards.firstObject;
            result = [NSString stringWithFormat:@"●●●● %@", card[@"last4"]];
            [weakSelf.output debitCardDataDidLoad:result];
        }
        if (completion) {
            completion(result);
        }
    }];
}

- (void)loadDataForCreditWithCompletion:(void (^)(NSString *))completion {
    
    __weak typeof(self)weakSelf = self;
    
    [PaymentClient proUserCreditCardsWithCompletion:^(id responseObject, NSError *error) {
        
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

- (void)updateProfile:(ProUserProfile*)profile {
    
    __weak typeof(self)weakSelf = self;
    
    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TEST_SERVER_URL, API_TYPE_EXPERT_UPDATE_PROFILE];
    
    NSDictionary *params = [ProUserProfileMapper jsonFromProUserProfile:profile];
    
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

@end
