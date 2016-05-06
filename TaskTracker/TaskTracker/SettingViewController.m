//
//  SettingViewController.m
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SettingViewController.h"
#import "UIColor+Expanded.h"
#import "DashboardHomeViewController.h"
#import "ReportInvoiceViewController.h"
#import "ProjectListViewController.h"
#import "InvoiceViewController.h"
#import "LoginViewController.h"
#import "SupportCommunityViewController.h"
#import "PreferencesViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize reportinvoiceBtn,dataimportBtn,supportcomtyBtn,facebookBtn,websiteBtn,emailBtn,alldataclientproBtn,settingBtn,isMenuVisible,overlayView,menuNameArray,menuNameButton,tableviewSetting,expensesListSetting,overlyScrollview,daysofWeekaralertView,dayofWeeksArray,alert,roundupdownAlertview,alertnameBtn,isstartweekday,isroundupdown,alertscrollview,isdateformat;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *NavigationbgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*0.10)];
    [NavigationbgImage setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    [self.view addSubview:NavigationbgImage];
    
    
    UIImageView *dashboardImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.11, screenRect.size.width, screenRect.size.height)];
    [dashboardImage setImage:[UIImage imageNamed:@"reports_background.PNG"]];
    [self.view addSubview:dashboardImage];
    
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.25, screenRect.size.width, screenRect.size.height*0.80)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(0, 15, screenRect.size.width*0.85, 30)];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [titleLabel setText:@"TIME & EXPENSE"];
    titleLabel.textColor=[UIColor whiteColor];
    UIFont *customFontdt = [UIFont fontWithName:@"BrandonText-Bold" size:screenRect.size.width*0.04];
    titleLabel.font =customFontdt;
    [self.view addSubview:titleLabel];
    
    settingBtn=[[UIButton alloc]init];
    settingBtn.frame=CGRectMake(13, 18, 37, 23);
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"menuicon.PNG"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(menuScreenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15,screenRect.size.width,screenRect.size.height*0.06)];
    dashboardLbl.text = @"Setting";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontd = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.06];
    dashboardLbl.font = customFontd;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];

    
    expensesListSetting=[[NSMutableArray alloc]initWithObjects:@"Data import",@"Data export",@"Support / community",@"Roundup or round down",@"Start week",@"Work week days",@"Create invoice ",@"Currency $",@"Date format",@"Elapsed time format",@"Timer", nil];
    
   // @"Help",@"Facebook",@"Contact support"
    tableviewSetting=[[UITableView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.25,screenRect.size.width,screenRect.size.height*0.75)];
    tableviewSetting.dataSource = self;
    tableviewSetting.delegate = self;
    [tableviewSetting setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
        self.tableviewSetting.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableviewSetting];
    self.tableviewSetting.allowsMultipleSelectionDuringEditing = YES;
    menuNameArray=[[NSMutableArray alloc]initWithObjects:@"DASHBOARD",@"INVOICE",@"REPORTS",@"CLIENT/PROJECT LIST",@"SETTING",@"PREFERENCES",@"LOGOUT", nil];
    overlyScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    [overlyScrollview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height+200)];
    //overlayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
    overlayView.alpha = 0.95;
    
    UILabel *overlaytitleLabel = [[UILabel alloc] init];
    [overlaytitleLabel setFrame:CGRectMake(0, 15, screenRect.size.width, 35)];
    overlaytitleLabel.textAlignment = NSTextAlignmentCenter;
    [overlaytitleLabel setText:@"TIME & EXPENSE"];
    overlaytitleLabel.textColor=[UIColor whiteColor];
    overlaytitleLabel.font =[UIFont fontWithName:@"BrandonText-Bold" size:20];
    [overlayView addSubview:overlaytitleLabel];
    
    UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,45, screenRect.size.width*0.20,screenRect.size.height*0.12)];
    [overlypersonImage setImage:[UIImage imageNamed:@"profileimage.PNG"]];
    [overlayView addSubview:overlypersonImage];
    
    UILabel *overlaynameLabel = [[UILabel alloc] init];
    [overlaynameLabel setFrame:CGRectMake(0, screenRect.size.height*0.19, screenRect.size.width, screenRect.size.height*0.04)];
    overlaynameLabel.textAlignment = NSTextAlignmentCenter;
    //[overlaynameLabel setText:@"Shawn McAdams"];
    overlaynameLabel.textColor=[UIColor whiteColor];
    overlaynameLabel.font =[UIFont fontWithName:@"Brandon-med" size:13];
    [overlayView addSubview:overlaynameLabel];
    
    UILabel *overlaymailLabel = [[UILabel alloc] init];
    [overlaymailLabel setFrame:CGRectMake(0, screenRect.size.height*0.22, screenRect.size.width, screenRect.size.height*0.04)];
    overlaymailLabel.textAlignment = NSTextAlignmentCenter;
    //[overlaymailLabel setText:@"Shawm321@gmail.com"];
    overlaymailLabel.textColor=[UIColor whiteColor];
    overlaymailLabel.font =[UIFont fontWithName:@"brandongrotesque-regular" size:12];
    [overlayView addSubview:overlaymailLabel];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *nameStr=[NSString stringWithFormat:@"%@ %@",[prefs stringForKey:@"firstname"],[prefs stringForKey:@"lastname"]];
    [overlaynameLabel setText:nameStr];
    [overlaymailLabel setText:[prefs stringForKey:@"email"]];

    int yValue=screenRect.size.height*0.275;
    for (int count=0; count<[menuNameArray count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue-5,screenRect.size.width,screenRect.size.height*0.08)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [overlayView addSubview:borderImg];
        
        if (count==0) {
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"dashboardicon.PNG"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==1){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"invoiceicon.PNG"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==2){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"reporticon.PNG"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==3){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"clientprojectlisticon.PNG"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==4){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"setting_2.png"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==5){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"setting_2.png"]];
            [overlayView addSubview:overlypersonImage];
            
        }else if (count==6){
            UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(20,yValue,screenRect.size.width*0.12,screenRect.size.height*0.07)];
            [overlypersonImage setImage:[UIImage imageNamed:@"logout.png"]];
            [overlayView addSubview:overlypersonImage];
            
        }
        
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20, yValue, screenRect.size.width, screenRect.size.height*0.06)];
        [menuNameButton setTitle:[menuNameArray objectAtIndex:count] forState:UIControlStateNormal];
        menuNameButton.tag=count;
        UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        menuNameButton.titleLabel.font= customFontd;
        [menuNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuNameButton setBackgroundColor:[UIColor clearColor]];
        [menuNameButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        menuNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [overlayView addSubview:menuNameButton];
        
        yValue=yValue+screenRect.size.height*0.12;
    }
    [self.overlyScrollview addSubview:overlayView];
    [self.view addSubview:overlyScrollview];
    
    overlyScrollview.contentSize = CGSizeMake(screenRect.size.width,yValue+50);
    overlyScrollview.scrollEnabled=YES;
    overlyScrollview.hidden=YES;
    
    overlayView.hidden=true;
    isMenuVisible=false;


}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    
}


-(IBAction)menuScreenAction{
    if(!isMenuVisible)
    {
        overlayView.hidden=false;
        isMenuVisible=true;
        overlyScrollview.hidden=NO;
    }else{
        overlayView.hidden=true;
        overlyScrollview.hidden=YES;
        isMenuVisible=false;
    }
    
}
-(IBAction)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        DashboardHomeViewController * dashboard;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            dashboard = [[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
            
        }else{
            dashboard = [[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
        }
        [self.navigationController pushViewController:dashboard animated:NO];
        
    }else if (tags==1){
        InvoiceViewController * invoice;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            invoice = [[InvoiceViewController alloc] initWithNibName:@"InvoiceViewController" bundle:nil];
            
        }else{
            invoice = [[InvoiceViewController alloc] initWithNibName:@"InvoiceViewController" bundle:nil];
        }
        [self.navigationController pushViewController:invoice animated:NO];
        
    }else if (tags==2){
        ReportInvoiceViewController * report;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            report = [[ReportInvoiceViewController alloc] initWithNibName:@"ReportInvoiceViewController" bundle:nil];
            
        }else{
            report = [[ReportInvoiceViewController alloc] initWithNibName:@"ReportInvoiceViewController" bundle:nil];
        }
        [self.navigationController pushViewController:report animated:NO];
    }else if (tags==3){
        ProjectListViewController * project;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            project = [[ProjectListViewController alloc] initWithNibName:@"ProjectListViewController" bundle:nil];
            
        }else{
            project = [[ProjectListViewController alloc] initWithNibName:@"ProjectListViewController" bundle:nil];
        }
        [self.navigationController pushViewController:project animated:NO];
        
    }else if (tags==4){
        if(!isMenuVisible)
        {
            overlyScrollview.hidden=NO;
            overlayView.hidden=false;
            isMenuVisible=true;
        }else{
            overlyScrollview.hidden=YES;
            overlayView.hidden=true;
            isMenuVisible=false;
        }
    }else if (tags==5){
        PreferencesViewController * preferences;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            preferences = [[PreferencesViewController alloc] initWithNibName:@"PreferencesViewController" bundle:nil];
            
        }else{
            preferences = [[PreferencesViewController alloc] initWithNibName:@"PreferencesViewController" bundle:nil];
        }
        [self.navigationController pushViewController:preferences animated:NO];
    }else if (tags==6){
        LoginViewController * login;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
        }else{
            login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        }
        [self.navigationController pushViewController:login animated:NO];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs removeObjectForKey:@"loggedin"];
        [prefs setObject:nil forKey:@"Punchedin"];
        [prefs synchronize];

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return expensesListSetting.count;
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
    }

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (indexPath.section==3 || indexPath.section==4 || indexPath.section==5 || indexPath.section==7 || indexPath.section==8) {
        UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height*0.07)];
        [bgImage setImage:[UIImage imageNamed:@"reportslistitem_background.PNG"]];
        [cell.contentView addSubview:bgImage];
        [cell setBackgroundColor:[UIColor clearColor]];

    }else{
        [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thin-arrow-right-only-wh.png"]];
    }

    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(20,0,screenRect.size.width-80,screenRect.size.height*0.07)];
    [fieldLBls setText:[expensesListSetting objectAtIndex:indexPath.section]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    fieldLBls.textColor=[UIColor whiteColor];
    UIFont *customFontd = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.05];
    [fieldLBls setFont:customFontd];
    [cell.contentView addSubview:fieldLBls];
   
    
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
    if (indexPath.section==2) {
        SupportCommunityViewController *support=[[SupportCommunityViewController alloc] initWithNibName:@"SupportCommunityViewController" bundle:nil];
        [self.navigationController pushViewController:support animated:YES];
    }
    if (indexPath.section==3) {
        isroundupdown=true;
        [self roundupdownAction];
    }
    if (indexPath.section==4) {
        isstartweekday=true;
        isdateformat=false;
        [self daysofweeksDisplay];
    }
    
    if (indexPath.section==5) {
        isstartweekday=false;
        isdateformat=false;
        [self daysofweeksDisplay];

    }
    if (indexPath.section==7) {
        isroundupdown=false;
        [self roundupdownAction];
        
    }
    if (indexPath.section==8) {
        isdateformat=true;
        [self daysofweeksDisplay];
    }

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Save"]){
        NSString *str=[[NSString alloc]init];
        str=[alert textFieldAtIndex:0].text;
        [alert resignFirstResponder];
        NSString * nameOfday=[NSString stringWithFormat:@"Your work week days %@",str];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:nameOfday
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)daysofweeksDisplay
{
    // Here we need to pass a full frame
    daysofWeekaralertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [daysofWeekaralertView setContainerView:[self daysofweeksAlert]];
    // Modify the parameters
    [daysofWeekaralertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [daysofWeekaralertView setUseMotionEffects:true];
    // And launch the dialog
    [daysofWeekaralertView show];
}
-(UIView *)daysofweeksAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,340)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Time & Expenses" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    
    if (isdateformat) {
        dayofWeeksArray=[[NSMutableArray alloc]initWithObjects:@"MM/DD/YYYY",@"DD/MM/YYYY",@"YYYY/DD/MM",@"MM/dd/yyyy hh:mm:a",@"mm.dd.yyyy",@"dd.mm.yyyy",@"DD-MM-YYYY", nil];

    }else{
    if (isstartweekday) {
    dayofWeeksArray=[[NSMutableArray alloc]initWithObjects:@"SUNDAY",@"MONDAY",@"TUESDAY",@"WEDNESDAY",@"THURSDAY",@"FIRDAY",@"SATURDAY", nil];
    }else{
        dayofWeeksArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    }
    }
   int yValue=50;
    for (int count=0; count<[dayofWeeksArray count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,300,30)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [demoView addSubview:borderImg];
        
        alertnameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, yValue, 300,30)];
        [alertnameBtn setTitle:[dayofWeeksArray objectAtIndex:count] forState:UIControlStateNormal];
        alertnameBtn.tag=count;
        UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        alertnameBtn.titleLabel.font= customFontd;
        [alertnameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [alertnameBtn setBackgroundColor:[UIColor clearColor]];
        [alertnameBtn addTarget:self action:@selector(SetDaysofWeeks:) forControlEvents:UIControlEventTouchUpInside];
        alertnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [demoView addSubview:alertnameBtn];
        
        yValue=yValue+35;
    }
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,288,300,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
    
}
-(void)SetDaysofWeeks:(UIButton *)Btn{
    
    if (isdateformat) {
        NSString * nameOfday=[NSString stringWithFormat:@"Your date format is %@",[dayofWeeksArray objectAtIndex:Btn.tag]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:nameOfday
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }else{
    if (isstartweekday) {
        
        NSString * nameOfday=[NSString stringWithFormat:@"Your start week is %@",[dayofWeeksArray objectAtIndex:Btn.tag]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:nameOfday
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSString * nameOfday=[NSString stringWithFormat:@"Your work week days %@",[dayofWeeksArray objectAtIndex:Btn.tag]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:nameOfday
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    }
    [daysofWeekaralertView close];
}

- (void)roundupdownAction
{
    // Here we need to pass a full frame
    roundupdownAlertview = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [roundupdownAlertview setContainerView:[self roundupdownAlert]];
    // Modify the parameters
    [roundupdownAlertview setDelegate:self];
    // You may use a Block, rather than a delegate.
    [roundupdownAlertview setUseMotionEffects:true];
    // And launch the dialog
    [roundupdownAlertview show];
}
-(UIView *)roundupdownAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *demoView;
    UIButton *cancelBtn;
    if (isroundupdown) {
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,220)];
    }else{
        demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,350)];
     }
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Time & Expenses" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    if (isroundupdown) {
        dayofWeeksArray=[[NSMutableArray alloc]initWithObjects:@"ROUND UP",@"ROUND DOWN",@"NORMAL", nil];
        int yValue=50;
        for (int count=0; count<[dayofWeeksArray count]; count++) {
            UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,300,35)];
            [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
            [demoView addSubview:borderImg];
            
            alertnameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, yValue, screenRect.size.width,35)];
            [alertnameBtn setTitle:[dayofWeeksArray objectAtIndex:count] forState:UIControlStateNormal];
            alertnameBtn.tag=count;
            UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
            alertnameBtn.titleLabel.font= customFontd;
            [alertnameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [alertnameBtn setBackgroundColor:[UIColor clearColor]];
            [alertnameBtn addTarget:self action:@selector(roundupdownAction:) forControlEvents:UIControlEventTouchUpInside];
            alertnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [demoView addSubview:alertnameBtn];
            
            yValue=yValue+40;
        }
       cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(0,168,300,50)];

    }else{
        dayofWeeksArray=[[NSMutableArray alloc]initWithObjects:@"USD - US Dollar",@"EUR - Euro",@"GBP - British Pound",@"AUD - Australian Dollar",@"INR - Indian Rupee",@"CAD - Canadian Dollar",@"SGD - Singapore Dollar", nil];
        
        alertscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,50,300,250)];
        [alertscrollview setBackgroundColor:[UIColor clearColor]];
        
        int yValue=0;
        int yValues=50;

        for (int count=0; count<[dayofWeeksArray count]; count++) {
            UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,300,35)];
            [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
            [alertscrollview addSubview:borderImg];
            
            alertnameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, yValue,300,35)];
            [alertnameBtn setTitle:[dayofWeeksArray objectAtIndex:count] forState:UIControlStateNormal];
            alertnameBtn.tag=count;
            UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
            alertnameBtn.titleLabel.font= customFontd;
            [alertnameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [alertnameBtn setBackgroundColor:[UIColor clearColor]];
            [alertnameBtn addTarget:self action:@selector(roundupdownAction:) forControlEvents:UIControlEventTouchUpInside];
            alertnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [alertscrollview addSubview:alertnameBtn];
            
            yValue=yValue+40;
            yValues=yValues+40;

        }
        [demoView addSubview:alertscrollview];
        
        alertscrollview.contentSize = CGSizeMake(300,340);
        alertscrollview.scrollEnabled=YES;

        cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(0,300,300,50)];
    }

    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
    
}

-(void)closeAlert:(id)sender{
    [daysofWeekaralertView close];
    [roundupdownAlertview close];
}


-(void)roundupdownAction:(UIButton *)Btn{
    if (isroundupdown) {

    NSString * nameOfday=[NSString stringWithFormat:@"You select %@",[dayofWeeksArray objectAtIndex:Btn.tag]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                    message:nameOfday
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[dayofWeeksArray objectAtIndex:Btn.tag] forKey:@"Roundupdown"];
    [prefs synchronize];
        
    }else{
        NSString * nameOfday=[NSString stringWithFormat:@"You select currency is %@",[dayofWeeksArray objectAtIndex:Btn.tag]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:nameOfday
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    [roundupdownAlertview close];
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
