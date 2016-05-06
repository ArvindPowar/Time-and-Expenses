//
//  ProjectListViewController.m
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ProjectListViewController.h"
#import "TaskListViewController.h"
#import "UIColor+Expanded.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "ExpensesViewController.h"
#import "DashboardHomeViewController.h"
#import "ExpensesViewController.h"
#import "ReportInvoiceViewController.h"
#import "InvoiceViewController.h"
#import "CreatePorjectViewController.h"
#import "SettingViewController.h"
#import "ProjectVO.h"
#import "LoginViewController.h"
#import "PreferencesViewController.h"
#import "ClientVO.h"
#import "ExpensesListViewController.h"
static NSString *kDeleteAllTitle = @"Delete All";
static NSString *kDeletePartialTitle = @"Delete (%d)";
@interface ProjectListViewController (){
    NSMutableArray      *sectionTitleArray;
    NSMutableDictionary *sectionContentDict;
    NSMutableArray      *arrayForBool;
}


@end

@implementation ProjectListViewController

@synthesize tableviewproject,projectListArray,editButton,cancelButton,addButton,deleteButton,dataArray,alertViewNewPro,demoView,addProjectTxt,clientarray,proactiveBtn,prodeleteBtn,proreportBtn,ExpensesBtn,overlayView,menuNameArray,menuNameButton,isMenuVisible,settingBtn,databases,appDelegate,overlyScrollview,tempclientArray,alert,clientIndexvalue,projectIndexvalue,projectindexsectonvalue;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    databases=[self getNewDb];

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
    
   UIButton * clientplusBtn=[[UIButton alloc]init];
    clientplusBtn.frame=CGRectMake(screenRect.size.width*0.93, 20, screenRect.size.width*0.06,screenRect.size.height*0.04);
    [clientplusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clientplusBtn setBackgroundImage:[UIImage imageNamed:@"plusiconaddproject.PNG"] forState:UIControlStateNormal];
    [clientplusBtn addTarget:self action:@selector(createNewClient) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clientplusBtn];

    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15,screenRect.size.width,35)];
    dashboardLbl.text = @"Client/Project List";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];
    dashboardLbl.font = customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];
    projectListArray=[[NSMutableArray alloc]initWithObjects:@"Project1",@"Project2",@"Project3",@"Project4", nil];
    clientarray=[[NSMutableArray alloc]init ];
    //clientarray=appDelegate.allclientArray;
    tableviewproject=[[UITableView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.25,screenRect.size.width,screenRect.size.height-(screenRect.size.height*0.25))style:UITableViewStyleGrouped];
    tableviewproject.dataSource = self;
    tableviewproject.delegate = self;
    self.tableviewproject.separatorColor = [UIColor clearColor];
    [tableviewproject setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.view addSubview:tableviewproject];
    self.tableviewproject.allowsMultipleSelectionDuringEditing = YES;
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];

    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item 3",@"Item 4",@"Item 5",nil];
    
    /*if (!arrayForBool) {
        arrayForBool    = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO] ,[NSNumber numberWithBool:NO], nil];
    }
    if (!sectionContentDict) {
        sectionContentDict  = [[NSMutableDictionary alloc] init];
        NSArray *array1     = [NSArray arrayWithObjects:@"Project 1", @"Project 2", @"Project 3", @"Project 4", nil];
        [sectionContentDict setValue:array1 forKey:[clientarray objectAtIndex:0]];
        NSArray *array2     = [NSArray arrayWithObjects:@"Project 1", @"Project 2", @"Project 3", nil];
        [sectionContentDict setValue:array2 forKey:[clientarray objectAtIndex:1]];
        NSArray *array3     = [NSArray arrayWithObjects:@"Project 1", @"Project 2", @"Project 3", @"Project 4", nil];
        [sectionContentDict setValue:array3 forKey:[clientarray objectAtIndex:2]];
        NSArray *array4     = [NSArray arrayWithObjects:@"Project 1", @"Project 2", @"Project 3", @"Project 4", @"Project 5", @"Project 6", nil];
        [sectionContentDict setValue:array4 forKey:[clientarray objectAtIndex:3]];
        NSArray *array5     = [NSArray arrayWithObjects:@"Project 1", @"Project 2", nil];
        [sectionContentDict setValue:array5 forKey:[clientarray objectAtIndex:4]];
    }
    */
    arrayForBool=[[NSMutableArray alloc]init];
tempclientArray=[[NSMutableArray alloc]init];
    sectionContentDict  = [[NSMutableDictionary alloc] init];
    if ([appDelegate.allclientArray count]>0) {
        
    for (int count=0; count<[appDelegate.allclientArray count]; count++) {
                [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        ClientVO *clientVos=[appDelegate.allclientArray objectAtIndex:count];
        [clientarray addObject:clientVos.clientidStr];
    }
    

    for (int count=0; count<[appDelegate.allclientArray count]; count++) {
        ClientVO * clientVO=[appDelegate.allclientArray objectAtIndex:count];
        NSMutableArray *temparray=[[NSMutableArray alloc]init];
        for (int countPro=0; countPro<[appDelegate.allprojectArray count]; countPro++) {
            ProjectVO * projectVO=[appDelegate.allprojectArray objectAtIndex:countPro];
            if ([clientVO.clientidStr isEqualToString:projectVO.client_id]) {
                [temparray addObject:projectVO];
            }
            [sectionContentDict setValue:temparray forKey:[clientarray objectAtIndex:count]];
        }
    }
    }else{
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];

    }
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

}

- (sqlite3 *)getNewDb {
    
    sqlite3 *newDb = nil;
    if (sqlite3_open([[self getDestPath] UTF8String], &newDb) == SQLITE_OK) {
        sqlite3_busy_timeout(newDb, 1000);
    } else {
        sqlite3_close(newDb);
    }
    return newDb;
}
-(NSString*)getDestPath
{
    NSString* srcPath = [[NSBundle mainBundle]pathForResource:@"TimeExpenses" ofType:@"sqlite"];
    NSArray* arrayPathComp = [NSArray arrayWithObjects:NSHomeDirectory(),@"Documents",@"TimeExpenses.sqlite", nil];
    
    NSString* destPath = [NSString pathWithComponents:arrayPathComp];
    NSLog(@"src path:%@",srcPath);
    NSLog(@"dest path:%@",destPath);
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:destPath]!=YES) {
        NSError *error;
        
        if ([manager copyItemAtPath:srcPath toPath:destPath error:&error]!=YES) {
            NSLog(@"Failed");
            
            NSLog(@"Reason = %@",[error localizedDescription]);
        }
    }
    return  destPath;
}

-(void)getProjectList{
    char *dbChars ;
    appDelegate.allprojectArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectDetailsTable"];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            ProjectVO *peojectVO=[[ProjectVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                peojectVO.project_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                peojectVO.client_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                peojectVO.user_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                peojectVO.project_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                peojectVO.project_location=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 5);
            if(dbChars!=nil)
                peojectVO.usedefaultsetting=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 6);
            if(dbChars!=nil)
                peojectVO.ratehourly_daily_project=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 7);
            if(dbChars!=nil)
                peojectVO.project_tax=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 8);
            if(dbChars!=nil)
                peojectVO.project_vat=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 9);
            if(dbChars!=nil)
                peojectVO.projectovertimehour=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 10);
            if(dbChars!=nil)
                peojectVO.projectovertimerate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 11);
            if(dbChars!=nil)
                peojectVO.projectdaily_weekly=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 12);
            if(dbChars!=nil)
                peojectVO.activeprojectStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 13);
            if(dbChars!=nil)
                peojectVO.citrStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 14);
            if(dbChars!=nil)
                peojectVO.stateStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 15);
            if(dbChars!=nil)
                peojectVO.zipStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 16);
            if(dbChars!=nil)
                peojectVO.countryStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 17);
            if(dbChars!=nil)
                peojectVO.defaultratevalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)];

            [appDelegate.allprojectArray addObject:peojectVO];
        }
    }
    
    clientarray=[[NSMutableArray alloc]init ];
    arrayForBool=[[NSMutableArray alloc]init];
    tempclientArray=[[NSMutableArray alloc]init];
    sectionContentDict  = [[NSMutableDictionary alloc] init];
    if ([appDelegate.allclientArray count]>0) {
        
        for (int count=0; count<[appDelegate.allclientArray count]; count++) {
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            ClientVO *clientVos=[appDelegate.allclientArray objectAtIndex:count];
            [clientarray addObject:clientVos.clientidStr];
        }
        
        
        for (int count=0; count<[appDelegate.allclientArray count]; count++) {
            ClientVO * clientVO=[appDelegate.allclientArray objectAtIndex:count];
            NSMutableArray *temparray=[[NSMutableArray alloc]init];
            for (int countPro=0; countPro<[appDelegate.allprojectArray count]; countPro++) {
                ProjectVO * projectVO=[appDelegate.allprojectArray objectAtIndex:countPro];
                if ([clientVO.clientidStr isEqualToString:projectVO.client_id]) {
                    [temparray addObject:projectVO];
                }
                [sectionContentDict setValue:temparray forKey:[clientarray objectAtIndex:count]];
            }
        }
    }else{
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        
    }

    [tableviewproject reloadData];
}

-(IBAction)createNewClient{
    CreatePorjectViewController *setting=[[CreatePorjectViewController alloc]initWithNibName:@"CreatePorjectViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    
    if ([appDelegate.allprojectArray count]==0) {
        [self getProjectList];

    }
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

            }}

-(void)closeAlert:(id)sender{
    [alertViewNewPro close];
}

-(IBAction)AddNewProject
{
    alertViewNewPro = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertViewNewPro setContainerView:[self createViewWithoutCmtPost]];
    
    // Modify the parameters
    
    [alertViewNewPro setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertViewNewPro setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView_, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView_ tag]);
        [alertView_ close];
    }];
    
    [alertViewNewPro setUseMotionEffects:true];
    
    // And launch the dialog
    [alertViewNewPro show];
}
- (UIView *)createViewWithoutCmtPost
{
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 140)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=11;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor whiteColor]CGColor];
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [topButton setTitle:@"Task" forState:UIControlStateNormal];
    //[topButton setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forState:UIControlStateNormal];
    [topButton setBackgroundColor:[UIColor redColor]];
    topButton.layer.cornerRadius=15;
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    
    addProjectTxt=[[UITextView alloc] initWithFrame:CGRectMake(0, 50,300,40)];
    addProjectTxt.text=@"Please enter project name";
    addProjectTxt.font=[UIFont systemFontOfSize:20];
    addProjectTxt.backgroundColor=[UIColor whiteColor];
    addProjectTxt.layer.cornerRadius=5;
    addProjectTxt.delegate=self;
    addProjectTxt.textColor=[UIColor lightGrayColor];
    [demoView addSubview:addProjectTxt];
    
    UIButton *register_ok_Button=[[UIButton alloc] initWithFrame:CGRectMake(0,95,145,40)];
    [register_ok_Button setTitle:@"OK" forState:UIControlStateNormal];
    [register_ok_Button addTarget:self
                           action:@selector(addButton:)
                 forControlEvents:UIControlEventTouchUpInside];
    [register_ok_Button setBackgroundColor:[UIColor blackColor]];
    register_ok_Button.tag=1;
    [demoView addSubview:register_ok_Button];
    
    UIButton *register_cancel_Button=[[UIButton alloc] initWithFrame:CGRectMake(150,95,145,40)];
    [register_cancel_Button setTitle:@"Cancel" forState:UIControlStateNormal];
    [register_cancel_Button addTarget:self
                           action:@selector(closeAlert:)
                 forControlEvents:UIControlEventTouchUpInside];
    [register_cancel_Button setBackgroundColor:[UIColor blackColor]];
    register_cancel_Button.tag=1;
    [demoView addSubview:register_cancel_Button];

    return demoView;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    addProjectTxt.text = @"";
    addProjectTxt.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(addProjectTxt.text.length == 0){
        addProjectTxt.textColor = [UIColor lightGrayColor];
        addProjectTxt.text = @"Comment....";
        [addProjectTxt resignFirstResponder];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([addProjectTxt.text isEqualToString:@""]) {
        addProjectTxt.text = @"Comment....";
        addProjectTxt.textColor = [UIColor lightGrayColor]; //optional
    }
    [addProjectTxt resignFirstResponder];
}

- (void)editButton:(id)sender
{    self.cancelButton.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = self.cancelButton;
    self.deleteButton.title = kDeleteAllTitle;
    self.navigationItem.leftBarButtonItem = self.deleteButton;
    [self.tableviewproject setEditing:YES animated:YES];
}
- (void)cancelButton:(id)sender
{
    //self.navigationItem.rightBarButtonItem = self.addButton;
    //self.deleteButton.title = kDeleteAllTitle;
    self.navigationItem.leftBarButtonItem = self.editButton;
    [self.tableviewproject setEditing:NO animated:YES];
}
- (void)deleteButton:(id)sender
{
    NSString *actionTitle = ([[self.tableviewproject indexPathsForSelectedRows] count] == 1) ?
    @"Are you sure you want to remove this item?" : @"Are you sure you want to remove these items?";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle delegate:self cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"OK" otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)addButton:(id)sender
{
    [self.tableviewproject beginUpdates];
    [self.dataArray addObject:addProjectTxt.text];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0]];
    [self.tableviewproject insertRowsAtIndexPaths:paths withRowAnimation:NO];
    [self.tableviewproject endUpdates];
    [self.tableviewproject scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:YES];
    self.editButton.enabled = (self.dataArray.count > 0) ? YES : NO;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableviewproject.isEditing)
    {
        NSArray *selectedRows = [self.tableviewproject indexPathsForSelectedRows];
        self.deleteButton.title = (selectedRows.count == 0) ?
        kDeleteAllTitle : [NSString stringWithFormat:kDeletePartialTitle, selectedRows.count];
    }
}

-(void)addProjectAction:(UIButton*)Btn{
    NSLog(@"Button tag in section %ld",(long)Btn.tag);
    ClientVO * clientVo=[appDelegate.allclientArray objectAtIndex:Btn.tag];
    if ([clientVo.activeclientStr isEqualToString:@"NO"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:@"This client is not active please active first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    TaskListViewController *taskVc;
    taskVc=[[TaskListViewController alloc] initWithNibName:@"TaskListViewController"bundle:nil];
    taskVc.clientNameselected=[[NSString alloc]init];
    taskVc.clientNameselected=clientVo.clientnameStr;
    taskVc.clientID=[clientVo.clientidStr intValue];
        taskVc.clientrateStr=clientVo.rate_hourly_daily_projectStr;
        taskVc.clienttaxStr=clientVo.client_taxStr;
        taskVc.clientvatStr=clientVo.client_vatStr;
        taskVc.clientcaloverTimeStr=clientVo.clientovertimecalformatStr;
        taskVc.clienttimehourStr=clientVo.clientovertimehourStr;
        taskVc.clientovertimeRateStr=clientVo.clientovertimerateStr;
        taskVc.defaultratevalue=clientVo.defaultratevalue;

    [self.navigationController pushViewController:taskVc animated:YES];
    }
}

-(void)DeleteActionClient:(UIButton*)Btn{
    NSLog(@"Button tag in section %ld",(long)Btn.tag);
    clientIndexvalue=Btn.tag;
    alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Are you sure to delete this client?" delegate:self cancelButtonTitle:@"Yes, Delete" otherButtonTitles:@"No", nil];
    
    [alert show];

}
-(void)DeleteActionProject:(UIButton*)Btn{
    NSLog(@"Button tag in section %ld",(long)Btn.tag);
    UITableViewCell *projectcell=(UITableViewCell *)[Btn superview];
    NSIndexPath *indexPath = [tableviewproject indexPathForCell: projectcell.superview];
    NSLog(@"indexpath section and row %d %d",indexPath.row,indexPath.section);
    projectIndexvalue=indexPath.row;
    projectindexsectonvalue=indexPath.section;
    alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Are you sure to delete this project?" delegate:self cancelButtonTitle:@"Yes, Sure" otherButtonTitles:@"No", nil];
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes, Delete"]){
        ClientVO * clientV=[[ClientVO alloc]init];
        clientV=[appDelegate.allclientArray objectAtIndex:clientIndexvalue];
        sqlite3_stmt *statement;
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"DELETE FROM ClientDetalisTable WHERE client_id='%@'",clientV.clientidStr];
        
        NSLog(@"Delete = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(databases, insert_stmt,
                           -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"event detail contestant position delete");
            [self getClientList];
        }else{
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        }

    }
    
    if([title isEqualToString:@"Yes, Sure"]){
        NSMutableArray * tempArray=[[NSMutableArray alloc]init];
        ClientVO * cliVo=[[ClientVO alloc]init];
        cliVo=[appDelegate.allclientArray objectAtIndex:projectindexsectonvalue];

        for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
           ProjectVO *  projVo=[appDelegate.allprojectArray objectAtIndex:count];
            if ([cliVo.clientidStr isEqualToString:projVo.client_id]) {
                [tempArray addObject:projVo];
            }
        }
        
        ProjectVO * proVos=[[ProjectVO alloc]init];
        proVos=[tempArray objectAtIndex:projectIndexvalue];

        sqlite3_stmt *statement;
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"DELETE FROM ProjectDetailsTable WHERE project_id='%@'",proVos.project_id];
        
        NSLog(@"Delete = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(databases, insert_stmt,
                           -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"event detail contestant position delete");
            [self getProjectList];
        }else{
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        }

    }
}
-(void)getClientList{
    char *dbChars ;
    appDelegate.allclientArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ClientDetalisTable"];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            ClientVO *clientVo=[[ClientVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                clientVo.clientidStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                clientVo.useridStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                clientVo.clientnameStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                clientVo.clientaddressStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                clientVo.usedefaultsettingStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 5);
            if(dbChars!=nil)
                clientVo.rate_hourly_daily_projectStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 6);
            if(dbChars!=nil)
                clientVo.client_taxStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 7);
            if(dbChars!=nil)
                clientVo.client_vatStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 8);
            if(dbChars!=nil)
                clientVo.clientovertimehourStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 9);
            if(dbChars!=nil)
                clientVo.clientovertimerateStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 10);
            if(dbChars!=nil)
                clientVo.clientovertimecalformatStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 11);
            if(dbChars!=nil)
                clientVo.activeclientStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 12);
            if(dbChars!=nil)
                clientVo.citrStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 13);
            if(dbChars!=nil)
                clientVo.stateStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 14);
            if(dbChars!=nil)
                clientVo.zipStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 15);
            if(dbChars!=nil)
                clientVo.countryStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 16);
            if(dbChars!=nil)
                clientVo.defaultratevalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)];

            [appDelegate.allclientArray addObject:clientVo];
        }
    }
    
    clientarray=[[NSMutableArray alloc]init ];
    arrayForBool=[[NSMutableArray alloc]init];
    tempclientArray=[[NSMutableArray alloc]init];
    sectionContentDict  = [[NSMutableDictionary alloc] init];
    if ([appDelegate.allclientArray count]>0) {
        
        for (int count=0; count<[appDelegate.allclientArray count]; count++) {
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            ClientVO *clientVos=[appDelegate.allclientArray objectAtIndex:count];
            [clientarray addObject:clientVos.clientidStr];
        }
        
        
        for (int count=0; count<[appDelegate.allclientArray count]; count++) {
            ClientVO * clientVO=[appDelegate.allclientArray objectAtIndex:count];
            NSMutableArray *temparray=[[NSMutableArray alloc]init];
            for (int countPro=0; countPro<[appDelegate.allprojectArray count]; countPro++) {
                ProjectVO * projectVO=[appDelegate.allprojectArray objectAtIndex:countPro];
                if ([clientVO.clientidStr isEqualToString:projectVO.client_id]) {
                    [temparray addObject:projectVO];
                }
                [sectionContentDict setValue:temparray forKey:[clientarray objectAtIndex:count]];
            }
        }
    }else{
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        
    }

    [tableviewproject reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableviewproject.isEditing)
    {
        NSArray *selectedRows = [self.tableviewproject indexPathsForSelectedRows];
        NSString *deleteButtonTitle = [NSString stringWithFormat:kDeletePartialTitle, selectedRows.count];
        
        if (selectedRows.count == sectionContentDict.count)
        {
            deleteButtonTitle = kDeleteAllTitle;
        }
        self.deleteButton.title = deleteButtonTitle;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [clientarray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        return [[sectionContentDict valueForKey:[clientarray objectAtIndex:section]] count];
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor clearColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10, 5,screenRect.size.height*0.80, screenRect.size.height*0.04)];

    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];

    UILabel *dot =[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    UIFont *customFontd = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];
    headerString.font = customFontd;

    dot.font = customFontd;
    [dot setTextColor:[UIColor grayColor]];
    ClientVO *cliVo=[appDelegate.allclientArray objectAtIndex:section];
     NSString *string=cliVo.clientnameStr;//O Change "Section"
    UIImageView *dashboardImage=[[UIImageView alloc]initWithFrame:CGRectMake(10,30,screenRect.size.width*0.06,screenRect.size.height*0.04)];

    if (!manyCells) {
        headerString.text = string;
        [dashboardImage setImage:[UIImage imageNamed:@"plusiconaddproject.PNG"]];

    }else{
        headerString.text = string;
        [dashboardImage setImage:[UIImage imageNamed:@"deleteproject.PNG"]];
    }
    [headerView addSubview:dashboardImage];

    dot.text=@"Project List";
    dot.textAlignment      = NSTextAlignmentLeft;
    dot.textColor          = [UIColor whiteColor];

    headerString.textAlignment      = NSTextAlignmentLeft;
    headerString.textColor          = [UIColor whiteColor];
    [headerView addSubview:headerString];
    [headerView addSubview:dot];

    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIButton *reportBtn = [[UIButton alloc] init];
    reportBtn.frame = CGRectMake(screenRect.size.width*0.92,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
    [reportBtn setBackgroundImage:[UIImage imageNamed:@"projectreporticon.PNG"] forState:UIControlStateNormal];
    [reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[reportBtn addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
    [tableView.tableHeaderView insertSubview:reportBtn atIndex:0];
    [headerView addSubview:reportBtn];
    
    UIButton *deleteBtn = [[UIButton alloc] init];
    deleteBtn.frame = CGRectMake(screenRect.size.width*0.85,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteproject.PNG"] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(DeleteActionClient:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag=section;
    [tableView.tableHeaderView insertSubview:deleteBtn atIndex:0];
    [headerView addSubview:deleteBtn];
    
    UIButton *activeBtn = [[UIButton alloc] init];
    activeBtn.frame = CGRectMake(screenRect.size.width*0.77,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
    if ([cliVo.activeclientStr isEqualToString:@"YES"] || cliVo.activeclientStr==nil) {
        [activeBtn setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateNormal];

    }else{
        [activeBtn setBackgroundImage:[UIImage imageNamed:@"inactive_.png"] forState:UIControlStateNormal];

    }
    [activeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activeBtn addTarget:self action:@selector(ClientActiveAction:) forControlEvents:UIControlEventTouchUpInside];
    activeBtn.tag=section;
    [tableView.tableHeaderView insertSubview:activeBtn atIndex:0];
    [headerView addSubview:activeBtn];

    UIButton *addprojectButton = [[UIButton alloc] init];
    addprojectButton.frame = CGRectMake(screenRect.size.width*0.69,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
    [addprojectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addprojectButton addTarget:self action:@selector(addProjectAction:) forControlEvents:UIControlEventTouchUpInside];
    [addprojectButton setBackgroundImage:[UIImage imageNamed:@"plusiconaddproject.PNG"] forState:UIControlStateNormal];
    addprojectButton.tag=section;
    [tableView.tableHeaderView insertSubview:addprojectButton atIndex:0];
    [headerView addSubview:addprojectButton];

    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    if (!manyCells) {
        [footer setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];

    }else{
        [footer setBackgroundColor:[UIColor clearColor]];

    }

    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.10;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int height=screenRect.size.height*0.07;
        return height;
    }
    return 1;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    if (!manyCells) {
       // cell.textLabel.text = @"click to enlarge";
    }
    else{
        
        NSMutableArray *content = [sectionContentDict valueForKey:[clientarray objectAtIndex:indexPath.section]];
        UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,0,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        ProjectVO *proVO=[content objectAtIndex:indexPath.row];
        [fieldLBls setText:proVO.project_name];
        fieldLBls.textAlignment=NSTextAlignmentLeft;
        fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
        fieldLBls.numberOfLines = 0;
        fieldLBls.textColor=[UIColor whiteColor];
        UIFont *customFontd = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.04];

        [fieldLBls setFont:customFontd];
        [cell.contentView addSubview:fieldLBls];

        proactiveBtn = [[UIButton alloc] init];
        proactiveBtn.frame = CGRectMake(screenRect.size.width*0.69,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
        proactiveBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18];
        if ([proVO.activeprojectStr isEqualToString:@"YES"] || proVO.activeprojectStr==nil) {
            [proactiveBtn setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateNormal];
        }else{
            [proactiveBtn setBackgroundImage:[UIImage imageNamed:@"inactive_.png"] forState:UIControlStateNormal];
        }
        [proactiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [proactiveBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        proactiveBtn.tag=indexPath.row;
        [cell.contentView addSubview:proactiveBtn];
        
        prodeleteBtn = [[UIButton alloc] init];
        prodeleteBtn.frame = CGRectMake(screenRect.size.width*0.77,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
        prodeleteBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18];
        [prodeleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [prodeleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteproject.PNG"] forState:UIControlStateNormal];
        [prodeleteBtn addTarget:self action:@selector(DeleteActionProject:) forControlEvents:UIControlEventTouchUpInside];
        prodeleteBtn.tag=indexPath.row;
        [cell.contentView addSubview:prodeleteBtn];
        
        proreportBtn = [[UIButton alloc] init];
        proreportBtn.frame = CGRectMake(screenRect.size.width*0.85,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
        proreportBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18];
        [proreportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [proreportBtn setBackgroundImage:[UIImage imageNamed:@"projectreporticon.PNG"] forState:UIControlStateNormal];
        [proreportBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        proreportBtn.tag=indexPath.row;
        [cell.contentView addSubview:proreportBtn];
        
        ExpensesBtn= [[UIButton alloc] init];
        ExpensesBtn.frame = CGRectMake(screenRect.size.width*0.925,7,screenRect.size.width*0.06,screenRect.size.height*0.04);
        ExpensesBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18];
        [ExpensesBtn setBackgroundImage:[UIImage imageNamed:@"expenses.PNG"] forState:UIControlStateNormal];
        [ExpensesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ExpensesBtn addTarget:self action:@selector(expencesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        ExpensesBtn.tag=indexPath.row;
        [cell.contentView addSubview:ExpensesBtn];

        int height=screenRect.size.height*0.067;

        UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,height,screenRect.size.width,6)];
        [overlypersonImage setImage:[UIImage imageNamed:@"background.PNG"]];
        [cell.contentView addSubview:overlypersonImage];

    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)ClientActiveAction:(UIButton *)sender{
    ClientVO * cliVo=[[ClientVO alloc]init];
    cliVo=[appDelegate.allclientArray objectAtIndex:sender.tag];
    if ([cliVo.activeclientStr isEqualToString:@"YES"]) {
        cliVo.activeclientStr=@"NO";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expense"
                                                        message:@"Client marked inactive successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else {
        cliVo.activeclientStr=@"YES";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:@"Client marked active successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    [self updateActionsClient:cliVo];

}
-(void)updateActionsClient:(ClientVO *)cliVO{
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL= [NSString stringWithFormat:
                @"update ClientDetalisTable set active_client=\"%@\" where client_id = %@",cliVO.activeclientStr,cliVO.clientidStr];
    
    NSLog(@"insertSQL = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(databases, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail updated");
        
        [tableviewproject reloadData];
    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
    }
    
}

-(IBAction)redioBtnAction:(UIButton *)sender{
    NSLog(@"Button tag in section %ld",(long)sender.tag);
    UITableViewCell *projectcell=(UITableViewCell *)[sender superview];
    NSIndexPath *indexPath = [tableviewproject indexPathForCell: projectcell.superview];
    NSLog(@"indexpath section and row %d %d",indexPath.row,indexPath.section);
    NSMutableArray * tempArray=[[NSMutableArray alloc]init];
    ClientVO * cliVo=[[ClientVO alloc]init];
    cliVo=[appDelegate.allclientArray objectAtIndex:indexPath.section];
    
    for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
        ProjectVO *  projVo=[appDelegate.allprojectArray objectAtIndex:count];
        if ([cliVo.clientidStr isEqualToString:projVo.client_id]) {
            [tempArray addObject:projVo];
        }
    }
    ProjectVO * proVos=[[ProjectVO alloc]init];
    proVos=[tempArray objectAtIndex:indexPath.row];
    for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
        ProjectVO *  projVo=[appDelegate.allprojectArray objectAtIndex:count];
        if ([projVo.project_id isEqualToString:proVos.project_id]) {
            if ([projVo.activeprojectStr isEqualToString:@"YES"]) {
                 projVo.activeprojectStr=@"NO";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                                message:@"Project marked inactive successfully."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

            }else {
                 projVo.activeprojectStr=@"YES";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                                message:@"Project marked active successfully."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

            }
            [self updateActions:projVo];
        }
    }
   

}
-(void)updateActions:(ProjectVO *)proVO{
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL= [NSString stringWithFormat:
                @"update ProjectDetailsTable set active_project=\"%@\" where project_id = %@",proVO.activeprojectStr,proVO.project_id];
    
    NSLog(@"insertSQL = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(databases, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail updated");
        
        [tableviewproject reloadData];
    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
    }
    
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListViewController *taskVc;
        taskVc=[[TaskListViewController alloc] initWithNibName:@"TaskListViewController"bundle:nil];
    [self.navigationController pushViewController:taskVc animated:YES];

}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableviewproject reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)expencesBtnAction:(UIButton *)Btn{
    NSLog(@"Button tag in section %ld",(long)Btn.tag);
    UITableViewCell *projectcell=(UITableViewCell *)[Btn superview];
    NSIndexPath *indexPath = [tableviewproject indexPathForCell: projectcell.superview];
    NSLog(@"indexpath section and row %d %d",indexPath.row,indexPath.section);
    NSMutableArray * tempArray=[[NSMutableArray alloc]init];
    ClientVO * cliVo=[[ClientVO alloc]init];
    cliVo=[appDelegate.allclientArray objectAtIndex:indexPath.section];
    
    for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
        ProjectVO *  projVo=[appDelegate.allprojectArray objectAtIndex:count];
        if ([cliVo.clientidStr isEqualToString:projVo.client_id]) {
            [tempArray addObject:projVo];
        }
    }
    ProjectVO * proVos=[[ProjectVO alloc]init];
    proVos=[tempArray objectAtIndex:indexPath.row];
    if ([proVos.activeprojectStr isEqualToString:@"NO"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:@"This project is not active please active first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }else  if ([cliVo.activeclientStr isEqualToString:@"NO"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                        message:@"This client is not active please active first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else
    {
    ExpensesListViewController *expencesList=[[ExpensesListViewController alloc]initWithNibName:@"ExpensesListViewController" bundle:nil];
    expencesList.clientid=[cliVo.clientidStr intValue];
    expencesList.projectid=[proVos.project_id intValue];
    [self.navigationController pushViewController:expencesList animated:YES];
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
