//
//  UIViewController+Alert.h
//  TagALong
//
//  Created by User on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertOkCompletion)(void);
typedef void(^AlertCancelCompletion)(void);
typedef void(^AlertYesCompletion)(void);
typedef void(^AlertNoCompletion)(void);

@interface UIViewController (Alert)

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
               okCompletion:(AlertOkCompletion)okCompletion;

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
               okCompletion:(AlertOkCompletion)okCompletion
           cancelCompletion:(AlertCancelCompletion)cancelCompletion;

- (void)showAllertWithTitle:(NSString*)title
                    message:(NSString*)message
              yesCompletion:(AlertYesCompletion)yesCompletion
               noCompletion:(AlertNoCompletion)noCompletion;

@end
