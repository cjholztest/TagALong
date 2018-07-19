//
//  ProfilePaymentDataFriendsController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/24/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentDataFriendsController.h"
#import "ProfilePaymentConstants.h"

@interface ProfilePaymentDataFriendsController ()

@property (nonatomic, strong) NSArray *placeholders;

@end

@implementation ProfilePaymentDataFriendsController

- (NSArray*)placeholders {
    if (!_placeholders) {
        _placeholders = @[@"First Name",
                          @"Last Name",
                          @"Date of Birth",
                          @"Address",
                          @"City",
                          @"State (in AL, AK, AZ…)",
                          @"Zip Code",
                          @"Last 4 Digits of SSN"];
    }
    return _placeholders;
}

- (UIKeyboardType)keyboardTypeForFieldType:(NSInteger)fieldType {
    
    ProfilePaymentFieldType type = fieldType;
    UIKeyboardType keyboardTYpe = UIKeyboardTypeDefault;
    
    switch (type) {
        case ProfilePaymentFieldTypePostalCode:
        case ProfilePaymentFieldTypeSSNLast:
            keyboardTYpe = UIKeyboardTypeNumberPad;
            break;
        default:
            keyboardTYpe = UIKeyboardTypeDefault;
            break;
    }
    return keyboardTYpe;
}

- (NSString*)placeholderFieldType:(NSInteger)fieldType {
    return self.placeholders[fieldType];
}

@end
