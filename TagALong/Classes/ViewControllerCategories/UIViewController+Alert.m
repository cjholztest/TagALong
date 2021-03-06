//
//  UIViewController+Alert.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAlert:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {}];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlert:(NSString*)message withOkCompletion:(void(^)(void))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tag-A-Long \n"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         if (completion) {
                                                             completion();
                                                         }
                                                     }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
