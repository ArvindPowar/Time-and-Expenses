//
//  ExpensesViewController.m
//  TaskTracker
//
//  Created by arvind on 3/18/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ExpensesViewController.h"
#import "UIColor+Expanded.h"
#import "DashboardHomeViewController.h"
#import "ReportInvoiceViewController.h"
#import "ProjectListViewController.h"
#import "InvoiceViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "ExpensesListViewController.h"
#import "ImageVO.h"
#define kOFFSET_FOR_KEYBOARD 80.0
#define k_KEYBOARD_OFFSET 80.0

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController
@synthesize cancelButton,addButton,takepictureBtn,dateTxt,expenceTypeTxt,amountTxt,commentTxt,dateLbl,expencesLbl,amountLbl,commentLbl,overlayView,menuNameArray,menuNameButton,isMenuVisible,settingBtn,tableviewExpenses,expensesListArray,commentTxtview,overlyScrollview,datepicker,dateToolbar,imgUloadalertView,receiptPicture,ScanDB,savedImagePath,expensesNameStr,alertSave,clientid,projectid,ExpvOData,isupdatevalue,receipid,imageArray,cancelBtn,imageallView,tempimageArray,expenseTypeArray,expenseAlertScrollview,expensAlertView;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    ScanDB=[self getNewDb];
    savedImagePath=[[NSString alloc]init];
    imageArray=[[NSMutableArray alloc]init];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(0, 15, screenRect.size.width*0.85, screenRect.size.height*0.06)];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [titleLabel setText:@"TIME & EXPENSE"];
    titleLabel.textColor=[UIColor whiteColor];
    UIFont *customFontdss = [UIFont fontWithName:@"BrandonText-Bold" size:screenRect.size.width*0.04];
    titleLabel.font =customFontdss;
    self.navigationItem.titleView = titleLabel;
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    
    if (isupdatevalue) {
        self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleBordered target:self action:@selector(updateActions)];
    }else{
        self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAction)];
    }
    self.deleteButton.tintColor = [UIColor redColor];
    self.editButton.tintColor = [UIColor whiteColor];
    self.addButton.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:self.editButton];
    [self.navigationItem setRightBarButtonItem:self.addButton];
    
    
    
    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.12,screenRect.size.width,35)];
    dashboardLbl.text = @"Expenses";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];
    dashboardLbl.font = customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];
    
    tableviewExpenses=[[UITableView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.18,screenRect.size.width,screenRect.size.height*0.40)];
    tableviewExpenses.dataSource = self;
    tableviewExpenses.delegate = self;
    [tableviewExpenses setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.view addSubview:tableviewExpenses];
    self.tableviewExpenses.separatorColor = [UIColor clearColor];
    self.tableviewExpenses.allowsMultipleSelectionDuringEditing = YES;

    imageallView=[[UIView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.60,screenRect.size.width,screenRect.size.height*0.40)];
    [imageallView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageallView];
    
    UILabel *receiptuploadLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.57,(screenRect.size.width/2)-40,35)];
    receiptuploadLbl.text = @"Upload Receipt";
    receiptuploadLbl.textColor=[UIColor whiteColor];
    UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.04];
    receiptuploadLbl.font = customFontd;
    receiptuploadLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:receiptuploadLbl];

   UIButton* receiptuploadBtn=[[UIButton alloc]init];
    receiptuploadBtn.frame=CGRectMake(screenRect.size.width*0.03, screenRect.size.height*0.02, screenRect.size.width*0.25, screenRect.size.height*0.18);
    [receiptuploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [receiptuploadBtn setBackgroundImage:[UIImage imageNamed:@"addreceipticon.PNG"] forState:UIControlStateNormal];
    [receiptuploadBtn addTarget:self action:@selector(UploadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageallView addSubview:receiptuploadBtn];

    UILabel *displayuploadLbl=[[UILabel alloc]initWithFrame:CGRectMake((screenRect.size.width/2),screenRect.size.height*0.57,(screenRect.size.width/2)-20,35)];
    displayuploadLbl.text = @"picture of Receipt";
    displayuploadLbl.textColor=[UIColor whiteColor];
    displayuploadLbl.font = customFontd;
    displayuploadLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:displayuploadLbl];

    
    expensesListArray=[[NSMutableArray alloc]initWithObjects:@"Date",@"Expenses Type",@"Amount",@"Comment", nil];
    expenseTypeArray=[[NSMutableArray alloc]initWithObjects:@"Rent",@"Utilities",@"Insurance",@"Fees",@"Wages",@"Taxes",@"Interest",@"Supplies",@"Depreciation",@"Maintenance",@"Travel",@"Meals and Entertainment",@"Training", nil];

    menuNameArray=[[NSMutableArray alloc]initWithObjects:@"DASHBOARD",@"INVOICE",@"REPORTS",@"CLIENT/PROJECT LIST",@"SETTING",@"LOGOUT", nil];
    overlyScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    [overlyScrollview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height+200)];
    overlayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
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
    [overlaynameLabel setText:@"Shawn McAdams"];
    overlaynameLabel.textColor=[UIColor whiteColor];
    overlaynameLabel.font =[UIFont fontWithName:@"Brandon-med" size:13];
    [overlayView addSubview:overlaynameLabel];
    
    UILabel *overlaymailLabel = [[UILabel alloc] init];
    [overlaymailLabel setFrame:CGRectMake(0, screenRect.size.height*0.22, screenRect.size.width, screenRect.size.height*0.04)];
    overlaymailLabel.textAlignment = NSTextAlignmentCenter;
    [overlaymailLabel setText:@"Shawm321@gmail.com"];
    overlaymailLabel.textColor=[UIColor whiteColor];
    overlaymailLabel.font =[UIFont fontWithName:@"brandongrotesque-regular" size:12];
    [overlayView addSubview:overlaymailLabel];
    
    
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
    [self.view addSubview:overlayView];
    [self.view bringSubviewToFront:overlayView];
    overlayView.hidden=true;
    isMenuVisible=false;
    
    [receiptPicture removeFromSuperview];
    receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.67,screenRect.size.height*0.80,screenRect.size.width*0.25,screenRect.size.height*0.18)];
    [self.view addSubview:receiptPicture];

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
-(void)getImageList{
    char *dbChars ;
    imageArray =[[NSMutableArray alloc] init];
    tempimageArray=[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ExpenseImageTable where expense_id=%d",receipid];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(ScanDB, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            ImageVO *iamgeVO=[[ImageVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                iamgeVO.imageIdStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                iamgeVO.expenseIdStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                iamgeVO.imageNameStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            [imageArray addObject:iamgeVO.imageNameStr];
            [tempimageArray addObject:iamgeVO];
        }
    }
    
    [self displayImageView];
}
-(void)displayImageView{
    NSArray *viewsToRemove = [self.imageallView subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    imageallView=[[UIView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.60,screenRect.size.width,screenRect.size.height*0.40)];
    [imageallView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageallView];
    
    UIButton* receiptuploadBtn=[[UIButton alloc]init];
    receiptuploadBtn.frame=CGRectMake(screenRect.size.width*0.03, screenRect.size.height*0.02, screenRect.size.width*0.25, screenRect.size.height*0.18);
    [receiptuploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [receiptuploadBtn setBackgroundImage:[UIImage imageNamed:@"addreceipticon.PNG"] forState:UIControlStateNormal];
    [receiptuploadBtn addTarget:self action:@selector(UploadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageallView addSubview:receiptuploadBtn];
    
    for (int count=0; count<imageArray.count; count++) {
        if (count==0) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=0;
            
        } else if (count==1) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=1;
            
        }
        else if (count==2) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=2;
            
        }
        else if (count==3) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=3;
            
        }
        else  if (count==4) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=4;
            
        }
        
        [receiptPicture removeFromSuperview];
        ImageVO *imgVo=[imageArray objectAtIndex:count];
        [receiptPicture setImage:[UIImage imageNamed:[imageArray objectAtIndex:count]]];
        [imageallView addSubview:receiptPicture];
        
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        cancelBtn.backgroundColor=[UIColor clearColor];
        [cancelBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
        [imageallView addSubview:cancelBtn];
        [imageallView bringSubviewToFront:cancelBtn];
        
    }

}
-(void)InsertRecords{
    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (sqlite3_open([[self getDestPath] UTF8String], &ScanDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ReportExpensesTable (client_id,project_id,user_id,expenses_date,expenses_type,expenses_amount,expenses_comment,expenses_receiptImg,Expenses_Name) VALUES (%d,%d,%@,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",clientid,projectid,[prefs stringForKey:@"loggedin"],dateTxt.text,expenceTypeTxt.text,amountTxt.text,commentTxtview.text,savedImagePath,expensesNameStr];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(ScanDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(ScanDB)];
            [self imageInsert:lastId];
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(ScanDB);
    }
}
-(void)imageInsert:(NSNumber*)expId{
    for (int i=0; i<[imageArray count]; i++) {

    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (sqlite3_open([[self getDestPath] UTF8String], &ScanDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ExpenseImageTable (expense_id,image_name) VALUES (%@,\"%@\")",expId,[imageArray objectAtIndex:i]];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(ScanDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(ScanDB)];
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(ScanDB);
    }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                    message:@"Save successfully."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}
-(void)updateImages{
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat:
                 @"DELETE FROM ExpenseImageTable WHERE expense_id='%d'",receipid];
    
    NSLog(@"Delete = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(ScanDB, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail contestant position delete");
    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
    }
    

    for (int i=0; i<[imageArray count]; i++) {
        
        
        
        sqlite3_stmt *statement;
        NSLog(@"[self getDestPath] = %@",[self getDestPath]);
        NSNumber *lastId = 0;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        if (sqlite3_open([[self getDestPath] UTF8String], &ScanDB) == SQLITE_OK)
        {
            NSString *insertSQL;
            insertSQL = [NSString stringWithFormat:
                         @"insert into ExpenseImageTable (expense_id,image_name) VALUES (%d,\"%@\")",receipid,[imageArray objectAtIndex:i]];
            
            
            NSLog(@"insertSQL = %@",insertSQL);
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(ScanDB, insert_stmt,
                               -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"record inserted");
                lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(ScanDB)];
            }else{
                NSLog(@"record insertion failed");
                NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
            }
            sqlite3_finalize(statement);
            sqlite3_close(ScanDB);
        }
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Update successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)updateActions{
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL= [NSString stringWithFormat:
                @"update ReportExpensesTable set expenses_date=\"%@\",expenses_type=\"%@\",expenses_amount=\"%@\",expenses_comment=\"%@\",expenses_receiptImg=\"%@\" where reportExp_id = %d",dateTxt.text,expenceTypeTxt.text,amountTxt.text,commentTxtview.text,savedImagePath,receipid];
    
    NSLog(@"insertSQL = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(ScanDB, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail updated");
        [self updateImages];

    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
    }

}


-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)saveAction{
    alertSave=[[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Add Expenses name" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Cancel", nil];
    alertSave.alertViewStyle=UIAlertViewStylePlainTextInput;
    [[alertSave textFieldAtIndex:0] setPlaceholder:@"Enter the Expenses name"];
    [alertSave textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [alertSave show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Save"]){
        expensesNameStr=[[NSString alloc]init];
        expensesNameStr=[alertSave textFieldAtIndex:0].text;

        if ([expensesNameStr isEqualToString:@""] ) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"EZSplit" message:@"please enter the receipt name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            [self InsertRecords];
            [alertSave dismissWithClickedButtonIndex:1 animated:YES];

        }

    }
    
    if([title isEqualToString:@"OK"]){
        ExpensesListViewController *expenseList=[[ExpensesListViewController alloc]initWithNibName:@"ExpensesListViewController" bundle:nil];
        expenseList.clientid=clientid;
        expenseList.projectid=projectid;
        [self.navigationController pushViewController:expenseList animated:YES];
    }
    [alertSave dismissWithClickedButtonIndex:1 animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    if (ExpvOData) {
        receipid=[ExpvOData.repostexpidStr intValue];
        dateTxt.text=ExpvOData.expenses_dateStr;
        expenceTypeTxt.text=ExpvOData.expenses_typeStr;
        amountTxt.text=ExpvOData.expenses_amountStr;
        commentTxtview.text=ExpvOData.expenses_commentStr;
        savedImagePath=ExpvOData.expenses_commentStr;
        [self  getImageList];
        ExpvOData=nil;
    }
}
-(IBAction)menuScreenAction{
    if(!isMenuVisible)
    {
        overlayView.hidden=false;
        isMenuVisible=true;
    }else{
        overlayView.hidden=true;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [expensesListArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor clearColor];
    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(32, 5, self.view.frame.size.width-20-50, 20)];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UILabel *dot =[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.13,10,screenRect.size.width*0.80,screenRect.size.height*0.05)];
    UIFont *customFontd = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];

    dot.font = customFontd;
    [dot setTextColor:[UIColor whiteColor]];
    UIButton *plusBtn = [[UIButton alloc] init];
    plusBtn.frame = CGRectMake(10,10,screenRect.size.width*0.06,screenRect.size.height*0.04);
    //[plusBtn addTarget:self action:@selector(addProjectAction) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"plusiconaddproject.PNG"] forState:UIControlStateNormal];
    [tableView.tableHeaderView insertSubview:plusBtn atIndex:0];
    [headerView addSubview:plusBtn];
    
    UIButton *settingBtnheader = [[UIButton alloc] init];
    settingBtnheader.frame = CGRectMake(screenRect.size.width*0.94,10,screenRect.size.width*0.05,screenRect.size.height*0.04);
    //[settingBtnheader addTarget:self action:@selector(addProjectAction) forControlEvents:UIControlEventTouchUpInside];
    [settingBtnheader setBackgroundImage:[UIImage imageNamed:@"menuicon.PNG"] forState:UIControlStateNormal];
    [tableView.tableHeaderView insertSubview:settingBtnheader atIndex:0];
    //[headerView addSubview:settingBtnheader];
    
    dot.text=@"Add Expenses to Project";
    dot.textAlignment      = NSTextAlignmentLeft;
    dot.textColor          = [UIColor whiteColor];
    
    headerString.textAlignment      = NSTextAlignmentLeft;
    headerString.textColor          = [UIColor whiteColor];
    [headerView addSubview:headerString];
    [headerView addSubview:dot];
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.07;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int height=screenRect.size.height*0.15;
        return height;
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int height=screenRect.size.height*0.07;
        return height;
    }
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor whiteColor];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.04];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];

    if (indexPath.row==0) {
        UILabel  *ReceiptName=[[UILabel alloc]init ];
        ReceiptName.layer.frame=CGRectMake(10,5,100,screenRect.size.height*0.06);
        ReceiptName.text=[expensesListArray objectAtIndex:indexPath.row];
        [ReceiptName setFont:customFontd];
        ReceiptName.textColor=[UIColor whiteColor];
        [ReceiptName setBackgroundColor:[UIColor clearColor]];
        ReceiptName.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:ReceiptName];
        
        if (dateTxt==nil)
        dateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40, 5, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [dateTxt setFont:customFontds];
        dateTxt.delegate = self;
        dateTxt.textAlignment = UITextAlignmentCenter;
        dateTxt.textColor=[UIColor whiteColor];
        dateTxt.layer.cornerRadius=8.0f;
        dateTxt.layer.masksToBounds=YES;
        dateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        dateTxt.layer.borderWidth= 1.0f;
        [dateTxt setBackgroundColor:[UIColor clearColor]];
        dateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
        [cell.contentView addSubview:dateTxt];


    }else if (indexPath.row==1){
        UILabel  *ReceiptName=[[UILabel alloc]init ];
        ReceiptName.layer.frame=CGRectMake(10,5,250,screenRect.size.height*0.06);
        ReceiptName.text=[expensesListArray objectAtIndex:indexPath.row];
        [ReceiptName setFont:customFontd];
        ReceiptName.textColor=[UIColor whiteColor];
        [ReceiptName setBackgroundColor:[UIColor clearColor]];
        ReceiptName.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:ReceiptName];
        
        if (expenceTypeTxt==nil)
        expenceTypeTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40, 5, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [expenceTypeTxt setFont:customFontds];
        expenceTypeTxt.delegate = self;
        expenceTypeTxt.textAlignment = UITextAlignmentCenter;
        expenceTypeTxt.textColor=[UIColor whiteColor];
        expenceTypeTxt.layer.cornerRadius=8.0f;
        expenceTypeTxt.layer.masksToBounds=YES;
        expenceTypeTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        expenceTypeTxt.layer.borderWidth= 1.0f;
        [expenceTypeTxt setBackgroundColor:[UIColor clearColor]];
        expenceTypeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Expenses Type" attributes:@{NSForegroundColorAttributeName: color}];
        [cell.contentView addSubview:expenceTypeTxt];

    }else if (indexPath.row==2){
        UILabel  *ReceiptName=[[UILabel alloc]init ];
        ReceiptName.layer.frame=CGRectMake(10,10,250,screenRect.size.height*0.06);
        ReceiptName.text=[expensesListArray objectAtIndex:indexPath.row];
        [ReceiptName setFont:customFontd];
        ReceiptName.textColor=[UIColor whiteColor];
        [ReceiptName setBackgroundColor:[UIColor clearColor]];
        ReceiptName.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:ReceiptName];
        
        if (amountTxt==nil)
        amountTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40, 5, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [amountTxt setFont:customFontds];
        amountTxt.delegate = self;
        amountTxt.textAlignment = UITextAlignmentCenter;
        amountTxt.textColor=[UIColor whiteColor];
        amountTxt.layer.cornerRadius=8.0f;
        amountTxt.layer.masksToBounds=YES;
        amountTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        amountTxt.layer.borderWidth= 1.0f;
        [amountTxt setBackgroundColor:[UIColor clearColor]];
        [amountTxt setKeyboardType:UIKeyboardTypeDecimalPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        amountTxt.inputAccessoryView = numberToolbar;

        amountTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: color}];
        [cell.contentView addSubview:amountTxt];


    }else if (indexPath.row==3){
        UILabel  *ReceiptName=[[UILabel alloc]init ];
        ReceiptName.layer.frame=CGRectMake(10,10,screenRect.size.width*0.35,screenRect.size.height*0.06);
        ReceiptName.text=[expensesListArray objectAtIndex:indexPath.row];
        [ReceiptName setFont:customFontd];
        ReceiptName.textColor=[UIColor whiteColor];
        [ReceiptName setBackgroundColor:[UIColor clearColor]];
        ReceiptName.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:ReceiptName];
        
        if (commentTxtview==nil)
         commentTxtview=[[UITextView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40, 10, screenRect.size.width*0.58, screenRect.size.height*0.10)];
        [commentTxtview setBackgroundColor:[UIColor clearColor]];
        commentTxtview.textColor=[UIColor whiteColor];
        commentTxtview.layer.borderColor=[[UIColor whiteColor]CGColor];
        commentTxtview.layer.borderWidth= 1.0f;
        [commentTxtview setFont:customFontds];
        commentTxtview.text=@"Comment....";
        commentTxtview.delegate=self;
        [cell.contentView addSubview:commentTxtview];

        
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    commentTxtview.text = @"";
    commentTxtview.textColor = [UIColor whiteColor];
    return YES;
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(commentTxtview.text.length == 0){
        commentTxtview.textColor = [UIColor lightGrayColor];
        commentTxtview.text = @"Comment....";
        [commentTxtview resignFirstResponder];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([commentTxtview.text isEqualToString:@""]) {
        commentTxtview.text = @"Comment....";
        commentTxtview.textColor = [UIColor lightGrayColor]; //optional
    }
    [commentTxtview resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==dateTxt)
    {

    
    datepicker.hidden=YES;
    dateToolbar.hidden=YES;
        datepicker=[[UIDatePicker alloc]init];
    dateToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        datepicker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
    datepicker.frame=CGRectMake(0, 355,self.view.bounds.size.width, 210);
    [self.view addSubview:datepicker];

    [dateToolbar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneDate)];
    dateToolbar.items = @[barButtonDone];
    barButtonDone.tintColor=[UIColor whiteColor];
    [self.view addSubview:dateToolbar];
    datepicker.timeZone = [NSTimeZone timeZoneWithName: @"PST"];
    dateToolbar.hidden=NO;
    datepicker.hidden=NO;
    
    [dateTxt resignFirstResponder];
    
    return NO;
    }
    
    else if (textField==expenceTypeTxt){
        [self expensesTypeAction];
        return NO;
    }
    datepicker.hidden=YES;
    dateToolbar.hidden=YES;
    return YES;

}
-(void)doneDate{
    NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
    [f2 setDateFormat:@"LL/dd/YYYY"];
    NSString *s = [f2 stringFromDate:datepicker.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"PST"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateTxt.text=[dateFormatter stringFromDate:datepicker.date];
    [dateFormatter setDateFormat:@"EEEE"];
    
    dateToolbar.hidden=YES;
    datepicker.hidden=YES;
    
}


- (IBAction)UploadImageAction:(id)sender
{
    // Here we need to pass a full frame
    imgUloadalertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [imgUloadalertView setContainerView:[self changePassAlert]];
    // Modify the parameters
    [imgUloadalertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [imgUloadalertView setUseMotionEffects:true];
    // And launch the dialog
    [imgUloadalertView show];
}
-(UIView *)changePassAlert{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,200)];
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
    
    UIButton *galleryOption=[[UIButton alloc] initWithFrame:CGRectMake(0,50, 300,48)];
    [galleryOption setTitle:@"Gallery" forState:UIControlStateNormal];
    [galleryOption addTarget:self
                      action:@selector(galleryOption)
            forControlEvents:UIControlEventTouchUpInside];
    [galleryOption setBackgroundImage:[UIImage imageNamed:@"invoicelistitem.PNG"] forState:UIControlStateNormal];
    galleryOption.tag=1;
    [demoView addSubview:galleryOption];
    
    UIButton *cameraOption=[[UIButton alloc] initWithFrame:CGRectMake(0,102, 300,50)];
    [cameraOption setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraOption addTarget:self
                     action:@selector(cameraOption)
           forControlEvents:UIControlEventTouchUpInside];
    [cameraOption setBackgroundImage:[UIImage imageNamed:@"invoicelistitem.PNG"] forState:UIControlStateNormal];
    cameraOption.tag=1;
    [demoView addSubview:cameraOption];
    
    
   UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,150,300,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:cancelBtn];
    return demoView;
    
}
- (void)expensesTypeAction
{
    // Here we need to pass a full frame
    expensAlertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [expensAlertView setContainerView:[self expensesTypeAlert]];
    // Modify the parameters
    [expensAlertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [expensAlertView setUseMotionEffects:true];
    // And launch the dialog
    [expensAlertView show];
}
-(UIView *)expensesTypeAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *demoView;
    UIButton *cancelBtn,*alertnameBtn;
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,350)];
    
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
    
    expenseAlertScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,50,300,250)];
    [expenseAlertScrollview setBackgroundColor:[UIColor clearColor]];
    
    int yValue=0;
    
    for (int count=0; count<[expenseTypeArray count]; count++) {
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,300,30)];
        [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
        [expenseAlertScrollview addSubview:borderImg];
        
        alertnameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, yValue,300,30)];
        [alertnameBtn setTitle:[expenseTypeArray objectAtIndex:count] forState:UIControlStateNormal];
        alertnameBtn.tag=count;
        UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
        alertnameBtn.titleLabel.font= customFontd;
        [alertnameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [alertnameBtn setBackgroundColor:[UIColor clearColor]];
        [alertnameBtn addTarget:self action:@selector(countryinfoAction:) forControlEvents:UIControlEventTouchUpInside];
        alertnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [expenseAlertScrollview addSubview:alertnameBtn];
        
        yValue=yValue+35;
        
        
    }
    [demoView addSubview:expenseAlertScrollview];
    
    expenseAlertScrollview.contentSize = CGSizeMake(300,8750);
    expenseAlertScrollview.scrollEnabled=YES;
    
    cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(0,300,300,50)];
    
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
    
}



-(void)countryinfoAction:(UIButton *)Btn{
    
    expenceTypeTxt.text=[expenseTypeArray objectAtIndex:Btn.tag];
    [expensAlertView close];
}

-(void)closeAlert:(id)sender{
    [imgUloadalertView close];
    [expensAlertView close];

}
-(void)galleryOption{
    [imgUloadalertView close];
    
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    
}
-(void)cameraOption{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"PGFH" message:@"Sorry, you do not have a camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        return;
    }
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    [imgUloadalertView close];
    
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
        [controller setDelegate:self];
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popover setDelegate:self];
        [popover presentPopoverFromRect:CGRectMake(455, 665, 30, 30) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        popover.popoverContentSize = CGSizeMake(315, 500);
        // [controller release];
    }
    else
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        if ([imageArray count]==5) {
            UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Sorry, no more than 5 images" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];

            
        }else{
            NSError *error;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
            
            NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
            [DateFormatter setDateFormat:@"yyyy.MM.dd.hh:mm:ss"];
            NSString* fileName = [NSString stringWithFormat:@"/MyFolder/%@.png",[DateFormatter stringFromDate:[NSDate date]]];
            
            savedImagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
            
            NSLog(@"image save path %@",savedImagePath);
            NSData *imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:savedImagePath atomically:NO];
            CGSize newSize;
            
            UIGraphicsBeginImageContext(newSize);
            UIGraphicsEndImageContext();

        if ([imageArray count]==0) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=0;

        } else if ([imageArray count]==1) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=1;

        }
       else if ([imageArray count]==2) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
           cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.23, 20, 20)];
           cancelBtn.tag=2;

        }
       else if ([imageArray count]==3) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
           cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.23, 20, 20)];
           cancelBtn.tag=3;

        }
      else  if ([imageArray count]==4) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
          cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.23, 20, 20)];
          cancelBtn.tag=4;

        }
            [imageArray addObject:savedImagePath];

        [receiptPicture removeFromSuperview];
        [receiptPicture setImage:[UIImage imageNamed:savedImagePath]];
        [imageallView addSubview:receiptPicture];
            
            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
            cancelBtn.backgroundColor=[UIColor clearColor];
            [cancelBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
            [imageallView addSubview:cancelBtn];
            [imageallView bringSubviewToFront:cancelBtn];

        }
    
    
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    
    //[self performSelector:@selector(pushView) withObject:nil afterDelay:0.2];
}
-(void)deleteImg:(UIButton*)btn{
    int tags=btn.tag;
    
    [imageArray removeObjectAtIndex:tags];
    NSArray *viewsToRemove = [self.imageallView subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    imageallView=[[UIView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.60,screenRect.size.width,screenRect.size.height*0.40)];
    [imageallView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageallView];

    UIButton* receiptuploadBtn=[[UIButton alloc]init];
    receiptuploadBtn.frame=CGRectMake(screenRect.size.width*0.03, screenRect.size.height*0.02, screenRect.size.width*0.25, screenRect.size.height*0.18);
    [receiptuploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [receiptuploadBtn setBackgroundImage:[UIImage imageNamed:@"addreceipticon.PNG"] forState:UIControlStateNormal];
    [receiptuploadBtn addTarget:self action:@selector(UploadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageallView addSubview:receiptuploadBtn];

    for (int count=0; count<imageArray.count; count++) {
        if (count==0) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=0;
            
        } else if (count==1) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.02,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.03, 20, 20)];
            cancelBtn.tag=1;
            
        }
        else if (count==2) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=2;
            
        }
        else if (count==3) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.33,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=3;
            
        }
        else  if (count==4) {
            receiptPicture = [[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.height*0.18)];
            cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,screenRect.size.height*0.23, 20, 20)];
            cancelBtn.tag=4;
            
        }
        
        [receiptPicture removeFromSuperview];
        [receiptPicture setImage:[UIImage imageNamed:[imageArray objectAtIndex:count]]];
        [imageallView addSubview:receiptPicture];
        
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        cancelBtn.backgroundColor=[UIColor clearColor];
        [cancelBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
        [imageallView addSubview:cancelBtn];
        [imageallView bringSubviewToFront:cancelBtn];

    }
    
    if ([tempimageArray count]>0) {
        int arraycount=[tempimageArray count]-1;
        if (tags<=arraycount) {
            sqlite3_stmt *statement;
            NSString *insertSQL;
            ImageVO *imageVo=[tempimageArray objectAtIndex:btn.tag];
            insertSQL = [NSString stringWithFormat:
                         @"DELETE FROM ExpenseImageTable WHERE image_name='%@'",imageVo.imageNameStr];
            
            NSLog(@"Delete = %@",insertSQL);
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(ScanDB, insert_stmt,
                               -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"event detail contestant position delete");
            }else{
                NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
            }
            
        }

        }
}
-(void)doneWithNumberPad{
    [amountTxt resignFirstResponder];
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
