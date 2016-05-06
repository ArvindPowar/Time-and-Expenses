//
//  InvoiceViewController.m
//  TaskTracker
//
//  Created by arvind on 3/28/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "InvoiceViewController.h"
#import "DashboardHomeViewController.h"
#import "ProjectListViewController.h"
#import "ExpensesViewController.h"
#import "ReportInvoiceViewController.h"
#import "UIColor+Expanded.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PreferencesViewController.h"

@interface InvoiceViewController ()

@end

@implementation InvoiceViewController
@synthesize overlayView,menuNameArray,menuNameButton,isMenuVisible,settingBtn,numberofwekBtn,lastwekBtn,listofwekBtn,islistviewVisible,listView,arrayData,listofweekBtn,overlyScrollview;
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
    UIFont *customFontd = [UIFont fontWithName:@"BrandonText-Bold" size:screenRect.size.width*0.04];
    titleLabel.font =customFontd;
    [self.view addSubview:titleLabel];
    
    settingBtn=[[UIButton alloc]init];
    settingBtn.frame=CGRectMake(13, 18, 37, 23);
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"menuicon.PNG"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(menuScreenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15,screenRect.size.width,35)];
    dashboardLbl.text = @"Invoices";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.05];
    dashboardLbl.font =customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];
    
    UILabel *specificdateLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.28,screenRect.size.width,35)];
    specificdateLbl.text = @"Create Invoice for Specified Dates";
    specificdateLbl.textColor=[UIColor whiteColor];
    specificdateLbl.font = customFontds;
    specificdateLbl.textAlignment = NSTextAlignmentCenter;
    [specificdateLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:specificdateLbl];
    
    UILabel *numberwekLBl=[[UILabel alloc]initWithFrame:CGRectMake(3,screenRect.size.height*0.35,screenRect.size.width-6,screenRect.size.height*0.06)];
    numberwekLBl.text = @"   Number of Weeks";
    numberwekLBl.textColor=[UIColor whiteColor];
    numberwekLBl.font = customFontds;
    numberwekLBl.textAlignment = NSTextAlignmentLeft;
    [numberwekLBl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    [self.view addSubview:numberwekLBl];
    
    
    numberofwekBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.92,screenRect.size.height*0.36,  screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [numberofwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
    [numberofwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
    numberofwekBtn.layer.cornerRadius = 6.0f;
    [numberofwekBtn setTag:0];
    //[numberofwekBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
    [numberofwekBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numberofwekBtn];

    
    UILabel *lastmonthLbl=[[UILabel alloc]initWithFrame:CGRectMake(3,screenRect.size.height*0.42,screenRect.size.width-6,screenRect.size.height*0.06)];
    lastmonthLbl.text = @"   Last Month";
    lastmonthLbl.textColor=[UIColor whiteColor];
    lastmonthLbl.font = customFontds;
    lastmonthLbl.textAlignment = NSTextAlignmentLeft;
    [lastmonthLbl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    [self.view addSubview:lastmonthLbl];
    
    lastwekBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.92,screenRect.size.height*0.43, screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [lastwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
    [lastwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
    lastwekBtn.layer.cornerRadius = 6.0f;
    [lastwekBtn setTag:1];
    //[lastwekBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
    [lastwekBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastwekBtn];

    listofweekBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,screenRect.size.height*0.49, screenRect.size.width-100,screenRect.size.height*0.06)];
    [listofweekBtn.titleLabel setFont:customFontds];
    [listofweekBtn setTitle:@"  List of Weeks" forState:UIControlStateNormal];
    [listofweekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    listofweekBtn.layer.cornerRadius = 6.0f;
    listofweekBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [listofweekBtn setBackgroundImage:[UIImage imageNamed:@"reportslistitem_background.PNG"] forState:UIControlStateNormal];
    [listofweekBtn addTarget:self action:@selector(actionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listofweekBtn];
    
    
    listofwekBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.92,screenRect.size.height*0.50,  screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [listofwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
    [listofwekBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
    listofwekBtn.layer.cornerRadius = 6.0f;
    [listofwekBtn setTag:2];
    //[listofwekBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
    [listofwekBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listofwekBtn];

    UILabel *detailsLbl2 = [[UILabel alloc] init];
    [detailsLbl2 setFrame:CGRectMake(30, screenRect.size.height*0.80, screenRect.size.width*0.90, 60)];
    detailsLbl2.textAlignment = NSTextAlignmentCenter;
    [detailsLbl2 setText:@"INVOICE & EXPENSES ARE IN PDF WITH RECEIPTS"];
    detailsLbl2.textColor=[UIColor whiteColor];
    detailsLbl2.lineBreakMode = NSLineBreakByWordWrapping;
    detailsLbl2.numberOfLines = 0;
    UIFont *customFontdss = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.03];
    detailsLbl2.font =customFontdss;
    [self.view addSubview:detailsLbl2];

    UIButton *emailinvoiceBtn=[[UIButton alloc]initWithFrame:CGRectMake(60,screenRect.size.height*0.90, screenRect.size.width-120,screenRect.size.height*0.06)];
    UIFont *customFontdsss = [UIFont fontWithName:@"Brandon_med" size:screenRect.size.width*0.04];
    [emailinvoiceBtn.titleLabel setFont:customFontdsss];
    [emailinvoiceBtn setTitle:@"Generate Invoice" forState:UIControlStateNormal];
    [emailinvoiceBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    emailinvoiceBtn.layer.cornerRadius = 6.0f;
    emailinvoiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [emailinvoiceBtn setBackgroundColor:[UIColor whiteColor]];
    //[emailinvoiceBtn addTarget:self action:@selector(clientprojectList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailinvoiceBtn];

    menuNameArray=[[NSMutableArray alloc]initWithObjects:@"DASHBOARD",@"INVOICE",@"REPORTS",@"CLIENT/PROJECT LIST",@"SETTING",@"PREFERENCES",@"LOGOUT", nil];
    overlyScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    [overlyScrollview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height+200)];
    //overlayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
    overlayView.alpha = 0.95;
    UIFont *customFontdex = [UIFont fontWithName:@"BrandonText-Bold" size:screenRect.size.width*0.05];

    UILabel *overlaytitleLabel = [[UILabel alloc] init];
    [overlaytitleLabel setFrame:CGRectMake(0, 15, screenRect.size.width, 35)];
    overlaytitleLabel.textAlignment = NSTextAlignmentCenter;
    [overlaytitleLabel setText:@"TIME & EXPENSE"];
    overlaytitleLabel.textColor=[UIColor whiteColor];
    overlaytitleLabel.font =customFontdex;
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
        
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20, yValue,screenRect.size.width, screenRect.size.height*0.06)];
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
    
    
    arrayData = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"  1st Week",@"  2nd Week",@"  3rd Week",nil]];
    listView = [[UIView alloc] initWithFrame:CGRectMake(20,screenRect.size.height*0.555, screenRect.size.width-115,screenRect.size.height*0.20)];
    listView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    listView.alpha = 0.95;
    int yValuelist=10;
    for (int count=0; count<[arrayData count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-8,screenRect.size.width-120,2)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [listView addSubview:borderImg];
        
        UIButton *listmenu=[[UIButton alloc] initWithFrame:CGRectMake(10, yValuelist,screenRect.size.width*0.50, screenRect.size.height*0.06)];
        [listmenu setTitle:[arrayData objectAtIndex:count] forState:UIControlStateNormal];
        listmenu.tag=count;
        listmenu.titleLabel.font= [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.06];
        [listmenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [listmenu setBackgroundColor:[UIColor clearColor]];
        [listmenu addTarget:self action:@selector(dropDownListAction:) forControlEvents:UIControlEventTouchUpInside];
        listmenu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [listView addSubview:listmenu];
        
        yValuelist=yValuelist+screenRect.size.height*0.06;
    }
    UIImageView *borderImglastList=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-5,screenRect.size.width-120,2)];
    [borderImglastList setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    [listView addSubview:borderImglastList];
    listView.layer.cornerRadius = 5;
    listView.layer.masksToBounds = YES;
    [self.view addSubview:listView];
    listView.hidden=true;
    islistviewVisible=false;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapOnView:(UITapGestureRecognizer *)sender
{
    listView.hidden=true;
    islistviewVisible=false;
}

-(IBAction)actionButtonClick{
    if(!islistviewVisible)
    {
        listView.hidden=false;
        islistviewVisible=true;
    }else{
        listView.hidden=true;
        islistviewVisible=false;
    }
}
-(void)dropDownListAction:(UIButton *)button{
    int tags=button.tag;
    [listofweekBtn setTitle:[arrayData objectAtIndex:tags] forState:UIControlStateNormal];
    listView.hidden=true;
    islistviewVisible=false;
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    
}

-(IBAction)redioBtnAction:(id)sender{
    switch ([sender tag]) {
        case 0:
            if([numberofwekBtn isSelected]==YES)
            {
                [numberofwekBtn setSelected:NO];
            }
            else{
                [numberofwekBtn setSelected:YES];
            }
            
            break;
        case 1:
            if([lastwekBtn isSelected]==YES)
            {
                [lastwekBtn setSelected:NO];
            }
            else{
                [lastwekBtn setSelected:YES];
            }
            
            break;
        case 2:
            if([listofwekBtn isSelected]==YES)
            {
                [listofwekBtn setSelected:NO];
            }
            else{
                [listofwekBtn setSelected:YES];
            }
            
            break;

    }
}

-(IBAction)menuScreenAction{
    listView.hidden=true;

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
        SettingViewController * setting;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
            
        }else{
            setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        }
        [self.navigationController pushViewController:setting animated:NO];
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
