//
//  ProfilePaymentConstants.h
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ProfilePaymentFieldType) {
    ProfilePaymentFieldTypeFirstName = 0,
    ProfilePaymentFieldTypeLastName,
    ProfilePaymentFieldTypeBirthday,
    ProfilePaymentFieldTypeAddress,
    ProfilePaymentFieldTypePostalCode,
    ProfilePaymentFieldTypeCity,
    ProfilePaymentFieldTypeState,
    ProfilePaymentFieldTypeSSNLast,
    ProfilePaymentFieldTypeSSNFull,
};

typedef NS_ENUM(NSInteger, ProfilePaymentModeType) {
    ProfilPaymentModeTypeRegistration,
    ProfilPaymentModeTypeValidation,
};

typedef struct {
    
} Payment;
