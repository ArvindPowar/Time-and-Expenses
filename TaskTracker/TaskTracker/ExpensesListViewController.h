//
//  ExpensesListViewController.h
//  TaskTracker
//
//  Created by arvind on 4/23/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
@interface ExpensesListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) IBOutlet UITableView *tableview;
@property (nonatomic, strong) UIBarButtonItem *backButton,*addButton;
@property (nonatomic) sqlite3 *databases;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,readwrite) int clientid,projectid,indexvalue;
@property(nonatomic,retain)  UIAlertView *alert;

@end
