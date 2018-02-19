//
//  DateSelectDialog.m
//
//
//  Created by rabit J. on 9/28/17.
//

#import "DateSelectDialog.h"

@interface DateSelectDialog () {
    
}
@property (strong, nonatomic) IBOutlet UIView *vwBG;
@property (strong, nonatomic) IBOutlet UIDatePicker *picDate;

@end

@implementation DateSelectDialog

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vwBG.layer.cornerRadius = 3;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - click events

- (IBAction)onclickSetting:(id)sender {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *theDate = [formatter stringFromDate:_picDate.date];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
    formatter1.dateStyle = kCFDateFormatterLongStyle;
    formatter1.timeStyle = NSDateFormatterNoStyle;
    NSString *result = [formatter1 stringFromDate:_picDate.date];
    
    [self.delegate setDate:theDate date2:result];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)onclickCancel:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - user defined functions



@end
