//
//  DashboardHomeViewController.m
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "DashboardHomeViewController.h"
#import "CreatePorjectViewController.h"
#import "ProjectListViewController.h"
#import "TaskListViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIColor+Expanded.h"
#import "SettingViewController.h"
#import "DashboardHomeViewController.h"
#import "ExpensesViewController.h"
#import "ReportInvoiceViewController.h"
#import "ProjectListViewController.h"
#import "InvoiceViewController.h"
#import "SettingViewController.h"
#import "ClientVO.h"
#import "ProjectVO.h"
#import "LoginViewController.h"
#import "PreferencesViewController.h"
#import "NewTaskViewController.h"
@interface DashboardHomeViewController ()

@end

@implementation DashboardHomeViewController
@synthesize settingBtn,createclientBtn,punchinBtn,punchoutBtn,selectProjectBtn,overlayView,menuNameArray,menuNameButton,isMenuVisible,tblSimpleTable,listView,islistviewVisible,selectProjectscrollview,databases,appDelegate,overlyScrollview,alert,punchindLbl,timepicker,timeToolbar,punchoutLbl,timer,TimepickeralertView,hourTime,Minslbl,isPunchOuttime,isPunchintime,timerseconds,differenceSeconds,projectNameLBl,pauseBtn,oldtimersecods,breakBtn,alertSave,breakmintes,breaktimer,selectprojectID,istimeover;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    isPunchOuttime=false;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    databases=[self getNewDb];
    appDelegate.allclientArray =[[NSMutableArray alloc] init];

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
    dashboardLbl.text = @"Dashboard";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.05];
    dashboardLbl.font = customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];

    createclientBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,screenRect.size.height*0.27,screenRect.size.width*0.06,screenRect.size.height*0.04)];
    createclientBtn.layer.cornerRadius = 6.0f;
    createclientBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [createclientBtn setBackgroundImage:[UIImage imageNamed:@"plusiconaddproject.PNG"] forState:UIControlStateNormal];
    [createclientBtn addTarget:self action:@selector(createNewClient) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:createclientBtn];
    
    UIFont *customFontdss = [UIFont fontWithName:@"brandongrotesque-light" size:screenRect.size.width*0.04];
    UIFont *customFontdreg = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.04];

    selectProjectBtn=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.27, screenRect.size.width-60,screenRect.size.height*0.09)];
    [selectProjectBtn.titleLabel setFont:customFontdreg];
    [selectProjectBtn setTitle:@"Select Project" forState:UIControlStateNormal];
    [selectProjectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectProjectBtn.layer.cornerRadius = 6.0f;
    selectProjectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [selectProjectBtn setBackgroundImage:[UIImage imageNamed:@"reportslistitem_background.PNG"] forState:UIControlStateNormal];
    [selectProjectBtn addTarget:self action:@selector(actionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectProjectBtn];

    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.27,screenRect.size.width*0.40,25)];
    pictureLbl.text = @"Add Client";
    pictureLbl.textColor=[UIColor whiteColor];
    pictureLbl.font = customFontdss;
    //[self.view addSubview:pictureLbl];
    
    
    projectNameLBl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.37,screenRect.size.width*0.50,25)];
    projectNameLBl.textColor=[UIColor whiteColor];
    projectNameLBl.font = customFontdss;
    [self.view addSubview:projectNameLBl];
    
   
    

   punchinBtn=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.43, screenRect.size.width*0.35,screenRect.size.height*0.06)];
    [punchinBtn.titleLabel setFont:customFontdreg];
    [punchinBtn setTitle:@"Punch In" forState:UIControlStateNormal];
    [punchinBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    punchinBtn.layer.cornerRadius = 6.0f;
    punchinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [punchinBtn setBackgroundColor:[UIColor whiteColor]];
    [punchinBtn addTarget:self action:@selector(punchInAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:punchinBtn];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    
    punchindLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.43,screenRect.size.width*0.45,screenRect.size.height*0.06)];
   
    punchindLbl.textColor=[UIColor whiteColor];
    punchindLbl.font =customFontdss;
    punchindLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:punchindLbl];

    punchoutBtn=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.51, screenRect.size.width*0.35,screenRect.size.height*0.06)];
    [punchoutBtn.titleLabel setFont:customFontdreg];
    [punchoutBtn setTitle:@"Punch Out" forState:UIControlStateNormal];
    [punchoutBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    punchoutBtn.layer.cornerRadius = 6.0f;
    punchoutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [punchoutBtn setBackgroundColor:[UIColor whiteColor]];
    [punchoutBtn addTarget:self action:@selector(PunchPutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:punchoutBtn];

    punchoutLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.51,screenRect.size.width*0.45,screenRect.size.height*0.06)];
  
    punchoutLbl.textColor=[UIColor whiteColor];
    punchoutLbl.font = customFontdss;
    punchoutLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:punchoutLbl];

    pauseBtn=[[UIButton alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.60, screenRect.size.width*0.35,screenRect.size.height*0.06)];
    [pauseBtn.titleLabel setFont:customFontdreg];
    NSString *pauseStr=[prefs stringForKey:@"Pause"];
    [pauseBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    pauseBtn.layer.cornerRadius = 6.0f;
    pauseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [pauseBtn setBackgroundColor:[UIColor whiteColor]];
    [pauseBtn addTarget:self action:@selector(PasueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];

    breakBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.60, screenRect.size.width*0.35,screenRect.size.height*0.06)];
    [breakBtn.titleLabel setFont:customFontdreg];
    [breakBtn setTitle:@"Break" forState:UIControlStateNormal];
    [breakBtn setTitleColor:[UIColor colorWithHexString:@"4a89dc"] forState:UIControlStateNormal];
    breakBtn.layer.cornerRadius = 6.0f;
    breakBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [breakBtn setBackgroundColor:[UIColor whiteColor]];
    [breakBtn addTarget:self action:@selector(breakAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:breakBtn];
    
    
    UIImageView *timerView=[[UIImageView alloc]initWithFrame:CGRectMake(30,screenRect.size.height*0.69, screenRect.size.width-60,screenRect.size.height*0.18)];
    [timerView setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    CALayer * l = [timerView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:25.0];
    [self.view addSubview:timerView];

    UILabel *timerLbl=[[UILabel alloc]initWithFrame:CGRectMake(50,screenRect.size.height*0.70,120,25)];
    timerLbl.text = @"TIMER";
    timerLbl.textColor=[UIColor whiteColor];
    timerLbl.font = customFontdreg;
    [self.view addSubview:timerLbl];
    
    
    hourTime=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.18,screenRect.size.height*0.75,screenRect.size.width*0.30,40)];
   
    hourTime.textColor=[UIColor blackColor];
    hourTime.font = customFontdss;
    hourTime.textAlignment = NSTextAlignmentCenter;
    [hourTime setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:hourTime];

    
    Minslbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.75, screenRect.size.width*0.30,40)];
    Minslbl.textColor=[UIColor blackColor];
    Minslbl.font = customFontdss;
    Minslbl.textAlignment = NSTextAlignmentCenter;
    [Minslbl setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:Minslbl];
    
    
    if([prefs stringForKey:@"Punchedin"]!=nil){
        punchindLbl.text = [prefs stringForKey:@"PunchedinDate"];
        if([prefs stringForKey:@"PunchedoutOn"]!=nil){
        punchoutLbl.text = [prefs stringForKey:@"PunchedoutOn"];
        }else{
            //punchoutLbl.text =@"0.00";
        }
        
        if([prefs stringForKey:@"BreakSeconds"]!=nil){
            pauseBtn.hidden=YES;
            
            breakBtn.enabled=NO;
            [timer invalidate];
            timer=nil;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
          NSDate * todaybreak=[formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
           NSDate * breakdate= [formatter dateFromString:[[prefs stringForKey:@"BreakStartdate"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];

          int  deffseconds= [self timeDifference:breakdate ToDate:todaybreak];
            int secondtimer=[[prefs stringForKey:@"BreakSeconds"] intValue];
            if (deffseconds>secondtimer) {
                [timer invalidate];
                timer=nil;
                timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
                pauseBtn.hidden=NO;
                breakBtn.hidden=NO;
                punchoutBtn.hidden=NO;
                [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
                [breakBtn setTitle:@"Break" forState:UIControlStateNormal];

            }else{
                int timervalue=secondtimer-deffseconds;
                pauseBtn.hidden=YES;
                [breakBtn setTitle:@"Break ON" forState:UIControlStateNormal];

                [breaktimer invalidate];
                breaktimer=nil;
                breaktimer = [NSTimer scheduledTimerWithTimeInterval: timervalue target:self selector:@selector(breaktimermethod) userInfo:nil repeats: NO];
            }
        }else if ([pauseStr isEqualToString:@"Start"]) {
            [pauseBtn setTitle:@"Resume" forState:UIControlStateNormal];
            breakBtn.hidden=YES;
            [timer invalidate];
            timer=nil;
            
        }else{
            [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
            [timer invalidate];
            timer=nil;
            timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
            pauseBtn.hidden=NO;
            breakBtn.hidden=NO;
            punchoutBtn.hidden=NO;
        }

        hourTime.text = [prefs stringForKey:@"Hrs"];
        Minslbl.text = [prefs stringForKey:@"Mins"];
        projectNameLBl.text = [prefs stringForKey:@"projectname"];
        //timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
        selectProjectBtn.hidden=YES;
    }else{
        punchindLbl.text = [prefs stringForKey:@"PunchedinDate"];
        if([prefs stringForKey:@"PunchedoutOn"]!=nil){
            punchoutLbl.text = [prefs stringForKey:@"PunchedoutOn"];
        }else{
            //punchoutLbl.text =@"0.00";
        }
        hourTime.text = [prefs stringForKey:@"Hrs"];
        Minslbl.text = [prefs stringForKey:@"Mins"];
        projectNameLBl.text = [prefs stringForKey:@"projectname"];
        [timer invalidate];
        timer=nil;

        pauseBtn.hidden=YES;
        breakBtn.hidden=YES;
        punchoutBtn.hidden=YES;
    }

        //self.tblSimpleTable.allowsMultipleSelectionDuringEditing = YES;
    
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
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    [self.view addGestureRecognizer:tap];
    
    NSString * applockStr=[prefs stringForKey:@"applockon"];
    if ([applockStr isEqualToString:@"nopassword"]) {
        [appDelegate roundupdownAction];
    }
    
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"/MyFolder"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    NSError *error;
    if (fileExists==YES) {
        
    }else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyFolder"];
        NSLog(@"%@",dataPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        
    }

}

-(void)PasueAction{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil forKey:@"BreakSeconds"];
    [prefs synchronize];

    NSString *pauseStr=[prefs stringForKey:@"Pause"];
    if ([pauseStr isEqualToString:@"Pause"] || pauseStr==nil) {
        [pauseBtn setTitle:@"Resume" forState:UIControlStateNormal];
        breakBtn.hidden=YES;
        [timer invalidate];
        timer=nil;
        [prefs setObject:@"Start" forKey:@"Pause"];
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        [prefs setObject:[dateFormatter stringFromDate:now] forKey:@"projectpasusestarttime"];

    }else{
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
        pauseBtn.hidden=NO;
        breakBtn.hidden=NO;
        punchoutBtn.hidden=NO;

        [prefs setObject:@"Pause" forKey:@"Pause"];
        [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        [prefs setObject:[dateFormatter stringFromDate:now] forKey:@"currentTime"];
        [prefs setObject:[dateFormatter stringFromDate:now] forKey:@"projectpasuseendtime"];

        NSString *mins=Minslbl.text;
        NSArray* allDataars = [mins componentsSeparatedByString: @" "];
        [prefs setObject:[allDataars objectAtIndex:0] forKey:@"min"];
        [self insertPauseRecords];
        
    }
    [prefs synchronize];

    
}


-(void)insertPauseRecords{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSDate * todaybreak=[formatter dateFromString:[[prefs stringForKey:@"projectpasuseendtime"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
    NSDate * breakdate= [formatter dateFromString:[[prefs stringForKey:@"projectpasusestarttime"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
    int  deffseconds= [self timeDifference:breakdate ToDate:todaybreak];
    int diffinsec=deffseconds%60;
    diffinsec=deffseconds/60;
    int minutes=diffinsec%60;

    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    
    if (sqlite3_open([[self getDestPath] UTF8String], &databases) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ProjectPauseTable (projectid,projectpasuestarttime,projectpasueendtime,durationtime,projecttaskid) VALUES (%d,\"%@\",\"%@\",\"%d\",%@)",selectprojectID,[prefs stringForKey:@"projectpasusestarttime"],[prefs stringForKey:@"projectpasuseendtime"],minutes,appDelegate.projectTaskid];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(databases, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(databases)];
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        }
        sqlite3_finalize(statement);
        sqlite3_close(databases);
    }

}
-(void)breakAction{
    alertSave=[[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Set the break" delegate:self cancelButtonTitle:@"Set Break" otherButtonTitles:@"Cancel", nil];
    alertSave.alertViewStyle=UIAlertViewStylePlainTextInput;
    [[alertSave textFieldAtIndex:0] setPlaceholder:@"Enter the minutes"];
    [alertSave textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [alertSave textFieldAtIndex:0].delegate = self;
    [alertSave textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;

    [alertSave show];

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
}


-(void)getProjectList{
    char *dbChars ;
    appDelegate.allprojectArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectDetailsTable"];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            ProjectVO *projectVo=[[ProjectVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                projectVo.project_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                projectVo.client_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                projectVo.user_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                projectVo.project_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                projectVo.project_location=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 5);
            if(dbChars!=nil)
                projectVo.usedefaultsetting=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 6);
            if(dbChars!=nil)
                projectVo.ratehourly_daily_project=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 7);
            if(dbChars!=nil)
                projectVo.project_tax=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 8);
            if(dbChars!=nil)
                projectVo.project_vat=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 9);
            if(dbChars!=nil)
                projectVo.projectovertimehour=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 10);
            if(dbChars!=nil)
                projectVo.projectovertimerate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 11);
            if(dbChars!=nil)
                projectVo.projectdaily_weekly=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 12);
            if(dbChars!=nil)
                projectVo.activeprojectStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 13);
            if(dbChars!=nil)
                projectVo.citrStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 14);
            if(dbChars!=nil)
                projectVo.stateStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 15);
            if(dbChars!=nil)
                projectVo.zipStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 16);
            if(dbChars!=nil)
                projectVo.countryStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 17);
            if(dbChars!=nil)
                projectVo.defaultratevalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)];

            [appDelegate.allprojectArray addObject:projectVo];
        }
    }
}


- (void)tapOnView:(UITapGestureRecognizer *)sender
{
    listView.hidden=true;
    islistviewVisible=false;

}

#pragma mark -
#pragma mark DropDownViewDelegate

-(void)dropDownCellSelected:(NSInteger)returnIndex{
    
    [selectProjectBtn setTitle:[arrayData objectAtIndex:returnIndex] forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark Class methods

-(IBAction)actionButtonClick{
    if(!islistviewVisible)
    {
        listView.hidden=false;
        islistviewVisible=true;
        selectProjectscrollview.hidden=NO;

    }else{
        listView.hidden=true;
        selectProjectscrollview.hidden=YES;

        islistviewVisible=false;
    }
}
-(void)dropDownListAction:(UIButton *)button{
    if (appDelegate.allprojectArray ==nil || [appDelegate.allprojectArray count]==0) {
        [selectProjectBtn setTitle:@"Add Project" forState:UIControlStateNormal];
        listView.hidden=true;
        islistviewVisible=false;

        if ([appDelegate.allclientArray count]==0) {
            alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please add client first" delegate:self cancelButtonTitle:@"Add Client" otherButtonTitles:@"Cancel", nil];
            
            [alert show];

        }else{
            TaskListViewController *project=[[TaskListViewController alloc]initWithNibName:@"TaskListViewController" bundle:nil];
            [self.navigationController pushViewController:project animated:YES];

        }
    }else{
    int tags=button.tag;
    ProjectVO *projectVO= [appDelegate.allprojectArray objectAtIndex:tags];
    [selectProjectBtn setTitle:projectVO.project_name forState:UIControlStateNormal];
    projectNameLBl.text =[NSString stringWithFormat:@"Project Name : %@",projectVO.project_name] ;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:projectNameLBl.text forKey:@"projectname"];
        [prefs setObject:projectVO.project_id forKey:@"projectid"];
        selectprojectID=[projectVO.project_id intValue];
        [prefs synchronize];

    listView.hidden=true;
    islistviewVisible=false;
        selectProjectscrollview.hidden=YES;

        
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Do you want to punch in now?" delegate:self cancelButtonTitle:@"Yes, Sure" otherButtonTitles:@"no", nil];
        
        [alert show];
    }
}

-(void)timeFunction{
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSDate *facebookdate,*olddateset;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *pauseStr=[prefs stringForKey:@"Pause"];
    if ([pauseStr isEqualToString:@"Pause"] ) {
        
        facebookdate= [formatter dateFromString:[[prefs stringForKey:@"currentTime"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
        olddateset = [formatter dateFromString:[punchindLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];

    }else if([prefs stringForKey:@"BreakSeconds"]!=nil)
    {
        facebookdate= [formatter dateFromString:[[prefs stringForKey:@"Break"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
        olddateset = [formatter dateFromString:[punchindLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];

    }
    else{
       facebookdate = [formatter dateFromString:[punchindLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
        olddateset = [formatter dateFromString:[punchindLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];

    }
    NSDate *today;
    if([prefs stringForKey:@"PunchedoutOn"]!=nil){
        NSDate *firstDate;
        
        firstDate = [formatter dateFromString:[punchindLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
        
        
        
        
        NSDate *secondDate;
        if([prefs stringForKey:@"Roundupdown"]!=nil){

            if ([[prefs stringForKey:@"Roundupdown"] isEqualToString:@"ROUND UP"]) {
                NSDate *tempDate= [formatter dateFromString:[punchoutLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:tempDate];
                NSInteger minute = [components minute];
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];

                if (minute>0 && minute<14) {
                    int minstemp=15-minute;
                    [offsetComponents setMinute:+minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>15 && minute<29) {
                    int minstemp=30-minute;
                    [offsetComponents setMinute:+minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>30 && minute<44) {
                    int minstemp=45-minute;
                    [offsetComponents setMinute:+minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>45 && minute<59) {
                    int minstemp=60-minute;
                    [offsetComponents setMinute:+minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }

            }else if ([[prefs stringForKey:@"Roundupdown"] isEqualToString:@"ROUND DOWN"]) {
                NSDate *tempDate= [formatter dateFromString:[punchoutLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:tempDate];
                NSInteger minute = [components minute];
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];

                if (minute>0 && minute<14) {
                    [offsetComponents setMinute:-minute]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>15 && minute<29) {
                    int minstemp=minute-15;
                    [offsetComponents setMinute:-minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>30 && minute<44) {
                    int minstemp=minute-30;
                    [offsetComponents setMinute:-minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }
                if (minute>45 && minute<59) {
                    int minstemp=minute-45;
                    [offsetComponents setMinute:-minstemp]; // note that I'm setting it to -1
                    secondDate = [gregorian dateByAddingComponents:offsetComponents toDate:tempDate options:0];
                }

            }else{
                secondDate= [formatter dateFromString:[punchoutLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
             }
        }else{
        secondDate= [formatter dateFromString:[punchoutLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];

        }
        
        NSTimeInterval timeDifference = [secondDate timeIntervalSinceDate:firstDate];
        if (timeDifference<=0) {
            alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please set greater time for punch in time" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"no", nil];
            
            [alert show];
            pauseBtn.hidden=YES;
            breakBtn.hidden=YES;
            punchoutBtn.hidden=YES;

            [timer invalidate];
            timer=nil;
            selectProjectBtn.hidden=false;
            [self selectProjectDropdown];
            [selectProjectBtn setTitle:@"Select Project" forState:UIControlStateNormal];
            timerseconds=0;
            differenceSeconds=0;
            [prefs setObject:nil forKey:@"PunchedoutOn"];
            [prefs synchronize];
        }else{
        double minutes = timeDifference / 60;
            selectProjectBtn.hidden=true;

        double hours = minutes / 60;
        
         differenceSeconds = timeDifference;
        
        double days = minutes / 1440;
        
        NSLog(@"%.0f, %.0f, %.0f, %.0f", days, hours, minutes, differenceSeconds);
          
                if (oldtimersecods>=differenceSeconds) {
                    alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Timer is over" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [timer invalidate];
                    timer=nil;
                    istimeover=true;
                    [self updateTasdkActions];
                    }
            }
    }
    
    today=[formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    oldtimersecods= [self timeDifference:olddateset ToDate:today];
    if(istimeover){
        today= [formatter dateFromString:[punchoutLbl.text stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
        timerseconds= [self timeDifference:facebookdate ToDate:today];
    }else{
        timerseconds= [self timeDifference:facebookdate ToDate:today];
    }

        if (0<=timerseconds) {
            long diffinsec=timerseconds%60;
            diffinsec=timerseconds/60;
            long minutes=diffinsec%60;
            diffinsec=diffinsec/60;
            long hours=diffinsec%24;
            diffinsec=diffinsec/24;
            
            hourTime.text=[NSString stringWithFormat:@"%ld Hrs",hours];
            if ([pauseStr isEqualToString:@"Pause"]) {
                int currentmins=[[prefs stringForKey:@"min"] intValue];
                Minslbl.text=[NSString stringWithFormat:@"%ld Mins",minutes+currentmins];
            }else if([prefs stringForKey:@"BreakSeconds"]!=nil)
            {
                int currentmins=[[prefs stringForKey:@"breakmin"] intValue];
                Minslbl.text=[NSString stringWithFormat:@"%ld Mins",minutes+currentmins];
            }
            else{
                Minslbl.text=[NSString stringWithFormat:@"%ld Mins",minutes];
            }
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:hourTime.text forKey:@"Hrs"];
            [prefs setObject:Minslbl.text forKey:@"Mins"];
            [prefs synchronize];
        }else{
            //[timer invalidate];
            hourTime.text=@"0 Hrs";
            Minslbl.text=@"00 Mins";
        }
}
- (int)timeDifference:(NSDate *)fromDate ToDate:(NSDate *)toDate{
    NSTimeInterval distanceBetweenDates = [toDate timeIntervalSinceDate:fromDate];
    
    return distanceBetweenDates;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Add Client"]){
        CreatePorjectViewController *setting=[[CreatePorjectViewController alloc]initWithNibName:@"CreatePorjectViewController" bundle:nil];
        [self.navigationController pushViewController:setting animated:YES];

    }
    if([title isEqualToString:@"Yes, Sure"]){
        timerseconds=0;
        timerseconds=0;
        differenceSeconds=0;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        punchindLbl.text=[dateFormatter stringFromDate:now];
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Punched in Successfully\nDo you want to set punch out time as well?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        [alert show];
        punchinBtn.enabled = NO;
        breakBtn.enabled = YES;

        selectProjectBtn.hidden=YES;
        [prefs setObject:nil forKey:@"Pause"];
        [prefs setObject:nil forKey:@"BreakSeconds"];

        [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
        [prefs setObject:@"0" forKey:@"min"];
        [prefs setObject:punchindLbl.text forKey:@"Punchedin"];
        [prefs setObject:punchindLbl.text forKey:@"PunchedinDate"];
        [prefs synchronize];

    }
    
    if([title isEqualToString:@"Yes"]){
        [self TimePickerDisplay];

    }
    if([title isEqualToString:@"No"]){
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
        istimeover=false;
        pauseBtn.hidden=NO;
        breakBtn.hidden=NO;
        punchoutBtn.hidden=NO;
        punchoutLbl.text=@"0.00";
        [prefs setObject:@"0:00" forKey:@"PunchedoutOff"];
        [prefs setObject:nil forKey:@"PunchedoutOn"];
        [prefs synchronize];
        [self insertTaskRecords];

    }
    if([title isEqualToString:@"no"]){
        [timer invalidate];
        timer=nil;
        pauseBtn.hidden=YES;
        breakBtn.hidden=YES;
        punchoutBtn.hidden=YES;
        hourTime.text=@"0 Hrs";
        Minslbl.text=@"00 Mins";
        [prefs setObject:@"0:00" forKey:@"PunchedoutOff"];
        [prefs setObject:nil forKey:@"Punchedin"];
        [prefs synchronize];

    }

    if([title isEqualToString:@"yes"]){
        [prefs setObject:@"Start" forKey:@"Pause"];
        [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
        breakBtn.enabled= YES;
        punchinBtn.enabled = YES;
        selectProjectBtn.hidden=NO;
        [self selectProjectDropdown];
        [selectProjectBtn setTitle:@"Select Project" forState:UIControlStateNormal];
        pauseBtn.hidden=YES;
        breakBtn.hidden=YES;
        punchoutBtn.hidden=YES;
        [self updateTasdkActions];

        [timer invalidate];
        timer=nil;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        punchoutLbl.text=[dateFormatter stringFromDate:now];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:nil forKey:@"Punchedin"];
        
        [prefs synchronize];

    }
    if([title isEqualToString:@"Set Break"]){
        NSString *mintes=[alertSave textFieldAtIndex:0].text;
        breakmintes=[mintes intValue];
        if ([mintes isEqualToString:@""]) {
           UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please enter the minutes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];

        }else{
            [timer invalidate];
            timer=nil;
            breakBtn.enabled= NO;
            int timersec=breakmintes*60;
            [breakBtn setTitle:@"Break ON" forState:UIControlStateNormal];

            breaktimer = [NSTimer scheduledTimerWithTimeInterval: timersec target:self selector:@selector(breaktimermethod) userInfo:nil repeats: NO];
            pauseBtn.hidden=YES;
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[NSString stringWithFormat:@"%d",timersec] forKey:@"BreakSeconds"];
            NSDate *now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
            [prefs setObject:[dateFormatter stringFromDate:now] forKey:@"BreakStartdate"];
            [prefs setObject:nil forKey:@"Pause"];

            [prefs synchronize];
        }
    }
    if([title isEqualToString:@"OK"]){

    [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    pauseBtn.hidden=YES;
    breakBtn.hidden=YES;
    punchoutBtn.hidden=YES;
    
    selectProjectBtn.hidden=NO;
    [self selectProjectDropdown];
    [selectProjectBtn setTitle:@"Select Project" forState:UIControlStateNormal];
    timerseconds=0;
    oldtimersecods=0;
    differenceSeconds=0;
    [prefs setObject:@"Pause" forKey:@"Pause"];
    [prefs setObject:nil forKey:@"BreakSeconds"];
    [prefs setObject:nil forKey:@"Punchedin"];
    [prefs synchronize];
    }
}

-(void)breaktimermethod{
    [breaktimer invalidate];
    breaktimer=nil;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    [prefs setObject:[dateFormatter stringFromDate:now] forKey:@"Break"];
    NSString *mins=Minslbl.text;
    NSArray* allDataars = [mins componentsSeparatedByString: @" "];
    [prefs setObject:[allDataars objectAtIndex:0] forKey:@"breakmin"];
    [prefs synchronize];
    [breakBtn setTitle:@"Break" forState:UIControlStateNormal];
    [timer invalidate];
    timer=nil;
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
    pauseBtn.hidden=NO;
    breakBtn.enabled=YES;
    [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    [self insertBreakRecords];
}
-(void)insertBreakRecords{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSDate * todaybreak=[formatter dateFromString:[[prefs stringForKey:@"BreakStartdate"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
    NSDate * breakdate= [formatter dateFromString:[[prefs stringForKey:@"Break"] stringByReplacingOccurrencesOfString:@"\/" withString:@"-"]];
    int  deffseconds= [self timeDifference:todaybreak ToDate:breakdate];
        int diffinsec=deffseconds%60;
        diffinsec=deffseconds/60;
        int minutes=diffinsec%60;

    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    
    if (sqlite3_open([[self getDestPath] UTF8String], &databases) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ProjectBreakTable (projectid,projectbreakstarttime,projectbreakendtime,durationtime,projecttaskid) VALUES (%d,\"%@\",\"%@\",\"%d\",%@)",selectprojectID,[prefs stringForKey:@"BreakStartdate"],[prefs stringForKey:@"Break"],minutes,appDelegate.projectTaskid];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(databases, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(databases)];
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        }
        sqlite3_finalize(statement);
        sqlite3_close(databases);
    }
    
}
-(void)insertTaskRecords{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    appDelegate.projectTaskid=[[NSNumber alloc]init];
    if (sqlite3_open([[self getDestPath] UTF8String], &databases) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ProjectTaskTable (projectid,projecttaskstarttime,projecttaskendtime,Taskdurationtime) VALUES (%d,\"%@\",\"%@\",\"%@\")",selectprojectID,punchindLbl.text,punchoutLbl.text,@"0 mins"];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(databases, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(databases)];
           appDelegate.projectTaskid=lastId;
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        }
        sqlite3_finalize(statement);
        sqlite3_close(databases);
    }
    
}
-(void)updateTasdkActions{
    sqlite3_open([[self getDestPath] UTF8String], &databases);
    NSString *durationTime=[NSString stringWithFormat:@"%@ - %@",hourTime.text,Minslbl.text];
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL= [NSString stringWithFormat:
                @"update ProjectTaskTable set projecttaskstarttime=\"%@\",projecttaskendtime=\"%@\",Taskdurationtime=\"%@\" where taskid = %@",punchindLbl.text,punchoutLbl.text,durationTime,appDelegate.projectTaskid];
    
    NSLog(@"insertSQL = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(databases, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail updated");
        
    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
        
    }
    
}

-(IBAction)PunchPutAction
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"Punchedin"]==nil){
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please start the punchin" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        selectProjectBtn.hidden=NO;
        [self selectProjectDropdown];

    }else{
    alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Are you sure to punch out?" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"cancel", nil];
    
    [alert show];
    }

}

-(IBAction)punchInAction{
    NewTaskViewController *createClient=[[NewTaskViewController alloc]initWithNibName:@"NewTaskViewController" bundle:nil];
    [self.navigationController pushViewController:createClient animated:YES];

    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"Punchedin"]==nil){
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please select project and start the punching" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }*/
}
- (void)TimePickerDisplay
{
    // Here we need to pass a full frame
    TimepickeralertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [TimepickeralertView setContainerView:[self changePassAlert]];
    // Modify the parameters
    [TimepickeralertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [TimepickeralertView setUseMotionEffects:true];
    // And launch the dialog
    [TimepickeralertView show];
}
-(UIView *)changePassAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,300)];
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
    
    timepicker.hidden=YES;
    timepicker=[[UIDatePicker alloc]init];
    timepicker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
    timepicker.frame=CGRectMake(0,50,300,198);
    //timepicker.datePickerMode = UIDatePickerModeTime;
    [demoView addSubview:timepicker];
    //timepicker.timeZone = [NSTimeZone timeZoneWithName: @"PST"];
    timeToolbar.hidden=NO;
    timepicker.hidden=NO;

    
    UIButton *SettimeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,248,148,50)];
    [SettimeBtn setTitle:@"Set Time" forState:UIControlStateNormal];
    [SettimeBtn addTarget:self
                  action:@selector(doneBtnPressedtime)
        forControlEvents:UIControlEventTouchUpInside];
    [SettimeBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:SettimeBtn];

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(152,248,150,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:cancelBtn];
    return demoView;
    
}
-(void)closeAlert:(id)sender{
    [TimepickeralertView close];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
    pauseBtn.hidden=NO;
    breakBtn.hidden=NO;
    punchoutBtn.hidden=NO;
    punchoutLbl.text=@"0.00";
    [prefs setObject:@"0:00" forKey:@"PunchedoutOff"];
    [prefs setObject:nil forKey:@"PunchedoutOn"];
    [prefs synchronize];

}

-(IBAction)doneBtnPressedtime{
    [TimepickeralertView close];
   NSDateFormatter *starttime= [[NSDateFormatter alloc] init];
    [starttime setDateFormat:@"hh:mm a"];
    NSString *st = [starttime stringFromDate:timepicker.date];
    //timeTxt.text=[[NSString alloc]initWithFormat:@"%@",st];
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"MM/dd/yyyy hh:mm a"];
    punchoutLbl.text = [dateFormatters stringFromDate:timepicker.date];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:punchoutLbl.text forKey:@"PunchedoutOn"];
    [prefs synchronize];
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(timeFunction) userInfo:nil repeats: YES];
    [self insertTaskRecords];
    istimeover=false;
    pauseBtn.hidden=NO;
    breakBtn.hidden=NO;
    punchoutBtn.hidden=NO;

    isPunchOuttime=true;
    timeToolbar.hidden=YES;
    timepicker.hidden=YES;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    [self getClientList];
    [self getProjectList];
    [self selectProjectDropdown];
}

-(void)selectProjectDropdown{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    selectProjectscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(40, screenRect.size.height*0.36, screenRect.size.width-80,130)];
    listView = [[UIView alloc] initWithFrame:CGRectMake(0,0, screenRect.size.width-80,250)];
    listView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    listView.alpha = 0.95;
    int yValuelist=10;
    if (appDelegate.allprojectArray ==nil || [appDelegate.allprojectArray count]==0) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-8,screenRect.size.width-80,2)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [listView addSubview:borderImg];
        
        UIButton *listmenu=[[UIButton alloc] initWithFrame:CGRectMake(10, yValuelist,200, 34)];
        [listmenu setTitle:@"Add Project" forState:UIControlStateNormal];
        listmenu.tag=1;
        listmenu.titleLabel.font= [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        [listmenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [listmenu setBackgroundColor:[UIColor clearColor]];
        [listmenu addTarget:self action:@selector(dropDownListAction:) forControlEvents:UIControlEventTouchUpInside];
        listmenu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [listView addSubview:listmenu];
        
    }else{
        for (int count=0; count<[appDelegate.allprojectArray count]; count++) {
            UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-8,screenRect.size.width-80,2)];
            [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
            [listView addSubview:borderImg];
            
            UIButton *listmenu=[[UIButton alloc] initWithFrame:CGRectMake(10, yValuelist,200, 34)];
            ProjectVO *projectVO=[appDelegate.allprojectArray objectAtIndex:count];
            [listmenu setTitle:projectVO.project_name forState:UIControlStateNormal];
            listmenu.tag=count;
            listmenu.titleLabel.font= [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
            [listmenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [listmenu setBackgroundColor:[UIColor clearColor]];
            [listmenu addTarget:self action:@selector(dropDownListAction:) forControlEvents:UIControlEventTouchUpInside];
            listmenu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [listView addSubview:listmenu];
            
            yValuelist=yValuelist+35;
        }
    }
    UIImageView *borderImglastList=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValuelist-5,screenRect.size.width-80,2)];
    [borderImglastList setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    [listView addSubview:borderImglastList];
    listView.layer.cornerRadius = 5;
    listView.layer.masksToBounds = YES;
    [self.selectProjectscrollview addSubview:listView];
    [self.view addSubview:selectProjectscrollview];
    
    selectProjectscrollview.contentSize = CGSizeMake(screenRect.size.width-80,yValuelist+50);
    selectProjectscrollview.scrollEnabled=YES;
    selectProjectscrollview.hidden=YES;
    listView.hidden=true;
    islistviewVisible=false;

}
-(IBAction)menuScreenAction{
    listView.hidden=true;
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
    
    if (tags>0) {
        [breaktimer invalidate];
        breaktimer=nil;
        [timer invalidate];
        timer=nil;

    }
    if (tags==0) {
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
        [timer invalidate];
        timer=nil;
        [prefs setObject:nil forKey:@"Punchedin"];
        [prefs synchronize];

    }
}

-(IBAction)clientprojectList{
    ProjectListViewController *projectlist=[[ProjectListViewController alloc]initWithNibName:@"ProjectListViewController" bundle:nil];
    [self.navigationController pushViewController:projectlist animated:YES];

}
-(IBAction)createNewClient{
    CreatePorjectViewController *setting=[[CreatePorjectViewController alloc]initWithNibName:@"CreatePorjectViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];

}
-(IBAction)SettingAction{
    SettingViewController *createClient=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:createClient animated:YES];
    
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
