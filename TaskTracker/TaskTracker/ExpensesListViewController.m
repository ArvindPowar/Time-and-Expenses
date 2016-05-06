//
//  ExpensesListViewController.m
//  TaskTracker
//
//  Created by arvind on 4/23/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ExpensesListViewController.h"
#import "ExpensesListVO.h"
#import "ExpensesViewController.h"
#import "ProjectListViewController.h"
@interface ExpensesListViewController ()

@end

@implementation ExpensesListViewController
@synthesize tableview,backButton,addButton,databases,appDelegate,projectid,clientid,alert,indexvalue;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    appDelegate=[[UIApplication sharedApplication] delegate];
    databases=[self getNewDb];
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
    
    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(NewExpensesAction)];
    self.backButton.tintColor = [UIColor whiteColor];
    self.addButton.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:self.backButton];
    [self.navigationItem setRightBarButtonItem:self.addButton];
    
    
    
    UILabel *dashboardLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15,screenRect.size.width,35)];
    dashboardLbl.text = @"Expenses List";
    dashboardLbl.textColor=[UIColor whiteColor];
    UIFont *customFontds = [UIFont fontWithName:@"BrandonText-Light" size:screenRect.size.width*0.04];
    dashboardLbl.font = customFontds;
    dashboardLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dashboardLbl];
    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.25,screenRect.size.width,screenRect.size.height*0.75)];
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.view addSubview:tableview];
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.allowsMultipleSelectionDuringEditing = YES;
}
-(IBAction)backAction{
    ProjectListViewController *project=[[ProjectListViewController alloc] initWithNibName:@"ProjectListViewController" bundle:nil];
    [self.navigationController pushViewController:project animated:YES];
}

-(void)NewExpensesAction{
    ExpensesViewController *expenses=[[ExpensesViewController alloc] initWithNibName:@"ExpensesViewController" bundle:nil];
    expenses.clientid=clientid;
    expenses.projectid=projectid;
    expenses.isupdatevalue=false;
    [self.navigationController pushViewController:expenses animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)viewDidAppear:(BOOL)animated{
    [self getExpensesList];
}
-(void)getExpensesList{
    char *dbChars ;
    appDelegate.expenseListArray =[[NSMutableArray alloc] init];
    NSString *sqlStatement = [NSString stringWithFormat:@"select * from ReportExpensesTable where project_id=%d",projectid];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(databases, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            ExpensesListVO *expensesVo=[[ExpensesListVO alloc] init];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 0);
            if(dbChars!=nil)
                expensesVo.repostexpidStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 1);
            if(dbChars!=nil)
                expensesVo.clientidStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];

            dbChars = (char *)sqlite3_column_text(compiledStatement, 2);
            if(dbChars!=nil)
                expensesVo.projectidStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 3);
            if(dbChars!=nil)
                expensesVo.useridStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 4);
            if(dbChars!=nil)
                expensesVo.expenses_dateStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
            
            dbChars = (char *)sqlite3_column_text(compiledStatement, 5);
            if(dbChars!=nil)
                expensesVo.expenses_typeStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 6);
            if(dbChars!=nil)
                expensesVo.expenses_amountStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 7);
            if(dbChars!=nil)
                expensesVo.expenses_commentStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 8);
            if(dbChars!=nil)
                expensesVo.expenses_receiptImgStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
            dbChars = (char *)sqlite3_column_text(compiledStatement, 9);
            if(dbChars!=nil)
                expensesVo.Expenses_NameStr=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
            [appDelegate.expenseListArray addObject:expensesVo];
        }
    }
    [tableview reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegate.expenseListArray.count;
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
    
    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(5,0,300,45)];
    ExpensesListVO *expVo=[appDelegate.expenseListArray objectAtIndex:indexPath.row];
    [fieldLBls setText:expVo.Expenses_NameStr];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    fieldLBls.textColor=[UIColor whiteColor];
    UIFont *customFontdt = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.03];
    [fieldLBls setFont:customFontdt];
    [cellView addSubview:fieldLBls];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:cellView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.07+10;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpensesViewController *expenses=[[ExpensesViewController alloc] initWithNibName:@"ExpensesViewController" bundle:nil];
    ExpensesListVO *expVo=[appDelegate.expenseListArray objectAtIndex:indexPath.row];
    expenses.ExpvOData=[[ExpensesListVO alloc]init];
    expenses.ExpvOData=expVo;
    expenses.isupdatevalue=true;
    [self.navigationController pushViewController:expenses animated:YES];
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"indexPath.row %d",indexPath.row);
                                        indexvalue=indexPath.row;
                                        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"are you sure you want to delete" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                                        [alert show];                                        }];
    button.backgroundColor = [UIColor redColor]; //arbitrary color
    
    return @[button];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alert buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        [self deleteRecord];
    }
    [alert dismissWithClickedButtonIndex:1 animated:YES];
    
}
-(void)deleteRecord{
    ExpensesListVO * expVO=[[ExpensesListVO alloc]init];
    expVO=[appDelegate.expenseListArray objectAtIndex:indexvalue];
    sqlite3_stmt *statement;
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat:
                 @"DELETE FROM ReportExpensesTable WHERE reportExp_id='%@'",expVO.repostexpidStr];
    
    NSLog(@"Delete = %@",insertSQL);
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(databases, insert_stmt,
                       -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"event detail contestant position delete");
        [self getExpensesList];
    }else{
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(databases));
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
