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
        _placeholders = @[@"First name", @"Last name", @"Birthday", @"Address", @"Postal code", @"City", @"State", @"SSN last 4 numbers"];
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
