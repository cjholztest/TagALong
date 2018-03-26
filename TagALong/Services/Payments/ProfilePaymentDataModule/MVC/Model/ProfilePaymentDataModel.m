//
//  ProfilePaymentDataModel.m
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentDataModel.h"
#import "ProfilePaymentCredentials.h"
#import "PaymentClient+Customer.h"

@interface ProfilePaymentDataModel ()

@property (nonatomic, assign) ProfilePaymentModeType modeType;
@property (nonatomic, strong) ProfilePaymentCredentials *credentials;

@end

@implementation ProfilePaymentDataModel

- (ProfilePaymentCredentials*)credentials {
    if (!_credentials) {
        _credentials = [ProfilePaymentCredentials new];
    }
    return _credentials;
}

- (void)updateValue:(id)value forType:(NSInteger)type {
    ProfilePaymentFieldType fieldType = type;
    switch (fieldType) {
        case ProfilePaymentFieldTypeFirstName:
            self.credentials.firstName = value;
            break;
        case ProfilePaymentFieldTypeLastName:
            self.credentials.lastName = value;
            break;
        case ProfilePaymentFieldTypeBirthday:
            [self.credentials updateBirthdayByDate:value];
            break;
        case ProfilePaymentFieldTypeAddress:
            self.credentials.address = value;
            break;
        case ProfilePaymentFieldTypeCity:
            self.credentials.city = value;
            break;
        case ProfilePaymentFieldTypeState:
            self.credentials.state = value;
            break;
        case ProfilePaymentFieldTypePostalCode:
            self.credentials.postalCode = [value integerValue];
            break;
        case ProfilePaymentFieldTypeSSNLast:
            self.credentials.ssnLast = value;
            break;
        case ProfilePaymentFieldTypePassword:
            self.credentials.password = value;
            break;
        default:
            break;
    }
    NSLog(@"%@", value);
}

- (void)setupMode:(ProfilePaymentModeType)mode {
    self.modeType = mode;
}

- (NSInteger)rowsCount {
    return 8;
}

- (BOOL)isRegistrationMode {
    return self.modeType == ProfilPaymentModeTypeRegistration;
}

- (BOOL)isPasswordContained {
    return self.credentials.password.length > 0;
}

- (BOOL)isEnteredCredentialsValid {
    BOOL isValid = YES;
    NSString *errorMessage = [self.credentials checkedCredentialsMessage];
    if (errorMessage) {
        isValid = NO;
        [self.output credentalsDidCheckWithError:errorMessage];
    }
    return isValid;
}

- (void)sendPaymentCredentials {
    
    NSDictionary *params = [self.credentials paramsCredentials];
    NSLog(@"sendPaymentCredentials");

    [PaymentClient registerExpertWithPaymentData:params completion:^(id responseObject, NSError *error) {
        BOOL isRegistrationSuccessed = [responseObject[@"status"] boolValue];
        [self.output paymentCredentialsDidRegisterSuccess:isRegistrationSuccessed];
    }];
}

- (NSString*)enteredBirthdayDate {
    NSString *resultDateString = nil;
    if (self.credentials.birthdayDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM d YYYY"];
        resultDateString = [dateFormat stringFromDate:self.credentials.birthdayDate];
    }
    return resultDateString;
}

#pragma mark - Help Methods

- (void)checkCredentials {
    
}

@end
