//
//  CalendarViewController.m
//  TaskTracker
//
//  Created by arvind on 3/18/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "CalendarViewController.h"
#import "VRGCalendarView.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController
@synthesize calendardateArrat,backButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;

    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.backButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:self.backButton];

    calendardateArrat=[NSMutableArray arrayWithObjects:@"14/03/2016",@"16/03/2016", nil];
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    calendar.frame=CGRectMake(0, 60, self.view.bounds.size.width-250, (self.view.bounds.size.height*40)/100);
    [self.view addSubview:calendar];
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    [calendarView markDates:calendardateArrat];
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSDate *newDate1 = [date dateByAddingTimeInterval:60*60*24*1];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSLog(@"%@",[dateFormatter stringFromDate:date]);
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

@end
