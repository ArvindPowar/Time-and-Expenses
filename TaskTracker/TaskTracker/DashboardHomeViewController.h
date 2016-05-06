//
//  DashboardHomeViewController.h
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownView.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"

@interface DashboardHomeViewController : UIViewController<DropDownViewDelegate,UITableViewDelegate,UITableViewDataSource,CustomIOS7AlertViewDelegate,UITextFieldDelegate>{
    
    UIButton *button;
    
    NSArray *arrayData;
    
    DropDownView *dropDownView;
    
}

@property (nonatomic,retain) IBOutlet UIButton *button;

-(IBAction)actionButtonClick;
@property(nonatomic,retain) UITableView *tblSimpleTable;

@property (nonatomic, strong) UIButton *settingBtn;
@property(nonatomic,retain) UIButton *createclientBtn,*punchinBtn,*punchoutBtn,*selectProjectBtn,*pauseBtn,*breakBtn;
@property(nonatomic,retain) UIView *overlayView,*listView;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,readwrite) BOOL isMenuVisible,islistviewVisible,isPunchOuttime,isPunchintime,istimeover;
@property(nonatomic,retain) UIScrollView *selectProjectscrollview,*overlyScrollview;
@property (nonatomic) sqlite3 *databases;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,retain)  UIAlertView *alert,*alertSave;
@property(nonatomic,retain) UILabel *punchindLbl,*punchoutLbl,*hourTime,*Minslbl,*projectNameLBl;
@property(nonatomic,retain) IBOutlet UIDatePicker *timepicker;
@property(nonatomic,retain) IBOutlet UIToolbar *timeToolbar;
@property(nonatomic,retain) NSTimer *timer,*breaktimer;
@property(nonatomic,retain) CustomIOS7AlertView *TimepickeralertView;
@property(nonatomic,readwrite) long timerseconds,oldtimersecods;
@property(nonatomic,readwrite) double differenceSeconds;
@property(nonatomic,readwrite) int breakmintes,selectprojectID;
@end
