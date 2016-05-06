
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
*/
#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "DashboardHomeViewController.h"
#import "ReportInvoiceViewController.h"
#import "ProjectListViewController.h"
#import "ExpensesViewController.h"
@interface RearViewController()
@end

@implementation RearViewController
@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,selectedMenuItem,titleLabel,imageLogo;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
	[super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    imageLogo.layer.frame=CGRectMake(50,0,160,95);
    imageLogo.image=[UIImage imageNamed:@"pgfhlogo.png"];
     [self.view addSubview:imageLogo];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor=[UIColor colorWithHexString:@"727b84"];
	self.rearTableView.backgroundColor=[UIColor colorWithHexString:@"727b84"];
    self.navigationController.navigationBarHidden=YES;
    usernameLabel.font = [UIFont systemFontOfSize:14];
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=[UIColor whiteColor];
	}
    
    //UIImageView *menuItemImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 15, 15)];
    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 45)];
    
    menuItemTextLabel.font = [UIFont boldSystemFontOfSize:18];
    menuItemTextLabel.textColor=[UIColor colorWithHexString:@"fefeff"];
    cell.backgroundColor=[UIColor clearColor];
    if (row == 0)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"homeicon.png"];
        menuItemTextLabel.text = @"   DSAHBOARD";
        menuItemTextLabel.backgroundColor=[UIColor colorWithHexString:@"1acfe4"];
        [menuItemTextLabel.layer setCornerRadius:10];
        if([selectedMenuItem isEqualToString:@"   DSAHBOARD"]){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecellselected.png"]];
        }
    }else if (row == 1)
	{
        //menuItemImageView.image=[UIImage imageNamed:@"homeicon.png"];
		menuItemTextLabel.text = @"   INVOICE";
        menuItemTextLabel.backgroundColor=[UIColor colorWithHexString:@"1acfe4"];
        [menuItemTextLabel.layer setCornerRadius:10];
        if([selectedMenuItem isEqualToString:@"   INVOICE"]){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecellselected.png"]];
        }
    }
	
	else if (row == 2)
	{
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
		menuItemTextLabel.text = @"   REPORTS";
        menuItemTextLabel.backgroundColor=[UIColor colorWithHexString:@"1acfe4"];
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 4)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   WHAT TO IT";
        menuItemTextLabel.backgroundColor=[UIColor colorWithHexString:@"1acfe4"];
        [menuItemTextLabel.layer setCornerRadius:10];
    }
	else if (row == 3)
	{
		//menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
		menuItemTextLabel.text = @"   LOGOUT";
        menuItemTextLabel.backgroundColor=[UIColor colorWithHexString:@"1acfe4"];
        [menuItemTextLabel.layer setCornerRadius:10];
	}
    [menuItemTextLabel.layer setMasksToBounds:YES];
	//[cell.contentView addSubview:menuItemImageView];
    [cell.contentView addSubview:menuItemTextLabel];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* NSInteger row = indexPath.row;
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=row;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];*/
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
    [_rearTableView reloadData];
}


-(IBAction)popViewController{
    
  /*if([[FBSession activeSession] isOpen]){
        [[FBSession activeSession] close];
        [[FBSession activeSession] closeAndClearTokenInformation];
        FBSession.activeSession=nil;
    }*/
    
   /* NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"loggedin"];
    [prefs synchronize];
    
    LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
    */
}


//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}

@end