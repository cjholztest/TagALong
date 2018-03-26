//
//  ProfilePaymentCredentials.m
//  TagALong
//
//  Created by User on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentCredentials.h"

@implementation ProfilePaymentCredentials

- (NSDictionary*)paramsCredentials {
    
    NSDictionary *birthday = @{@"day" : @(self.birtdayDay),
                               @"month" : @(self.birtdayMonth),
                               @"year" : @(self.birtdayYear)};
    
    NSDictionary *address = @{@"line1" : self.address,
                              @"postal_code" : @(self.postalCode),
                              @"city" : self.city,
                              @"state" : self.state};
    
    NSDictionary *legacy = @{@"dob" : birthday,
                             @"address" : address,
                             @"first_name" : self.firstName,
                             @"last_name" : self.lastName,
                             @"ssn_last_4" : self.ssnLast};
    
    NSDictionary *params = @{@"legal_entity" : legacy,
                             @"password" : self.password};
    return params;
}

- (void)updateBirthdayByDate:(NSDate*)date {
    if (!date) { return; }
    
    self.birthdayDate = date;
    
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    self.birtdayYear = [dateComponents year];
    self.birtdayMonth = [dateComponents month];
    self.birtdayDay = [dateComponents day];
}

- (NSString*)checkedCredentialsMessage {
    NSString *errorMessage = nil;
    
    if (self.firstName.length == 0) {
        errorMessage = @"First name";
    } else if (self.lastName.length == 0) {
        errorMessage = @"Last name";
    } else if (!self.birthdayDate) {
        errorMessage = @"Birthday date";
    } else if (self.address.length == 0) {
        errorMessage = @"Address";
    } else if (self.postalCode == 0) {
        errorMessage = @"Postal code";
    } else if (self.city.length == 0) {
        errorMessage = @"City";
    } else if (self.state.length == 0) {
        errorMessage = @"State";
    } else if (self.ssnLast.length == 0) {
        errorMessage = @"SSN last 4 numbers";
    }
    
    if (errorMessage.length > 0) {
        errorMessage = [NSString stringWithFormat:@"%@ is required", errorMessage];
    }
    
    return errorMessage;
}

@end
