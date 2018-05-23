//
//  UIViewController+Alert.m
//  TagALong
//
//  Created by User on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
               okCompletion:(AlertOkCompletion)okCompletion {
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                        if (okCompletion) {
                                                            okCompletion();
                                                        }
                                                     }];
    
    [self showAlertWithTitle:title message:message actions:@[okAction]];
}

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
               okCompletion:(AlertOkCompletion)okCompletion
           cancelCompletion:(AlertCancelCompletion)cancelCompletion {
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            if (okCompletion) {
                                                                okCompletion();
                                                            }
                                                        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             if (okCompletion) {
                                                                 okCompletion();
                                                             }
                                                         }];
    
    [self showAlertWithTitle:title message:message actions:@[okAction, cancelAction]];
}

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
              yesCompletion:(AlertYesCompletion)yesCompletion
               noCompletion:(AlertNoCompletion)noCompletion {
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         if (yesCompletion) {
                                                             yesCompletion();
                                                         }
                                                     }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             if (noCompletion) {
                                                                 noCompletion();
                                                             }
                                                         }];
    [self showAlertWithTitle:title message:message actions:@[yesAction, noAction]];
}

#pragma mark - Private

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message actions:(NSArray*)actions {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    for (UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
