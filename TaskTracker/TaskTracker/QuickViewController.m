//
//  QuickViewController.m
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "QuickViewController.h"
#import "UIColor+Expanded.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"

@interface QuickViewController ()

@end

@implementation QuickViewController
@synthesize tableviewquickview,quickArray1,quickArray2,quickArray3,mainSegment,reportBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"fafaf9"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"4a89dc"];

    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Quick View"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font =[UIFont fontWithName:@"dinneuzeitgrotesk-light" size:24];
    self.navigationItem.titleView = titleLabel;
    
    UIButton* btton = [UIButton buttonWithType:UIButtonTypeCustom];
    [btton setFrame:CGRectMake(0, 0, 25, 25)];
    [btton addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    btton.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:25];
    [btton setTitle:@"\uf0f6" forState:UIControlStateNormal];
    [btton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reportBtn = [[UIBarButtonItem alloc] initWithCustomView:btton];
    self.reportBtn.tintColor = [UIColor whiteColor];

    [self.navigationItem setRightBarButtonItem:self.reportBtn];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat ywidth = screenRect.size.width;

    mainSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Today", @"Week", @"Month",nil]];
    [mainSegment setSegmentedControlStyle:UISegmentedControlStyleBar];
    mainSegment.frame = CGRectMake(0,70, ywidth, 30);
    mainSegment.selectedSegmentIndex = 0;
    [mainSegment setTintColor:[UIColor colorWithHexString:@"4a89dc"]];
    [mainSegment addTarget:self action:@selector(mainSegmentControl:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:mainSegment];
    
    quickArray1=[[NSMutableArray alloc]initWithObjects:@"Project1                            10 hours",@"Project2                             10 hours",@"Project3                            10 hours",@"Project4                            10 hours", nil];
    quickArray2=[[NSMutableArray alloc]initWithObjects:@"Project5                            10 hours",@"Project6                            10 hours",@"Project7                            10 hours",@"Project8                            10 hours", nil];
    quickArray3=[[NSMutableArray alloc]initWithObjects:@"Project9                            10 hours",@"Project10                            10 hours",@"Project11                            10 hours",@"Project12                            10 hours", nil];

    tableviewquickview=[[UITableView alloc] initWithFrame:CGRectMake(0,110,screenRect.size.width,screenRect.size.height-50)];
    tableviewquickview.dataSource = self;
    tableviewquickview.delegate = self;
    [tableviewquickview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableviewquickview];

}

-(IBAction)reportAction:(id)sender{
    
}
- (void)mainSegmentControl:(UISegmentedControl *)segment
{
    
    if(segment.selectedSegmentIndex == 0)
    {
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        // action for the second button
    }
    else if(segment.selectedSegmentIndex == 2)
    {
        // action for the third button
    }
    [tableviewquickview reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (mainSegment.selectedSegmentIndex)
    {
        case 0:
            return [quickArray1 count];
        case 1:
            return [quickArray1 count];
        case 2:
            return [quickArray1 count];

    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    switch (mainSegment.selectedSegmentIndex)
    {
        case 0:
            //[tableView insertRowsAtIndexPaths:rowoftitle withRowAnimation:UITableViewRowAnimationTop];
            
            cell.textLabel.text =[quickArray1 objectAtIndex:indexPath.row];
            break;
            
        case 1:
            //[tableView insertRowsAtIndexPaths:rowofauth withRowAnimation:UITableViewRowAnimationTop];
            
            
            //[libraryTV reloadData];
            cell.textLabel.text =[quickArray2 objectAtIndex:indexPath.row];
            break;
        case 2:
            //[tableView insertRowsAtIndexPaths:rowofpub withRowAnimation:UITableViewRowAnimationTop];
            
            cell.textLabel.text =[quickArray3 objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
