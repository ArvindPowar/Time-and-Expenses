//
//  ProjectListViewController.h
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "TaskListViewController.h"
#import <sqlite3.h>
#import "AppDelegate.h"

@interface ProjectListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CustomIOS7AlertViewDelegate,UITextViewDelegate>
@property(nonatomic,retain)  UITableView *tableviewproject;
@property(nonatomic,retain) NSMutableArray *projectListArray,*tempclientArray;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UIBarButtonItem *deleteButton;
@property (nonatomic, strong) NSMutableArray *dataArray,*clientarray;
@property(nonatomic,retain) CustomIOS7AlertView *alertViewNewPro;
@property (nonatomic, retain) IBOutlet UIView *demoView;
@property (nonatomic, retain) UITextView *addProjectTxt;
@property(nonatomic,retain)  TaskListViewController *taskView;
@property(nonatomic,retain)UIButton *proactiveBtn,*prodeleteBtn,*proreportBtn,*ExpensesBtn;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic) sqlite3 *databases;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,retain) UIScrollView *overlyScrollview;
@property(nonatomic,retain)  UIAlertView *alert;
@property(nonatomic,readwrite) int clientIndexvalue,projectIndexvalue,projectindexsectonvalue;
@end
