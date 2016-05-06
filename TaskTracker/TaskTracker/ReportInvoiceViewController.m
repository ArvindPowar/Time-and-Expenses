//
//  ReportInvoiceViewController.m
//  TaskTracker
//
//  Created by arvind on 3/16/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ReportInvoiceViewController.h"
#import "UIColor+Expanded.h"
#import "DashboardHomeViewController.h"
#import "ExpensesViewController.h"
#import "ProjectListViewController.h"
#import "InvoiceViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PreferencesViewController.h"
#import "ProjectVO.h"
#import "PMCalendar.h"
#import "TaskVO.h"

@interface ReportInvoiceViewController ()
@property (nonatomic, strong) PMCalendarController *pmCC;

@end

@implementation ReportInvoiceViewController
@synthesize pmCC;
@synthesize periodLabel;

@synthesize allprojectBtn,selectprojectBtn,dateBtn,lastweekBtn,lastmonthBtn,lastyearBtn,viewscreenBtn,invocieSpedateBtn,invoiceLastweekBtn,invoicelastmonthBtn,emailpdfBtn,isMenuVisible,settingBtn,overlayView,menuNameArray,menuNameButton,numberofwekBtn,lastwekBtn,listofwekBtn,islistviewVisible,repostListview,reportarrayData,lastweekBtns,isselectprojetvisible,projectListview,porjectListArray,selectproBtn,selectProjectscrollview,overlyScrollview,appDelegate,displayreportalertView,tableview,selectprojectID,databases,pasueTime,breakTime,ratehourly_daily_project,project_tax,project_vat,projectovertimehour,projectovertimerate,projectdaily_weekly,defaultratevalue,scrollView;
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
    
    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15,screenRect.size.width,35)];
    dashboardLbl.text = @"Report";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];
    dashboardLbl.font = customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];
    
    
    selectproBtn=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.30, screenRect.size.width-60,screenRect.size.height*0.06)];
    [selectproBtn.titleLabel setFont:customFontds];
    [selectproBtn setTitle:@"  Select Project" forState:UIControlStateNormal];
    [selectproBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectproBtn.layer.cornerRadius = 6.0f;
    selectproBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [selectproBtn setBackgroundImage:[UIImage imageNamed:@"reportslistitem_background.PNG"] forState:UIControlStateNormal];
    [selectproBtn addTarget:self action:@selector(projectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectproBtn];
    
    
    UILabel *specDatereportLbl = [[UILabel alloc] init];
    [specDatereportLbl setFrame:CGRectMake(30, screenRect.size.height*0.40, screenRect.size.width*0.70, screenRect.size.height*0.06)];
    specDatereportLbl.textAlignment = NSTextAlignmentLeft;
    [specDatereportLbl setText:@"Specific Date Report"];
    specDatereportLbl.textColor=[UIColor whiteColor];
    specDatereportLbl.font =customFontds;
    [self.view addSubview:specDatereportLbl];
    
    UIButton *calendarBtns=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.40, 35,35)];
    calendarBtns.layer.cornerRadius = 6.0f;
    calendarBtns.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [calendarBtns setBackgroundImage:[UIImage imageNamed:@"datereporticon.PNG"] forState:UIControlStateNormal];
    [calendarBtns addTarget:self action:@selector(showCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calendarBtns];

    
   lastweekBtns=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.50, screenRect.size.width-60,screenRect.size.height*0.06)];
    [lastweekBtns.titleLabel setFont:customFontds];
    [lastweekBtns setTitle:@"  Last Week" forState:UIControlStateNormal];
    [lastweekBtns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastweekBtns.layer.cornerRadius = 6.0f;
    lastweekBtns.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lastweekBtns setBackgroundImage:[UIImage imageNamed:@"reportslistitem_background.PNG"] forState:UIControlStateNormal];
    [lastweekBtns addTarget:self action:@selector(actionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastweekBtns];
    
    UIFont *customFontdss = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.03];

    UILabel *detailsLbl = [[UILabel alloc] init];
    [detailsLbl setFrame:CGRectMake(0, screenRect.size.height*0.75, screenRect.size.width, screenRect.size.height*0.06)];
    detailsLbl.textAlignment = NSTextAlignmentCenter;
    [detailsLbl setText:@"(Report generated here)"];
    detailsLbl.textColor=[UIColor whiteColor];
    detailsLbl.font =customFontdss;
    [self.view addSubview:detailsLbl];

    UILabel *detailsLbl2 = [[UILabel alloc] init];
    [detailsLbl2 setFrame:CGRectMake(0, screenRect.size.height*0.80, screenRect.size.width, screenRect.size.height*0.06)];
    detailsLbl2.textAlignment = NSTextAlignmentCenter;
    [detailsLbl2 setText:@"REPORT GENERATED IN XML,CSV,PDF"];
    detailsLbl2.textColor=[UIColor whiteColor];
    detailsLbl2.font =customFontdss;
    [self.view addSubview:detailsLbl2];

    UIButton *emailinvoiceBtn=[[UIButton alloc]initWithFrame:CGRectMake(60,screenRect.size.height-75, screenRect.size.width-120,screenRect.size.height*0.06)];
    [emailinvoiceBtn.titleLabel setFont:[UIFont fontWithName:@"Brandon_med" size:20]];
    [emailinvoiceBtn setTitle:@"Generate Report" forState:UIControlStateNormal];
    [emailinvoiceBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    emailinvoiceBtn.layer.cornerRadius = 6.0f;
    emailinvoiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [emailinvoiceBtn setBackgroundColor:[UIColor whiteColor]];
    [emailinvoiceBtn addTarget:self action:@selector(GenerateReportAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailinvoiceBtn];

    
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
    
    
    reportarrayData = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"  Last Week",@"  Last Month",@"  Last Year",@"  Everything",nil]];
    repostListview = [[UIView alloc] initWithFrame:CGRectMake(40,screenRect.size.height*0.565, screenRect.size.width-80,screenRect.size.height*0.20)];
    repostListview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    repostListview.alpha = 0.95;
    int yValuelist=10;
    for (int count=0; count<[reportarrayData count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-8,screenRect.size.width-120,2)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [repostListview addSubview:borderImg];
        
        UIButton *listmenu=[[UIButton alloc] initWithFrame:CGRectMake(10, yValuelist,screenRect.size.width*0.60, screenRect.size.height*0.06)];
        [listmenu setTitle:[reportarrayData objectAtIndex:count] forState:UIControlStateNormal];
        listmenu.tag=count;
        listmenu.titleLabel.font= [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        [listmenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [listmenu setBackgroundColor:[UIColor clearColor]];
        [listmenu addTarget:self action:@selector(dropDownListAction:) forControlEvents:UIControlEventTouchUpInside];
        listmenu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [repostListview addSubview:listmenu];
        
        yValuelist=yValuelist+screenRect.size.height*0.06;
    }
    UIImageView *borderImglastList=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-5,screenRect.size.width-120,2)];
    [borderImglastList setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    [repostListview addSubview:borderImglastList];
    repostListview.layer.cornerRadius = 5;
    repostListview.layer.masksToBounds = YES;
    [self.view addSubview:repostListview];
    repostListview.hidden=true;
    islistviewVisible=false;
    
    
     porjectListArray= [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"  Last Week",@"  Last Month",@"  Last Year",@"  Everything",nil]];
    selectProjectscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(40, screenRect.size.height*0.365, screenRect.size.width-80,screenRect.size.height*0.25)];

    projectListview = [[UIView alloc] initWithFrame:CGRectMake(0,0, screenRect.size.width-80,150)];
    projectListview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    projectListview.alpha = 0.95;
    int yValueprolist=10;
    for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValueprolist-8,screenRect.size.width-120,2)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [projectListview addSubview:borderImg];
        
        UIButton *listmenu=[[UIButton alloc] initWithFrame:CGRectMake(10, yValueprolist,screenRect.size.width*0.60, screenRect.size.height*0.06)];
        ProjectVO *projectVO=[appDelegate.allprojectArray objectAtIndex:count];
        [listmenu setTitle:projectVO.project_name forState:UIControlStateNormal];
        listmenu.tag=count;
        listmenu.titleLabel.font= [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        [listmenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [listmenu setBackgroundColor:[UIColor clearColor]];
        [listmenu addTarget:self action:@selector(dropDownProjectListAction:) forControlEvents:UIControlEventTouchUpInside];
        listmenu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [projectListview addSubview:listmenu];
        
        yValueprolist=yValueprolist+screenRect.size.height*0.06;
    }
    UIImageView *borderImgprojectList=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValueprolist-5,screenRect.size.width-120,2)];
    [borderImgprojectList setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    [projectListview addSubview:borderImgprojectList];
    projectListview.layer.cornerRadius = 5;
    projectListview.layer.masksToBounds = YES;
    [self.selectProjectscrollview addSubview:projectListview];
    [self.view addSubview:selectProjectscrollview];
    selectProjectscrollview.contentSize = CGSizeMake(screenRect.size.width-80,yValuelist+50);
    selectProjectscrollview.scrollEnabled=YES;
    selectProjectscrollview.hidden=YES;
    projectListview.hidden=true;
    isselectprojetvisible=false;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapOnView:(UITapGestureRecognizer *)sender
{
    [self.pmCC dismissCalendarAnimated:NO];
    repostListview.hidden=true;
    islistviewVisible=false;
    projectListview.hidden=true;
    isselectprojetvisible=false;
    selectProjectscrollview.hidden=YES;
}
-(IBAction)actionButtonClick{
    if(!islistviewVisible)
    {
        projectListview.hidden=true;
        isselectprojetvisible=false;
        selectProjectscrollview.hidden=YES;

        repostListview.hidden=false;
        islistviewVisible=true;
    }else{
        repostListview.hidden=true;
        islistviewVisible=false;
    }
}
-(void)dropDownListAction:(UIButton *)button{
    int tags=button.tag;
    [lastweekBtns setTitle:[reportarrayData objectAtIndex:tags] forState:UIControlStateNormal];
    repostListview.hidden=true;
    islistviewVisible=false;
}
-(IBAction)projectButtonClick{
    if(!isselectprojetvisible)
    {
        repostListview.hidden=true;
        islistviewVisible=false;
        projectListview.hidden=false;
        isselectprojetvisible=true;
        selectProjectscrollview.hidden=NO;
    }else{
        projectListview.hidden=true;
        isselectprojetvisible=false;
        selectProjectscrollview.hidden=YES;
    }
}
-(void)dropDownProjectListAction:(UIButton *)button{
    int tags=button.tag;
    ProjectVO *projectVO=[appDelegate.allprojectArray objectAtIndex:tags];
    NSString * testStr=[[NSString alloc]init];
    testStr=[NSString stringWithFormat:@"  %@",projectVO.project_name];//image white sapce
    [selectproBtn setTitle:testStr forState:UIControlStateNormal];
    selectprojectID=[projectVO.project_id intValue];
    ratehourly_daily_project=projectVO.ratehourly_daily_project;
    project_tax=projectVO.project_tax;
    project_vat=projectVO.project_vat;
    projectovertimehour=projectVO.projectovertimehour;
    projectovertimerate=projectVO.projectovertimerate;
    projectdaily_weekly=projectVO.projectdaily_weekly;
    defaultratevalue=projectVO.defaultratevalue;
    
    selectProjectscrollview.hidden=YES;
    projectListview.hidden=true;
    isselectprojetvisible=false;
    [self getTaskdata];
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

-(void)getTaskdata{
    sqlite3_open([[self getDestPath] UTF8String], &databases);
    char *dbChars ;
    appDelegate.projecttaskArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectTaskTable where projectid=%d",selectprojectID];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            TaskVO *taskVo=[[TaskVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                taskVo.taskID=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                taskVo.taskprojectid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                taskVo.taskstarttime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                taskVo.taskendtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                taskVo.taskdurationtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            
            [appDelegate.projecttaskArray addObject:taskVo];
        }
    }
 
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    
}

-(IBAction)menuScreenAction{
    repostListview.hidden=true;
    selectProjectscrollview.hidden=YES;

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

-(void)calendarBtnAction{
    repostListview.hidden=true;
    islistviewVisible=false;
    projectListview.hidden=true;
    isselectprojetvisible=false;
    selectProjectscrollview.hidden=YES;

   // CalendarViewController * Calendar;
    //    Calendar = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
    //[self.navigationController pushViewController:Calendar animated:NO];

}

- (void)GenerateReportAction
{
    // Here we need to pass a full frame
    displayreportalertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [displayreportalertView setContainerView:[self reportAlert]];
    // Modify the parameters
    [displayreportalertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [displayreportalertView setUseMotionEffects:true];
    // And launch the dialog
    [displayreportalertView show];
}
-(UIView *)reportAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont *customFontdt = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.035];

    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,300,395)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UILabel *projectName=[[UILabel alloc]initWithFrame:CGRectMake(0,0,300,30)];
    projectName.text = selectproBtn.titleLabel.text;
    projectName.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.05];
    projectName.font = customFontds;
    projectName.textAlignment = NSTextAlignmentCenter;
    [demoView addSubview:projectName];
    
    UIImageView *overlypersonImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,30,1080,1)];
    [overlypersonImage setBackgroundColor:[UIColor whiteColor]];
    [demoView addSubview:overlypersonImage];

    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,33, screenRect.size.width,340)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    int height=0;
    int height2=20;
    UIImageView *overlypersonImage1=[[UIImageView alloc]initWithFrame:CGRectMake(0,height2-2,1080,1)];
    [overlypersonImage1 setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:overlypersonImage1];

    UILabel *TaskLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,height,100,20)];
    TaskLbl.text = @"Task IN/OUT Date";
    TaskLbl.textColor=[UIColor whiteColor];
    TaskLbl.font = customFontdt;
    TaskLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskLbl];
    UILabel *TaskdurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(110,height,100,20)];
    TaskdurationLbl.text = @"Task duration";
    TaskdurationLbl.textColor=[UIColor whiteColor];
    TaskdurationLbl.font = customFontdt;
    TaskdurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskdurationLbl];
    UILabel *PausedurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(220,height,100,20)];
    PausedurationLbl.text = @"Pause duration";
    PausedurationLbl.textColor=[UIColor whiteColor];
    PausedurationLbl.font = customFontdt;
    PausedurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:PausedurationLbl];
    UILabel *breakdurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(330,height,100,20)];
    breakdurationLbl.text = @"break duration";
    breakdurationLbl.textColor=[UIColor whiteColor];
    breakdurationLbl.font = customFontdt;
    breakdurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:breakdurationLbl];
    
    UILabel *normalLBL=[[UILabel alloc]initWithFrame:CGRectMake(440,00,100,20)];
    normalLBL.text = @"Normal hours cost";
    normalLBL.textColor=[UIColor whiteColor];
    normalLBL.font = customFontdt;
    normalLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:normalLBL];
    UILabel *overhrsLBL=[[UILabel alloc]initWithFrame:CGRectMake(550,0,100,20)];
    overhrsLBL.text = @"Over hours cost";
    overhrsLBL.textColor=[UIColor whiteColor];
    overhrsLBL.font = customFontdt;
    overhrsLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:overhrsLBL];
    UILabel *taxLBL=[[UILabel alloc]initWithFrame:CGRectMake(660,0,100,20)];
    taxLBL.text = @"Tax price";
    taxLBL.textColor=[UIColor whiteColor];
    taxLBL.font = customFontdt;
    taxLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:taxLBL];
    UILabel *vatLBL=[[UILabel alloc]initWithFrame:CGRectMake(770,0,100,20)];
    vatLBL.text = @"Vat price";
    vatLBL.textColor=[UIColor whiteColor];
    vatLBL.font = customFontdt;
    vatLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:vatLBL];
    UILabel *totalLbl=[[UILabel alloc]initWithFrame:CGRectMake(880,0,100,20)];
    totalLbl.text = @"Total amount";
    totalLbl.textColor=[UIColor whiteColor];
    totalLbl.font = customFontdt;
    totalLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:totalLbl];
    for (int count=0; count<[appDelegate.projecttaskArray count]; count++) {

    TaskVO *taskVo=[appDelegate.projecttaskArray objectAtIndex:count];
    pasueTime=0;
    [self getPausedata:[taskVo.taskID intValue]];
    
    UILabel *TaskindateLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,height2,100,30)];
    TaskindateLbl.text =[NSString stringWithFormat:@"%@ - %@",taskVo.taskstarttime,taskVo.taskendtime];
    TaskindateLbl.lineBreakMode = UILineBreakModeWordWrap;
    TaskindateLbl.numberOfLines = 0;
    TaskindateLbl.textColor=[UIColor whiteColor];
    TaskindateLbl.font = customFontdt;
    TaskindateLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskindateLbl];
    
        
    UILabel *TaskdurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(110,height2,100,20)];
    TaskdurdisplayLbl.text = taskVo.taskdurationtime;
    TaskdurdisplayLbl.textColor=[UIColor whiteColor];
    TaskdurdisplayLbl.font = customFontdt;
    TaskdurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskdurdisplayLbl];
    
    
    
    
    UILabel *PausedurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(220,height2,100,20)];
    PausedurdisplayLbl.text = [NSString stringWithFormat:@"%d mins",pasueTime];
    PausedurdisplayLbl.textColor=[UIColor whiteColor];
    PausedurdisplayLbl.font = customFontdt;
    PausedurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:PausedurdisplayLbl];
    
    
    
    breakTime=0;
    [self getBreakdata:[taskVo.taskID intValue]];
    
    UILabel *breakdurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(330,height2,100,20)];
    breakdurdisplayLbl.text = [NSString stringWithFormat:@"%d mins",breakTime];
    breakdurdisplayLbl.textColor=[UIColor whiteColor];
    breakdurdisplayLbl.font = customFontdt;
    breakdurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:breakdurdisplayLbl];

        NSArray* allData1 = [taskVo.taskdurationtime componentsSeparatedByString: @"-"];
        if ([allData1 count]>1) {
            
            
            NSString *stringhrs1 = [allData1 objectAtIndex:0];
            NSArray* allData2 = [stringhrs1 componentsSeparatedByString: @" "];
            int taskhrs = [[allData2 objectAtIndex:0] intValue];
            
            if (taskhrs!=0) {
                taskhrs=taskhrs*60;
            }
            NSString *stringmin1 = [allData1 objectAtIndex:1];
            NSArray* allDatamin2 = [stringmin1 componentsSeparatedByString: @" "];
            float taskmin = [[allDatamin2 objectAtIndex:1] intValue];
            float totolhrsmin=taskhrs+taskmin;
            
            float overtimehr=[projectovertimehour intValue];
            if (overtimehr!=0) {
                overtimehr=overtimehr*60;
            }
            float normalhrs=0,overtimehrvalue=0;
            float normalhrscost=0,overttimehrscost=0;
            float vat=0,tax=0,semitotal;
            
            if (totolhrsmin>overtimehr) {
                normalhrs=totolhrsmin-overtimehr;
                overtimehrvalue=totolhrsmin-normalhrs;
                float val=[defaultratevalue intValue];
                normalhrscost=(normalhrs*val)/60;
                NSArray* allDatarate = [projectovertimerate componentsSeparatedByString: @" "];
                float overtimerate = [[allDatarate objectAtIndex:0] intValue];
                overttimehrscost=(overtimehrvalue*(overtimerate*val))/60;
                
            }else{
                normalhrs=totolhrsmin;
                float val=[defaultratevalue intValue];
                normalhrscost=(normalhrs*val)/60;
            }
            
            semitotal=normalhrscost+overttimehrscost;
            float protax=[project_tax intValue];
            tax=semitotal+(semitotal*protax)/100;
            semitotal=semitotal+(semitotal*protax)/100;
            
            float provat=[project_vat intValue];
            vat=semitotal+(semitotal*provat)/100;
            semitotal=semitotal+(semitotal*provat)/100;
            
            
            UILabel *normal=[[UILabel alloc]initWithFrame:CGRectMake(440,height2,100,20)];
            normal.text = [NSString stringWithFormat:@"%0.2f",normalhrscost];
            normal.textColor=[UIColor whiteColor];
            normal.font = customFontdt;
            normal.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:normal];
            
                       
            UILabel *overhrs=[[UILabel alloc]initWithFrame:CGRectMake(550,height2,100,20)];
            overhrs.text = [NSString stringWithFormat:@"%0.2f",overttimehrscost];
            overhrs.textColor=[UIColor whiteColor];
            overhrs.font = customFontdt;
            overhrs.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:overhrs];
            
                        
            UILabel *taxpriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(660,height2,100,20)];
            taxpriceLBL.text = [NSString stringWithFormat:@"%0.2f",tax];
            taxpriceLBL.textColor=[UIColor whiteColor];
            taxpriceLBL.font = customFontdt;
            taxpriceLBL.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:taxpriceLBL];
            
            UILabel *vatprice=[[UILabel alloc]initWithFrame:CGRectMake(770,height2,100,20)];
            vatprice.text = [NSString stringWithFormat:@"%0.2f",vat];
            vatprice.textColor=[UIColor whiteColor];
            vatprice.font = customFontdt;
            vatprice.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:vatprice];
            
            UILabel *totalprice=[[UILabel alloc]initWithFrame:CGRectMake(880,height2,100,20)];
            totalprice.text = [NSString stringWithFormat:@"%0.2f",semitotal];
            totalprice.textColor=[UIColor whiteColor];
            totalprice.font = customFontdt;
            totalprice.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:totalprice];
            
        }


        height=height+40;
        height2=height2+40;
        UIImageView *overlypersonImage2=[[UIImageView alloc]initWithFrame:CGRectMake(0,height2,1080,1)];
        [overlypersonImage2 setBackgroundColor:[UIColor whiteColor]];
        [scrollView addSubview:overlypersonImage2];

    }
    [demoView addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(screenRect.size.width*3.3,height2);
    scrollView.scrollEnabled=YES;

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,348,300,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:cancelBtn];
    return demoView;
    
}
-(void)closeAlert:(id)sender{
    [displayreportalertView close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPausedata:(int)taskid{
    sqlite3_open([[self getDestPath] UTF8String], &databases);
    char *dbChars ;
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectPauseTable where projecttaskid=%d",taskid];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            TaskVO *taskVo=[[TaskVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                taskVo.taskID=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                taskVo.taskprojectid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                taskVo.taskstarttime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                taskVo.taskendtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                taskVo.taskdurationtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            pasueTime=pasueTime + [taskVo.taskdurationtime intValue];
        }
    }
    
}
-(void)getBreakdata:(int)taskid{
    sqlite3_open([[self getDestPath] UTF8String], &databases);
    char *dbChars ;
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectBreakTable where projecttaskid=%d",taskid];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            TaskVO *taskVo=[[TaskVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                taskVo.taskID=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                taskVo.taskprojectid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                taskVo.taskstarttime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                taskVo.taskendtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                taskVo.taskdurationtime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            breakTime=breakTime + [taskVo.taskdurationtime intValue];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegate.projecttaskArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.clipsToBounds = YES;
    UIColor *color = [UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *cellView=[[UIView alloc] initWithFrame:CGRectMake(0, 1.5, screenRect.size.width, screenRect.size.height*0.15)];
    cellView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    UIFont *customFontdt = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.03];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height*0.15)];
    [scrollView setBackgroundColor:[UIColor clearColor]];

    TaskVO *taskVo=[appDelegate.projecttaskArray objectAtIndex:indexPath.row];
    pasueTime=0;
    [self getPausedata:[taskVo.taskID intValue]];
    UILabel *TaskLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,0,100,20)];
    TaskLbl.text = @"Task IN/OUT Date";
    TaskLbl.textColor=[UIColor whiteColor];
    TaskLbl.font = customFontdt;
    TaskLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskLbl];
    
    UILabel *TaskindateLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,20,100,30)];
    TaskindateLbl.text =[NSString stringWithFormat:@"%@ - %@",taskVo.taskstarttime,taskVo.taskendtime];
    TaskindateLbl.lineBreakMode = UILineBreakModeWordWrap;
    TaskindateLbl.numberOfLines = 0;
    TaskindateLbl.textColor=[UIColor whiteColor];
    TaskindateLbl.font = customFontdt;
    TaskindateLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskindateLbl];
    
    UILabel *TaskdurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(110,0,100,20)];
    TaskdurationLbl.text = @"Task duration";
    TaskdurationLbl.textColor=[UIColor whiteColor];
    TaskdurationLbl.font = customFontdt;
    TaskdurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskdurationLbl];
    
    UILabel *TaskdurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(110,20,100,20)];
    TaskdurdisplayLbl.text = taskVo.taskdurationtime;
    TaskdurdisplayLbl.textColor=[UIColor whiteColor];
    TaskdurdisplayLbl.font = customFontdt;
    TaskdurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:TaskdurdisplayLbl];
    
    
    UILabel *PausedurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(220,0,100,20)];
    PausedurationLbl.text = @"Pause duration";
    PausedurationLbl.textColor=[UIColor whiteColor];
    PausedurationLbl.font = customFontdt;
    PausedurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:PausedurationLbl];
    
    UILabel *PausedurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(220,20,100,20)];
    PausedurdisplayLbl.text = [NSString stringWithFormat:@"%d mins",pasueTime];
    PausedurdisplayLbl.textColor=[UIColor whiteColor];
    PausedurdisplayLbl.font = customFontdt;
    PausedurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:PausedurdisplayLbl];
    
    
    UILabel *breakdurationLbl=[[UILabel alloc]initWithFrame:CGRectMake(330,0,100,20)];
    breakdurationLbl.text = @"break duration";
    breakdurationLbl.textColor=[UIColor whiteColor];
    breakdurationLbl.font = customFontdt;
    breakdurationLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:breakdurationLbl];
    breakTime=0;
    [self getBreakdata:[taskVo.taskID intValue]];

    UILabel *breakdurdisplayLbl=[[UILabel alloc]initWithFrame:CGRectMake(330,20,100,20)];
    breakdurdisplayLbl.text = [NSString stringWithFormat:@"%d mins",breakTime];
    breakdurdisplayLbl.textColor=[UIColor whiteColor];
    breakdurdisplayLbl.font = customFontdt;
    breakdurdisplayLbl.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:breakdurdisplayLbl];

    NSArray* allData1 = [taskVo.taskdurationtime componentsSeparatedByString: @"-"];
    if ([allData1 count]>1) {
        
    
    NSString *stringhrs1 = [allData1 objectAtIndex:0];
    NSArray* allData2 = [stringhrs1 componentsSeparatedByString: @" "];
    int taskhrs = [[allData2 objectAtIndex:0] intValue];
    
    if (taskhrs!=0) {
        taskhrs=taskhrs*60;
    }
    NSString *stringmin1 = [allData1 objectAtIndex:1];
    NSArray* allDatamin2 = [stringmin1 componentsSeparatedByString: @" "];
    float taskmin = [[allDatamin2 objectAtIndex:1] intValue];
    float totolhrsmin=taskhrs+taskmin;
    
    float overtimehr=[projectovertimehour intValue];
    if (overtimehr!=0) {
        overtimehr=overtimehr*60;
    }
    float normalhrs=0,overtimehrvalue=0;
    float normalhrscost=0,overttimehrscost=0;
        float vat=0,tax=0,semitotal;

    if (totolhrsmin>overtimehr) {
        normalhrs=totolhrsmin-overtimehr;
        overtimehrvalue=totolhrsmin-normalhrs;
        float val=[defaultratevalue intValue];
        normalhrscost=(normalhrs*val)/60;
        NSArray* allDatarate = [projectovertimerate componentsSeparatedByString: @" "];
        float overtimerate = [[allDatarate objectAtIndex:0] intValue];
        overttimehrscost=(overtimehrvalue*(overtimerate*val))/60;

    }else{
        normalhrs=totolhrsmin;
        float val=[defaultratevalue intValue];
        normalhrscost=(normalhrs*val)/60;
    }
    
        semitotal=normalhrscost+overttimehrscost;
        float protax=[project_tax intValue];
        tax=semitotal+(semitotal*protax)/100;
        semitotal=semitotal+(semitotal*protax)/100;

        float provat=[project_vat intValue];
        vat=semitotal+(semitotal*provat)/100;
        semitotal=semitotal+(semitotal*provat)/100;

    UILabel *normalLBL=[[UILabel alloc]initWithFrame:CGRectMake(440,00,100,20)];
    normalLBL.text = @"Normal hours cost";
    normalLBL.textColor=[UIColor whiteColor];
    normalLBL.font = customFontdt;
    normalLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:normalLBL];

    UILabel *normal=[[UILabel alloc]initWithFrame:CGRectMake(440,20,100,20)];
    normal.text = [NSString stringWithFormat:@"%0.2f",normalhrscost];
    normal.textColor=[UIColor whiteColor];
    normal.font = customFontdt;
    normal.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:normal];

    UILabel *overhrsLBL=[[UILabel alloc]initWithFrame:CGRectMake(550,0,100,20)];
    overhrsLBL.text = @"Over hours cost";
    overhrsLBL.textColor=[UIColor whiteColor];
    overhrsLBL.font = customFontdt;
    overhrsLBL.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:overhrsLBL];

    UILabel *overhrs=[[UILabel alloc]initWithFrame:CGRectMake(550,20,100,20)];
    overhrs.text = [NSString stringWithFormat:@"%0.2f",overttimehrscost];
    overhrs.textColor=[UIColor whiteColor];
    overhrs.font = customFontdt;
    overhrs.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:overhrs];
        
        UILabel *taxLBL=[[UILabel alloc]initWithFrame:CGRectMake(660,0,100,20)];
        taxLBL.text = @"Tax price";
        taxLBL.textColor=[UIColor whiteColor];
        taxLBL.font = customFontdt;
        taxLBL.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:taxLBL];
        
        UILabel *taxpriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(660,20,100,20)];
        taxpriceLBL.text = [NSString stringWithFormat:@"%0.2f",tax];
        taxpriceLBL.textColor=[UIColor whiteColor];
        taxpriceLBL.font = customFontdt;
        taxpriceLBL.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:taxpriceLBL];

        UILabel *vatLBL=[[UILabel alloc]initWithFrame:CGRectMake(770,0,100,20)];
        vatLBL.text = @"Vat price";
        vatLBL.textColor=[UIColor whiteColor];
        vatLBL.font = customFontdt;
        vatLBL.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:vatLBL];
        
        UILabel *vatprice=[[UILabel alloc]initWithFrame:CGRectMake(770,20,100,20)];
        vatprice.text = [NSString stringWithFormat:@"%0.2f",vat];
        vatprice.textColor=[UIColor whiteColor];
        vatprice.font = customFontdt;
        vatprice.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:vatprice];

        UILabel *totalLbl=[[UILabel alloc]initWithFrame:CGRectMake(880,0,100,20)];
        totalLbl.text = @"Total amount";
        totalLbl.textColor=[UIColor whiteColor];
        totalLbl.font = customFontdt;
        totalLbl.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:totalLbl];
        
        UILabel *totalprice=[[UILabel alloc]initWithFrame:CGRectMake(880,20,100,20)];
        totalprice.text = [NSString stringWithFormat:@"%0.2f",semitotal];
        totalprice.textColor=[UIColor whiteColor];
        totalprice.font = customFontdt;
        totalprice.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:totalprice];

    }
    
    [cellView addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(screenRect.size.width*3.3,screenRect.size.height*0.10);
    scrollView.scrollEnabled=YES;

    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:cellView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.12+10;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (IBAction)showCalendar:(id)sender
{
    if ([self.pmCC isCalendarVisible])
    {
        [self.pmCC dismissCalendarAnimated:NO];
    }
    
    BOOL isPopover = YES;
    
    // limit apple calendar to 2 months before and 2 months after current date
    PMPeriod *allowed = [PMPeriod periodWithStartDate:[[NSDate date] dateByAddingMonths:-2]
                                              endDate:[[NSDate date] dateByAddingMonths:2]];
    
        self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
        //        self.pmCC.allowedPeriod = allowed;
    
    
    self.pmCC.delegate = self;
    self.pmCC.mondayFirstDayOfWeek = NO;
    //self.pmCC.showOnlyCurrentMonth = YES; //Only show days in current month
    
        [self.pmCC presentCalendarFromView:sender
                  permittedArrowDirections:PMCalendarArrowDirectionAny
                                 isPopover:isPopover
                                  animated:YES];
    
    self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
    [self calendarController:pmCC didChangePeriod:pmCC.period];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    periodLabel=[[UILabel alloc]init];
    periodLabel.text = [NSString stringWithFormat:@"%@ - %@"
                        , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]
                        , [newPeriod.endDate dateStringWithFormat:@"dd-MM-yyyy"]];
    NSLog(@"selected dates : %@",periodLabel.text);
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
