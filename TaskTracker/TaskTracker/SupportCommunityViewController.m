//
//  SupportCommunityViewController.m
//  TaskTracker
//
//  Created by arvind on 4/7/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SupportCommunityViewController.h"

@interface SupportCommunityViewController ()

@end

@implementation SupportCommunityViewController
@synthesize tableview,supportListSetting,editButton,cancelButton,addButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Support / community"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font =[UIFont fontWithName:@"BrandonText-Bold" size:24];
    self.navigationItem.titleView = titleLabel;
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(InsertRecords)];
    self.editButton.tintColor = [UIColor whiteColor];
    //self.addButton.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:self.editButton];
    //[self.navigationItem setRightBarButtonItem:self.addButton];

    supportListSetting=[[NSMutableArray alloc]initWithObjects:@"Help how to use the app",@"Facebook",@"Website",@"Send email to support", nil];
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,60,screenRect.size.width,screenRect.size.height-60)];
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview setSeparatorColor:[UIColor clearColor]];
    [tableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.view addSubview:tableview];
}

-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return supportListSetting.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thin-arrow-right-only-wh.png"]];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont *customFontd = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.04];

    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(20,0,screenRect.size.width-80,screenRect.size.height*0.07)];
    [fieldLBls setText:[supportListSetting objectAtIndex:indexPath.section]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    fieldLBls.textColor=[UIColor whiteColor];
    [fieldLBls setFont:customFontd];
    [cell.contentView addSubview:fieldLBls];
    
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.07;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:@"Sample Subject"];
            [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
            [mail setToRecipients:@[@"powararvind3@gmail.com"]];
            
            [self presentViewController:mail animated:YES completion:NULL];
        }
        else
        {
            NSLog(@"This device cannot send email");
        }
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
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
