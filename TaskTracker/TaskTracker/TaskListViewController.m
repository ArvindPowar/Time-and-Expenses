//
//  TaskListViewController.m
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "TaskListViewController.h"
#import "NewTaskViewController.h"
#import "UIColor+Expanded.h"
#import "ClientVO.h"
#import "DefaultRateSettingViewController.h"
#import "ProjectVO.h"
#import "ProjectListViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *kDeleteAllTitle = @"Delete All";
static NSString *kDeletePartialTitle = @"Delete (%d)";

@interface TaskListViewController ()

@end

@implementation TaskListViewController
@synthesize editButton,cancelButton,addButton,deleteButton,dataArray,alertViewNewPro,demoView,addProjectTxt,selectclientLbl,projectlocatioLbl,settingLbl,clientSettingLbl,ratehourlyLbl,taxLbl,overtimeHourLbl,overtimerateLbl,dailyhoursLbl,weeklyLbl,clientTxt,projectLocationTxt,ratehourlyTxt,taxTxt,overtimehourTxt,overtimerateTxt,vatLbl,vatTxt,weeklycalBtn,dailycalBtn,ownsettingBtn,clientsettingBtn,ScanDB,usesettingStr,calculateovertimeStr,mainNameArray,tableview,projectnameTxt,overtimepicker,overtimeratetoolbar,overtimerateArray,clientPickerview,clientToolbar,appDelegate,ratePickerview,rateToolbar,rateArray,cityTxt,StateTxt,ZipTxt,calculateOverTimeTxt,calculateOvertimePickerview,caloverToolbar,calovertimeArray,projectlocationBtn,scrollView,alert,clientID,clientNameselected,overtimeRateStr,overtimealertView,alertviewTxt,clientrateStr,clienttaxStr,clientvatStr,clientcaloverTimeStr,clienttimehourStr,clientovertimeRateStr,countryTxt,countryAlertView,countryscrollview,countryArray,normalRateTxt,defaultratevalue;



- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    //[self.view addSubview:bgImage];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];

    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Add project"];
    titleLabel.textColor=[UIColor whiteColor];
    UIFont *customFontdt = [UIFont fontWithName:@"BrandonText-Bold" size:screenRect.size.width*0.03];
    titleLabel.font =customFontdt;
    self.navigationItem.titleView = titleLabel;
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(InsertRecords)];
    self.deleteButton.tintColor = [UIColor redColor];
    self.editButton.tintColor = [UIColor whiteColor];
    self.addButton.tintColor = [UIColor whiteColor];

    [self.navigationItem setLeftBarButtonItem:self.editButton];
    [self.navigationItem setRightBarButtonItem:self.addButton];
    ScanDB=[self getNewDb];
    overtimerateArray=[[NSMutableArray alloc]initWithObjects:@"1.5 X",@"2.5 X",@"3.5 X",@"4.5 X",@"5.5 X",@"Custom X",@"%", nil];
    mainNameArray=[[NSMutableArray alloc]initWithObjects:@"Select Client",@"Project Name",@"Project Location",@"Address",@"City",@"State",@"Zip",@"Country",@"Apply Default Setting",@"Default Client settings",@"Rate hourly/ daily/ project",@"Tax",@"Vat",@"Calculate  OverTime",@"Over time",@"Overtime rate",@"Default Rate Value", nil];
    calovertimeArray=[[NSMutableArray alloc]initWithObjects:@"Daily",@"Weekly", nil];

    rateArray=[[NSMutableArray alloc]initWithObjects:@"Hourly Rate",@"Daily Rate",@"Project", nil];

 countryArray = [[NSMutableArray alloc] initWithObjects:@"Abkhazia",@"Afghanistan",@"Aland",@"Albania",@"Algeria",    @"American Samoa",@"Andorra",@"Angola",@"Anguilla",@"Antarctica",@"Antigua & Barbuda",@"Argentina",
    @"Armenia",@"Aruba",@"Australia",@"Austria",@"Azerbaijan",@"Bahamas",@"Bahrain",@"Bangladesh",@"Barbados",@"Belarus",@"Belgium",@"Belize",@"Benin",@"Bermuda",@"Bhutan",@"Bolivia",@"Bosnia & Herzegovina",@"Botswana",@"Brazil",@"British Antarctic Territory",@"British Virgin Islands",@"Brunei",@"Bulgaria",@"Burkina Faso",@"Burundi",@"Cambodia",@"Cameroon",@"Canada",@"Cape Verde",@"Cayman Islands",@"Central African Republic",@"Chad",@"Chile",@"China",@"Christmas Island",@"Cocos Keeling Islands",@"Colombia",@"Commonwealth",@"Comoros",@"Cook Islands",@"Costa Rica",@"Cote d'Ivoire",@"Croatia",@"Cuba",@"Cyprus",@"Czech Republic",@"Democratic Republic of the Congo",@"Denmark",@"Djibouti",@"Dominica",@"Dominican Republic",@"East Timor",@"Ecuador",@"Egypt",
    @"El Salvador",@"England",@"Equatorial Guinea",@"Eritrea",@"Estonia",@"Ethiopia",@"European Union",
    @"Falkland Islands",@"Faroes",@"Fiji",@"Finland",@"France",@"Gabon",@"Gambia",@"Georgia",@"Germany",@"Ghana",
    @"Gibraltar",@"GoSquared",@"Greece",@"Greenland",@"Grenada",@"Guam",@"Guatemala",@"Guernsey",@"Guinea Bissau",@"Guinea",@"Guyana",@"Haiti",@"Honduras",@"Hong Kong",@"Hungary",@"Iceland",@"India",@"Indonesia",@"Iran",@"Iraq",@"Ireland",@"Isle of Man",@"Israel",@"Italy",@"Jamaica",@"Japan",@"Jersey",@"Jordan",@"Kazakhstan",@"Kenya",@"Kiribati",
@"Kosovo",@"Kuwait",@"Kyrgyzstan",@"Laos",@"Latvia",@"Lebanon",@"Lesotho",@"Liberia",@"Libya",@"Liechtenstein",@"Lithuania",@"Luxembourg",@"Macau",@"Macedonia",@"Madagascar",@"Malawi",@"Malaysia", @"Maldives",@"Mali",@"Malta",@"Mars",@"Marshall Islands",@"Mauritania",@"Mauritius",@"Mayotte",@"Mexico",@"Micronesia",@"Moldova",@"Monaco",    @"Mongolia",@"Montenegro",@"Montserrat",@"Morocco",@"Mozambique",@"Myanmar",@"Nagorno Karabakh",    @"Namibia",@"NATO",@"Nauru",@"Nepal",@"Netherlands Antilles",@"Netherlands",@"New Caledonia",@"New Zealand",@"Nicaragua",@"Niger",@"Nigeria",@"Niue",@"Norfolk Island",@"North Korea",@"Northern Cyprus",@"Northern Mariana Islands",@"Norway",@"Olympics",@"Oman",@"Pakistan",@"Palau",@"Palestine",    @"Panama",@"Papua New Guinea",@"Paraguay",@"Peru",@"Philippines",@"Pitcairn Islands",@"Poland",    @"Portugal",@"Puerto Rico",@"Qatar",@"Red Cross",@"Republic of the Congo",@"Romania",@"Russia",    @"Rwanda",@"Saint Barthelemy",@"Saint Helena",@"Saint Kitts & Nevis",@"Saint Lucia",@"Saint Vincent & the Grenadines",@"Samoa",@"San Marino",@"Sao Tome & Principe",@"Saudi Arabia",@"Scotland",@"Senegal",    @"Serbia",@"Seychelles",@"Sierra Leone",@"Singapore",@"Slovakia",@"Slovenia",@"Solomon Islands",    @"Somalia",@"Somaliland",@"South Africa",@"South Georgia & the South Sandwich Islands",@"South Korea",@"South Ossetia",@"South Sudan",@"Spain",@"Sri Lanka",@"Sudan",@"Suriname",@"Swaziland",@"Sweden",    @"Switzerland",@"Syria",@"Taiwan",@"Tajikistan",@"Tanzania",@"Thailand",@"Togo",@"Tonga",@"Trinidad & Tobago",@"Tunisia",@"Turkey",@"Turkmenistan",@"Turks & Caicos Islands",@"Tuvalu",@"Uganda",@"Ukraine",@"United Arab Emirates",@"United Kingdom",@"United Nations",@"United States",@"Uruguay",@"US Virgin Islands",@"Uzbekistan",@"Vanuatu",@"Vatican City",@"Venezuela",@"Vietnam",@"Wales",@"Western Sahara",
    @"Yemen",@"Zambia",@"Zimbabwe", nil];
    //scrollView.contentSize = CGSizeMake(screenRect.size.width,screenRect.size.height+540);
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,70,screenRect.size.width,screenRect.size.height-70)];
    self.tableview.separatorColor = [UIColor clearColor];
    [tableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.view addSubview:tableview];
     tableview.delegate = self;
    tableview.dataSource = self;
   // tableview.scrollEnabled = NO;


}


-(void)viewDidAppear:(BOOL)animated{
    if (![clientNameselected isEqualToString:@""]) {
        clientTxt.text=clientNameselected;
    }
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

-(void)InsertRecords{
    sqlite3_stmt *statement;
    NSLog(@"[self getDestPath] = %@",[self getDestPath]);
    NSNumber *lastId = 0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    if (sqlite3_open([[self getDestPath] UTF8String], &ScanDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"insert into ProjectDetailsTable (client_id,user_id,project_name,project_location,usedefaultsetting,ratehourly_daily_project,project_tax,project_vat,projectovertimehour,projectovertimerate,projectdaily_weekly,active_project,project_city,project_state,project_zip,project_country,defaultprojectrate) VALUES (%d,%@,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"YES\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",clientID,[prefs stringForKey:@"loggedin"],projectnameTxt.text,projectLocationTxt.text,usesettingStr,ratehourlyTxt.text,taxTxt.text,vatTxt.text,overtimehourTxt.text,overtimerateTxt.text,calculateOverTimeTxt.text,cityTxt.text,StateTxt.text,ZipTxt.text,countryTxt.text,normalRateTxt.text];
        
        
        NSLog(@"insertSQL = %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(ScanDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"record inserted");
            lastId = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(ScanDB)];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                            message:@"Save successfully."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self getProjectList];
        }else{
            NSLog(@"record insertion failed");
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(ScanDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(ScanDB);
    }
}

-(IBAction)redioBtnAction:(id)sender{
    calculateovertimeStr=[[NSString alloc]init];
    switch ([sender tag]) {
        case 0:
            if([dailycalBtn isSelected]==YES)
            {
                [dailycalBtn setSelected:NO];
                [weeklycalBtn setSelected:NO];
                calculateovertimeStr=@"";

            }
            else{
                [dailycalBtn setSelected:YES];
                [weeklycalBtn setSelected:NO];
                calculateovertimeStr=@"Daily";

            }
            break;
        case 1:
            if([weeklycalBtn isSelected]==YES)
            {
                [dailycalBtn setSelected:NO];
                [weeklycalBtn setSelected:NO];
                calculateovertimeStr=@"";

            }
            else{
                [weeklycalBtn setSelected:YES];
                [dailycalBtn setSelected:NO];
                calculateovertimeStr=@"Weekly";

            }
            break;
    }
}
-(IBAction)redioSettingBtnAction:(id)sender{
    usesettingStr=[[NSString alloc]init];

    switch ([sender tag]) {
        case 3:
            if([ownsettingBtn isSelected]==YES)
            {
                [ownsettingBtn setSelected:NO];
                [clientsettingBtn setSelected:NO];
                usesettingStr=@"";
                ratehourlyTxt.text=@"";
                taxTxt.text=@"";
                vatTxt.text=@"";
                calculateOverTimeTxt.text=@"";
                overtimehourTxt.text=@"";
                overtimerateTxt.text=@"";
                ratehourlyTxt.enabled=YES;
                taxTxt.enabled=YES;
                vatTxt.enabled=YES;
                calculateOverTimeTxt.enabled=YES;
                overtimehourTxt.enabled=YES;
                overtimerateTxt.enabled=YES;

            }
            else{
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                if([prefs stringForKey:@"ClientSetting"]!=nil){

                [ownsettingBtn setSelected:YES];
                [clientsettingBtn setSelected:NO];
                usesettingStr=@"Default Setting";
                    
                    ratehourlyTxt.text=[prefs stringForKey:@"ProjectRateType"];
                    taxTxt.text=[prefs stringForKey:@"ProjectTax"];
                    vatTxt.text=[prefs stringForKey:@"ProjectVat"];
                    calculateOverTimeTxt.text=[prefs stringForKey:@"ProjectCalOverTime"];
                    overtimehourTxt.text=[prefs stringForKey:@"ProjectOverTime"];
                    overtimerateTxt.text=[prefs stringForKey:@"ProjectOverTimeRate"];
                    normalRateTxt.text=[prefs stringForKey:@"defaultratevalue"];
                    
                    ratehourlyTxt.enabled=NO;
                    taxTxt.enabled=NO;
                    vatTxt.enabled=NO;
                    calculateOverTimeTxt.enabled=NO;
                    overtimehourTxt.enabled=NO;
                    overtimerateTxt.enabled=NO;

                }else{
                    alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please add project setting" delegate:self cancelButtonTitle:@"Add Default Setting" otherButtonTitles:@"Cancel", nil];
                    
                    [alert show];

                }
            }
            break;
        case 4:
            
            if([clientsettingBtn isSelected]==YES)
            {
                [ownsettingBtn setSelected:NO];
                [clientsettingBtn setSelected:NO];
                usesettingStr=@"";
                ratehourlyTxt.text=@"";
                taxTxt.text=@"";
                vatTxt.text=@"";
                calculateOverTimeTxt.text=@"";
                overtimehourTxt.text=@"";
                overtimerateTxt.text=@"";
                ratehourlyTxt.enabled=YES;
                taxTxt.enabled=YES;
                vatTxt.enabled=YES;
                calculateOverTimeTxt.enabled=YES;
                overtimehourTxt.enabled=YES;
                overtimerateTxt.enabled=YES;

            }
            else{

                [clientsettingBtn setSelected:YES];
                [ownsettingBtn setSelected:NO];
                usesettingStr=@"Client Setting";
                    ratehourlyTxt.text=clientrateStr;
                    taxTxt.text=clienttaxStr;
                    vatTxt.text=clientvatStr;
                    calculateOverTimeTxt.text=clientcaloverTimeStr;
                    overtimehourTxt.text=clienttimehourStr;
                    overtimerateTxt.text=clientovertimeRateStr;
                    normalRateTxt.text=defaultratevalue;

                    ratehourlyTxt.enabled=NO;
                    taxTxt.enabled=NO;
                    vatTxt.enabled=NO;
                    calculateOverTimeTxt.enabled=NO;
                    overtimehourTxt.enabled=NO;
                    overtimerateTxt.enabled=NO;

                    }
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Add Default Setting"]){
        DefaultRateSettingViewController *setting=[[DefaultRateSettingViewController alloc]initWithNibName:@"DefaultRateSettingViewController" bundle:nil];
        appDelegate.SettingStr=[[NSString alloc]init];
        appDelegate.SettingStr=@"Project Setting";
        [self.navigationController pushViewController:setting animated:YES];
    }
    if([title isEqualToString:@"OK"]){
        ProjectListViewController *projectList=[[ProjectListViewController alloc]initWithNibName:@"ProjectListViewController" bundle:nil];
        [self.navigationController pushViewController:projectList animated:YES];
    }
    

    if([title isEqualToString:@"Add Client setting"]){
        DefaultRateSettingViewController *setting=[[DefaultRateSettingViewController alloc]initWithNibName:@"DefaultRateSettingViewController" bundle:nil];
        appDelegate.SettingStr=[[NSString alloc]init];
        appDelegate.SettingStr=@"Client Setting";
        [self.navigationController pushViewController:setting animated:YES];
    }
}
-(void)closeAlert:(id)sender{
    [alertViewNewPro close];
}
-(IBAction)backAction{
    ProjectListViewController *projectList=[[ProjectListViewController alloc]initWithNibName:@"ProjectListViewController" bundle:nil];
    [self.navigationController pushViewController:projectList animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return NO;
}
-(void)getProjectList{
    char *dbChars ;
    appDelegate.allprojectArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ProjectDetailsTable"];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(ScanDB, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
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
}

-(IBAction)saveAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([currentString isEqualToString:@"Fac"]) {
        textField.text = @"Factory";
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    addProjectTxt.text = @"";
    addProjectTxt.textColor = [UIColor blackColor];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==overtimerateTxt)
    {
        [overtimerateTxt setText:[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:0]]];

        [vatTxt resignFirstResponder];
        [taxTxt resignFirstResponder];
        [projectnameTxt resignFirstResponder];
        [addProjectTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [StateTxt resignFirstResponder];
        [ZipTxt resignFirstResponder];
        [countryTxt resignFirstResponder];

        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        clientPickerview.hidden=YES;
        clientToolbar.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        overtimepicker = [[UIPickerView alloc] init];
        [overtimepicker setDataSource: self];
        [overtimepicker setDelegate: self];
        overtimepicker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [overtimepicker setFrame: CGRectMake(0,355,self.view.bounds.size.width,210)];
        overtimepicker.showsSelectionIndicator = YES;
        [overtimepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: overtimepicker];
        overtimepicker.hidden=NO;
        overtimeratetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [overtimeratetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(dialogAction)];
        overtimeratetoolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:overtimeratetoolbar];
        
        overtimeratetoolbar.hidden=NO;
        [overtimerateTxt resignFirstResponder];
        
        return NO;
        
    }else if(textField==clientTxt)
    {
        if (appDelegate.allclientArray>=0) {
            ClientVO *clientVo=[appDelegate.allclientArray objectAtIndex:0];
            clientID=[clientVo.clientidStr intValue];
            [clientTxt setText:clientVo.clientnameStr];

            [vatTxt resignFirstResponder];
            [taxTxt resignFirstResponder];
            [projectnameTxt resignFirstResponder];
            [addProjectTxt resignFirstResponder];
            [cityTxt resignFirstResponder];
            [StateTxt resignFirstResponder];
            [ZipTxt resignFirstResponder];
            [countryTxt resignFirstResponder];

            overtimeratetoolbar.hidden=YES;
            overtimepicker.hidden=YES;
            clientPickerview.hidden=YES;
            clientToolbar.hidden=YES;
            ratePickerview.hidden=YES;
            rateToolbar.hidden=YES;
            calculateOvertimePickerview.hidden=YES;
            caloverToolbar.hidden=YES;

        clientPickerview = [[UIPickerView alloc] init];
        [clientPickerview setDataSource: self];
        [clientPickerview setDelegate: self];
        clientPickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [clientPickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,210)];
        clientPickerview.showsSelectionIndicator = YES;
        [clientPickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: clientPickerview];
        clientPickerview.hidden=NO;
        clientToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [clientToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        clientToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:clientToolbar];
        
        clientToolbar.hidden=NO;
        [clientTxt resignFirstResponder];
        
        return NO;
        }
    }else if(textField==ratehourlyTxt)
    {
        [ratehourlyTxt setText:[NSString stringWithFormat:@"%@",[rateArray objectAtIndex:0]]];

        [vatTxt resignFirstResponder];
        [taxTxt resignFirstResponder];
        [projectnameTxt resignFirstResponder];
        [addProjectTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [StateTxt resignFirstResponder];
        [ZipTxt resignFirstResponder];
        [countryTxt resignFirstResponder];

        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        clientPickerview.hidden=YES;
        clientToolbar.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;

        ratePickerview = [[UIPickerView alloc] init];
        [ratePickerview setDataSource: self];
        [ratePickerview setDelegate: self];
        ratePickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [ratePickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,210)];
        ratePickerview.showsSelectionIndicator = YES;
        [ratePickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: ratePickerview];
        ratePickerview.hidden=NO;
        rateToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [rateToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        rateToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:rateToolbar];
        
        rateToolbar.hidden=NO;
        [ratehourlyTxt resignFirstResponder];
        
        return NO;
    }else if(textField==calculateOverTimeTxt)
    {
        [calculateOverTimeTxt setText:[NSString stringWithFormat:@"%@",[calovertimeArray objectAtIndex:0]]];

        [vatTxt resignFirstResponder];
        [taxTxt resignFirstResponder];
        [projectnameTxt resignFirstResponder];
        [addProjectTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [StateTxt resignFirstResponder];
        [ZipTxt resignFirstResponder];
        [countryTxt resignFirstResponder];

        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        clientPickerview.hidden=YES;
        clientToolbar.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        
        calculateOvertimePickerview = [[UIPickerView alloc] init];
        [calculateOvertimePickerview setDataSource: self];
        [calculateOvertimePickerview setDelegate: self];
        calculateOvertimePickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [calculateOvertimePickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,210)];
        calculateOvertimePickerview.showsSelectionIndicator = YES;
        [calculateOvertimePickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: calculateOvertimePickerview];
        calculateOvertimePickerview.hidden=NO;
        caloverToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [caloverToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        caloverToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:caloverToolbar];
        
        caloverToolbar.hidden=NO;
        [calculateOverTimeTxt resignFirstResponder];
        
        return NO;
    }
    
    else if (textField==countryTxt)
    {
        [self countryAction];
        return NO;

    }
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    clientPickerview.hidden=YES;
    clientToolbar.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
    [self animateTextField:textField up:YES];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    
    int movementDistance = 0;
    if(99<textField.tag  &&   textField.tag<107){
        movementDistance=(-(15*7));
    }else if(199<textField.tag  &&   textField.tag<208){
        movementDistance=(-(17*8)); // tweak as needed
    }else if(299<textField.tag  &&   textField.tag<309){
        movementDistance=(-(15*9));
    }
    
    else if(399<textField.tag  &&   textField.tag<410){
        movementDistance=(-(20*10)); // tweak as needed
    }else if(499<textField.tag  &&   textField.tag<511){
        movementDistance=(-(15*11)); // tweak as needed
    }else if(599<textField.tag  &&   textField.tag<512){
        movementDistance=(-(15*12)); // tweak as needed
    }
    
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(IBAction)doneBtnPressed{
    [vatTxt resignFirstResponder];
    [taxTxt resignFirstResponder];
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    clientPickerview.hidden=YES;
    clientToolbar.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
}
-(IBAction)dialogAction{
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    clientPickerview.hidden=YES;
    clientToolbar.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
    
    if([overtimeRateStr isEqualToString:@"Custom X"]){
        [self overTimeDisplay];
    }else  if([overtimeRateStr isEqualToString:@"%"]){
        [self overTimeDisplay];
        
    }
    
}

- (void)overTimeDisplay
{
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    // Here we need to pass a full frame
    overtimealertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [overtimealertView setContainerView:[self changePassAlert]];
    // Modify the parameters
    [overtimealertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [overtimealertView setUseMotionEffects:true];
    // And launch the dialog
    [overtimealertView show];
}
-(UIView *)changePassAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,150)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Enter custom over time value" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:15]];
    [demoView addSubview:topButton];
    
    alertviewTxt=[[UITextField alloc]initWithFrame:CGRectMake(2,50,296,48)];
    [alertviewTxt setFont:[UIFont boldSystemFontOfSize:15]];
    alertviewTxt.delegate = self;
    alertviewTxt.textAlignment = UITextAlignmentCenter;
    alertviewTxt.textColor=[UIColor whiteColor];
    alertviewTxt.layer.cornerRadius=8.0f;
    alertviewTxt.layer.masksToBounds=YES;
    alertviewTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    alertviewTxt.layer.borderWidth= 1.0f;
    [alertviewTxt setBackgroundColor:[UIColor clearColor]];
    [alertviewTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    alertviewTxt.inputAccessoryView = numberToolbar;
    if([overtimeRateStr isEqualToString:@"Custom X"]){
        alertviewTxt.placeholder=@"Enter your over time rate value";
    }else{
        alertviewTxt.placeholder=@"Enter your over time presentage value";
    }
    [demoView addSubview:alertviewTxt];
    
    UIButton *SettimeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,100,148,50)];
    [SettimeBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [SettimeBtn addTarget:self
                   action:@selector(submitBtnAction)
         forControlEvents:UIControlEventTouchUpInside];
    [SettimeBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:SettimeBtn];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(152,100,150,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlerts:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:cancelBtn];
    return demoView;
    
}

- (void)countryAction
{
    // Here we need to pass a full frame
    countryAlertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [countryAlertView setContainerView:[self roundupdownAlert]];
    // Modify the parameters
    [countryAlertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [countryAlertView setUseMotionEffects:true];
    // And launch the dialog
    [countryAlertView show];
}
-(UIView *)roundupdownAlert{
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

        countryscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,50,300,250)];
        [countryscrollview setBackgroundColor:[UIColor clearColor]];
        
        int yValue=0;
        
        for (int count=0; count<[countryArray count]; count++) {
            UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,yValue,300,30)];
            [borderImg setImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
            [countryscrollview addSubview:borderImg];
            
            alertnameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, yValue,300,30)];
            [alertnameBtn setTitle:[countryArray objectAtIndex:count] forState:UIControlStateNormal];
            alertnameBtn.tag=count;
            UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.05];
            alertnameBtn.titleLabel.font= customFontd;
            [alertnameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [alertnameBtn setBackgroundColor:[UIColor clearColor]];
            [alertnameBtn addTarget:self action:@selector(countryinfoAction:) forControlEvents:UIControlEventTouchUpInside];
            alertnameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [countryscrollview addSubview:alertnameBtn];
            
            yValue=yValue+35;
            
        
    }
    [demoView addSubview:countryscrollview];
    
    countryscrollview.contentSize = CGSizeMake(300,8750);
    countryscrollview.scrollEnabled=YES;
    
    cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(0,300,300,50)];

    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlerts:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
    
}



-(void)countryinfoAction:(UIButton *)Btn{
    
    countryTxt.text=[countryArray objectAtIndex:Btn.tag];
        [countryAlertView close];
}

-(void)closeAlerts:(id)sender{
    [overtimealertView close];
    [countryAlertView close];
}

-(void)submitBtnAction{
    [overtimealertView close];
    if ([alertviewTxt.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please fill the value" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        [alert show];
        
    }else{
        if([overtimeRateStr isEqualToString:@"Custom X"]){
            NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            if([alertviewTxt.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
                // newString consists only of the digits 0 through 9
                NSLog(@"valide");
            }        overtimerateTxt.text=[NSString stringWithFormat:@"%@ X",alertviewTxt.text];
            
        }else{
            NSString * perStr=@"%";
            overtimerateTxt.text=[NSString stringWithFormat:@"%@ %@",alertviewTxt.text,perStr];
            
        }
    }
    
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == overtimepicker)
    {
        rowItem = [overtimerateArray objectAtIndex: row];
        
    }
    if (pickerView == ratePickerview)
    {
        rowItem = [rateArray objectAtIndex: row];
        
    }if (pickerView == calculateOvertimePickerview)
    {
        rowItem = [calovertimeArray objectAtIndex: row];
        
    }
    if ([pickerView isEqual: clientPickerview]) {
        
        ClientVO *clientVo=[appDelegate.allclientArray objectAtIndex: row];
        rowItem =clientVo.clientnameStr;
    }

    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: overtimepicker]) {
        return [overtimerateArray count];
    }
    if ([pickerView isEqual: clientPickerview]) {
        return [appDelegate.allclientArray count];
    }
    if ([pickerView isEqual: ratePickerview]) {
        return [rateArray count];
    }
    if ([pickerView isEqual: calculateOvertimePickerview]) {
        return [calovertimeArray count];
    }
    return 0;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==overtimepicker)
    {
        overtimeRateStr=[[NSString alloc]init];
        overtimeRateStr=[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:[pickerView selectedRowInComponent:0]]];

        [overtimerateTxt setText:[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else if (pickerView==clientPickerview){
        ClientVO *clientVo=[appDelegate.allclientArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        clientID=[clientVo.clientidStr intValue];
        [clientTxt setText:clientVo.clientnameStr];

    }else if (pickerView==ratePickerview){
        [ratehourlyTxt setText:[NSString stringWithFormat:@"%@",[rateArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        
    }else  if (pickerView ==calculateOvertimePickerview)
    {
        [calculateOverTimeTxt setText:[NSString stringWithFormat:@"%@",[calovertimeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == overtimepicker)
    {
        return [overtimerateArray objectAtIndex:row];
        
    }else if (pickerView==clientPickerview){
        ClientVO *clientVo=[appDelegate.allclientArray objectAtIndex:row];
        return clientVo.clientnameStr;
    }else if (pickerView==ratePickerview){
        return [rateArray objectAtIndex:row];
    }else if (pickerView == calculateOvertimePickerview)
    {
        return [calovertimeArray objectAtIndex:row];
        
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    
    return componentWidth;
}
-(void)doneWithNumberPad{
    
    [normalRateTxt resignFirstResponder];
    [ZipTxt resignFirstResponder];
    [vatTxt resignFirstResponder];
    [taxTxt resignFirstResponder];
    [alertviewTxt resignFirstResponder];
    [overtimehourTxt resignFirstResponder];
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    clientPickerview.hidden=YES;
    clientToolbar.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.clipsToBounds = YES;
    UIColor *color = [UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *cellView=[[UIView alloc] initWithFrame:CGRectMake(0, 1.5, screenRect.size.width, screenRect.size.height*0.07)];
    cellView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];

        UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(5,0,130,45)];
        [fieldLBls setText:[mainNameArray objectAtIndex:indexPath.row]];
        fieldLBls.textAlignment=NSTextAlignmentLeft;
        fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
        fieldLBls.numberOfLines = 0;
        fieldLBls.textColor=[UIColor whiteColor];
    UIFont *customFontdt = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.03];
        [fieldLBls setFont:customFontdt];
        [cellView addSubview:fieldLBls];
        if(indexPath.row==0){
            if(clientTxt==nil)
            clientTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [clientTxt setFont:customFontdt];
            clientTxt.delegate = self;
            clientTxt.textAlignment = UITextAlignmentRight;
            clientTxt.textColor=[UIColor whiteColor];
            clientTxt.layer.cornerRadius=8.0f;
            clientTxt.layer.masksToBounds=YES;
            clientTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            clientTxt.layer.borderWidth= 1.0f;
            [clientTxt setBackgroundColor:[UIColor clearColor]];
            clientTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select client" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(clientTxt.bounds.size.width, 0, 5, 20)];
            clientTxt.rightView = paddingView;
            clientTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:clientTxt];
        }else if(indexPath.row==1){
            if(projectnameTxt==nil)
            projectnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            projectnameTxt.font=customFontdt;
            projectnameTxt.textAlignment=UITextAlignmentRight;
            projectnameTxt.delegate = self;
            projectnameTxt.layer.cornerRadius=8.0f;
            projectnameTxt.layer.masksToBounds=YES;
            projectnameTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            projectnameTxt.layer.borderWidth= 1.0f;
            projectnameTxt.textColor=[UIColor whiteColor];
            [projectnameTxt setBackgroundColor:[UIColor clearColor]];
            projectnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Project Name  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(projectnameTxt.bounds.size.width, 0, 5, 20)];
            projectnameTxt.rightView = paddingView;
            projectnameTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:projectnameTxt];
        }else if(indexPath.row==2){
            if(projectlocationBtn==nil)
            projectlocationBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.90,5, screenRect.size.width*0.06,screenRect.size.height*0.04)];
            [projectlocationBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
            [projectlocationBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
            projectlocationBtn.layer.cornerRadius = 6.0f;
            [projectlocationBtn setTag:3];
            //[weeklycalBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
            [projectlocationBtn addTarget:self action:@selector(rediolocationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
           // [cell.contentView addSubview:projectlocationBtn];

        }
        else if(indexPath.row==3){
            if(projectLocationTxt==nil)
            projectLocationTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [projectLocationTxt setFont:customFontdt];
            projectLocationTxt.delegate = self;
            projectLocationTxt.layer.cornerRadius=8.0f;
            projectLocationTxt.layer.masksToBounds=YES;
            projectLocationTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            projectLocationTxt.layer.borderWidth= 1.0f;
            projectLocationTxt.textAlignment = UITextAlignmentRight;
            projectLocationTxt.textColor=[UIColor whiteColor];
            [projectLocationTxt setBackgroundColor:[UIColor clearColor]];
            projectLocationTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(projectLocationTxt.bounds.size.width, 0, 5, 20)];
            projectLocationTxt.rightView = paddingView;
            projectLocationTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:projectLocationTxt];
            
        }else if(indexPath.row==4){
            if(cityTxt==nil)
            cityTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [cityTxt setFont:customFontdt];
            cityTxt.delegate = self;
            cityTxt.layer.cornerRadius=8.0f;
            cityTxt.layer.masksToBounds=YES;
            cityTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            cityTxt.layer.borderWidth= 1.0f;
            cityTxt.textAlignment = UITextAlignmentRight;
            cityTxt.textColor=[UIColor whiteColor];
            [cityTxt setBackgroundColor:[UIColor clearColor]];
            cityTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(cityTxt.bounds.size.width, 0, 5, 20)];
            cityTxt.rightView = paddingView;
            cityTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:cityTxt];

        }else if(indexPath.row==5){
            if(StateTxt==nil)
                StateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [StateTxt setFont:customFontdt];
            StateTxt.delegate = self;
            StateTxt.layer.cornerRadius=8.0f;
            StateTxt.layer.masksToBounds=YES;
            StateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            StateTxt.layer.borderWidth= 1.0f;
            StateTxt.textAlignment = UITextAlignmentRight;
            StateTxt.textColor=[UIColor whiteColor];
            [StateTxt setBackgroundColor:[UIColor clearColor]];
            StateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(StateTxt.bounds.size.width, 0, 5, 20)];
            StateTxt.rightView = paddingView;
            StateTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:StateTxt];
            
        }else if(indexPath.row==6){
            if(ZipTxt==nil)
                ZipTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [ZipTxt setFont:customFontdt];
            ZipTxt.delegate = self;
            ZipTxt.layer.cornerRadius=8.0f;
            ZipTxt.layer.masksToBounds=YES;
            ZipTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            ZipTxt.layer.borderWidth= 1.0f;
            ZipTxt.textAlignment = UITextAlignmentRight;
            ZipTxt.textColor=[UIColor whiteColor];
            [ZipTxt setBackgroundColor:[UIColor clearColor]];
            [ZipTxt setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            ZipTxt.inputAccessoryView = numberToolbar;

            ZipTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(ZipTxt.bounds.size.width, 0, 5, 20)];
            ZipTxt.rightView = paddingView;
            ZipTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:ZipTxt];
            
        }else if(indexPath.row==7){
            if(countryTxt==nil)
                countryTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [countryTxt setFont:customFontdt];
            [self.countryTxt setDelegate:self];
            countryTxt.layer.cornerRadius=8.0f;
            countryTxt.layer.masksToBounds=YES;
            countryTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            countryTxt.layer.borderWidth= 1.0f;
            countryTxt.textAlignment = UITextAlignmentRight;
            countryTxt.textColor=[UIColor whiteColor];
            [countryTxt setBackgroundColor:[UIColor clearColor]];
            countryTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Country" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(countryTxt.bounds.size.width, 0, 5, 20)];
            countryTxt.rightView = paddingView;
            countryTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:countryTxt];
        }
        else if(indexPath.row==8){
            if(ownsettingBtn==nil)
            ownsettingBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.90,5,screenRect.size.width*0.06,screenRect.size.height*0.04)];
            [ownsettingBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
            [ownsettingBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
            ownsettingBtn.layer.cornerRadius = 6.0f;
            [ownsettingBtn setTag:3];
            //[ownsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
            [ownsettingBtn addTarget:self action:@selector(redioSettingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cellView addSubview:ownsettingBtn];
            
        }else if(indexPath.row==9){
            if(clientsettingBtn==nil)
            clientsettingBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.90,5,screenRect.size.width*0.06,screenRect.size.height*0.04)];
            [clientsettingBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonoff.PNG"] forState:UIControlStateNormal];
            [clientsettingBtn setBackgroundImage:[UIImage imageNamed:@"radiobuttonon.PNG"] forState:UIControlStateSelected];
            clientsettingBtn.layer.cornerRadius = 6.0f;
            [clientsettingBtn setTag:4];
            //[clientsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
            [clientsettingBtn addTarget:self action:@selector(redioSettingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cellView addSubview:clientsettingBtn];
        }else if(indexPath.row==10){
            if(ratehourlyTxt==nil)
            ratehourlyTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [ratehourlyTxt setFont:customFontdt];
            ratehourlyTxt.delegate = self;
            ratehourlyTxt.textAlignment = UITextAlignmentRight;
            ratehourlyTxt.layer.cornerRadius=8.0f;
            ratehourlyTxt.layer.masksToBounds=YES;
            ratehourlyTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            ratehourlyTxt.layer.borderWidth= 1.0f;
            ratehourlyTxt.textColor=[UIColor whiteColor];
            [ratehourlyTxt setBackgroundColor:[UIColor clearColor]];
            ratehourlyTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(ratehourlyTxt.bounds.size.width, 0, 5, 20)];
            ratehourlyTxt.rightView = paddingView;
            ratehourlyTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:ratehourlyTxt];

        }else if(indexPath.row==11){
            if(taxTxt==nil)
            taxTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [taxTxt setFont:customFontdt];
            taxTxt.delegate = self;
            taxTxt.textAlignment = UITextAlignmentRight;
            taxTxt.layer.cornerRadius=8.0f;
            taxTxt.layer.masksToBounds=YES;
            taxTxt.tag=100+indexPath.section;
            taxTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            taxTxt.layer.borderWidth= 1.0f;
            taxTxt.textColor=[UIColor whiteColor];
            [taxTxt setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            taxTxt.inputAccessoryView = numberToolbar;

            taxTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Tax  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(taxTxt.bounds.size.width, 0, 5, 20)];
            taxTxt.rightView = paddingView;
            taxTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:taxTxt];
        }else if(indexPath.row==12){
            if(vatTxt==nil)
            vatTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [vatTxt setFont:customFontdt];
            vatTxt.delegate = self;
            vatTxt.textAlignment = UITextAlignmentRight;
            vatTxt.layer.cornerRadius=8.0f;
            vatTxt.layer.masksToBounds=YES;
            vatTxt.tag=200+indexPath.section;
            vatTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            vatTxt.layer.borderWidth= 1.0f;
            vatTxt.textColor=[UIColor whiteColor];
            [vatTxt setBackgroundColor:[UIColor clearColor]];
            [vatTxt setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            vatTxt.inputAccessoryView = numberToolbar;

            vatTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Vat  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(vatTxt.bounds.size.width, 0, 5, 20)];
            vatTxt.rightView = paddingView;
            vatTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:vatTxt];

        }else if(indexPath.row==13){
            if(calculateOverTimeTxt==nil)
            calculateOverTimeTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [calculateOverTimeTxt setFont:customFontdt];
            calculateOverTimeTxt.delegate = self;
            calculateOverTimeTxt.textAlignment = UITextAlignmentRight;
            calculateOverTimeTxt.textColor=[UIColor whiteColor];
            calculateOverTimeTxt.layer.cornerRadius=8.0f;
            calculateOverTimeTxt.tag=300+indexPath.section;
            calculateOverTimeTxt.layer.masksToBounds=YES;
            calculateOverTimeTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            calculateOverTimeTxt.layer.borderWidth= 1.0f;
            [calculateOverTimeTxt setBackgroundColor:[UIColor clearColor]];
            calculateOverTimeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Calculate OverTime" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(calculateOverTimeTxt.bounds.size.width, 0, 5, 20)];
            calculateOverTimeTxt.rightView = paddingView;
            calculateOverTimeTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:calculateOverTimeTxt];

        }else if(indexPath.row==14){
            if(overtimehourTxt==nil)
            overtimehourTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [overtimehourTxt setFont:customFontdt];
            overtimehourTxt.delegate = self;
            overtimehourTxt.textAlignment = UITextAlignmentRight;
            overtimehourTxt.textColor=[UIColor whiteColor];
            overtimehourTxt.layer.cornerRadius=8.0f;
            overtimehourTxt.layer.masksToBounds=YES;
            overtimehourTxt.tag=400+indexPath.section;
            overtimehourTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            overtimehourTxt.layer.borderWidth= 1.0f;
            [overtimehourTxt setBackgroundColor:[UIColor clearColor]];
            [overtimehourTxt setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            overtimehourTxt.inputAccessoryView = numberToolbar;

            overtimehourTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Over time hours  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(overtimehourTxt.bounds.size.width, 0, 5, 20)];
            overtimehourTxt.rightView = paddingView;
            overtimehourTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:overtimehourTxt];

        }else if(indexPath.row==15){
            if(overtimerateTxt==nil)
            overtimerateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [overtimerateTxt setFont:customFontdt];
            overtimerateTxt.delegate = self;
            overtimerateTxt.textAlignment = UITextAlignmentRight;
            overtimerateTxt.layer.cornerRadius=8.0f;
            overtimerateTxt.layer.masksToBounds=YES;
            overtimerateTxt.tag=500+indexPath.section;
            overtimerateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            overtimerateTxt.layer.borderWidth= 1.0f;
            overtimerateTxt.textColor=[UIColor whiteColor];
            [overtimerateTxt setBackgroundColor:[UIColor clearColor]];
            overtimerateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Over time rate  " attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(overtimerateTxt.bounds.size.width, 0, 5, 20)];
            overtimerateTxt.rightView = paddingView;
            overtimerateTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:overtimerateTxt];
 
        }else if(indexPath.row==16){
            if(normalRateTxt==nil)
                normalRateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
            [normalRateTxt setFont:customFontdt];
            normalRateTxt.delegate = self;
            normalRateTxt.textAlignment = UITextAlignmentRight;
            normalRateTxt.layer.cornerRadius=8.0f;
            normalRateTxt.layer.masksToBounds=YES;
            normalRateTxt.tag=600+indexPath.section;
            normalRateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
            normalRateTxt.layer.borderWidth= 1.0f;
            normalRateTxt.textColor=[UIColor whiteColor];
            [normalRateTxt setBackgroundColor:[UIColor clearColor]];
            [normalRateTxt setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            normalRateTxt.inputAccessoryView = numberToolbar;

            normalRateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Default rate value" attributes:@{NSForegroundColorAttributeName: color}];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(normalRateTxt.bounds.size.width, 0, 5, 20)];
            normalRateTxt.rightView = paddingView;
            normalRateTxt.rightViewMode = UITextFieldViewModeAlways;
            [cellView addSubview:normalRateTxt];
            
        }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:cellView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height;
        return height=screenRect.size.height*0.07+10;
}
-(IBAction)rediolocationBtnAction:(id)sender{
    usesettingStr=[[NSString alloc]init];
    switch ([sender tag]) {
        case 3:
            if([projectlocationBtn isSelected]==YES)
            {
                [projectlocationBtn setSelected:NO];
                usesettingStr=@"Default Setting";
            }
            else{
                [projectlocationBtn setSelected:YES];
                usesettingStr=@"User Setting";
            }
            break;
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
