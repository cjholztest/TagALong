//
//  EditDialogViewController.h
//  
//
//  Created by rabit J. on 8/15/17.
//

#import <UIKit/UIKit.h>

@protocol EditDialogViewControllerDelegate <NSObject>

- (void)setContent:(NSString*)type msg:(NSString*)content;

@end

@interface EditDialogViewController : UIViewController
@property (strong, nonatomic) id<EditDialogViewControllerDelegate> delegate;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *content;
@end
