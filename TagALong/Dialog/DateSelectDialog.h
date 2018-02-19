//
//  DateSelectDialog.h
//
//  날짜 선택
//  Created  10/27/17
//

#import <UIKit/UIKit.h>

@protocol DateSelectDialogDelegate <NSObject>

- (void)setDate:(NSString*)date date2:(NSString*)date2;

@end
@interface DateSelectDialog : UIViewController
@property (strong, nonatomic) id<DateSelectDialogDelegate> delegate;
@end
