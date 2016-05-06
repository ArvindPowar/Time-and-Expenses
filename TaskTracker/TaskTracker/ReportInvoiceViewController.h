//
//  ReportInvoiceViewController.h
//  TaskTracker
//
//  Created by arvind on 3/16/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"
#import "PMCalendar.h"
#import <sqlite3.h>


@interface ReportInvoiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CustomIOS7AlertViewDelegate,PMCalendarControllerDelegate>
@property(nonatomic,retain) UIButton *allprojectBtn,*selectprojectBtn,*dateBtn,*lastweekBtn,*lastmonthBtn,*lastyearBtn,*viewscreenBtn,*invocieSpedateBtn,*invoiceLastweekBtn,*invoicelastmonthBtn,*emailpdfBtn;
@property(nonatomic,readwrite) BOOL isMenuVisible,islistviewVisible,isselectprojetvisible;
@property (nonatomic, strong) UIButton *settingBtn,*lastweekBtns;
@property(nonatomic,retain) UIView *overlayView,*repostListview,*projectListview;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton,*numberofwekBtn,*lastwekBtn,*listofwekBtn,*selectproBtn;
@property(nonatomic,retain)NSArray *reportarrayData,*porjectListArray;
@property(nonatomic,retain) UIScrollView *selectProjectscrollview;
@property(nonatomic,retain) UIScrollView *overlyScrollview;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,retain) CustomIOS7AlertView *displayreportalertView;
- (IBAction)showCalendar:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel *periodLabel;
@property(nonatomic,retain) IBOutlet UITableView *tableview;
@property(nonatomic,readwrite) int selectprojectID,pasueTime,breakTime;
@property (nonatomic) sqlite3 *databases;
@property(nonatomic,retain) NSString *ratehourly_daily_project,*project_tax,*project_vat,*projectovertimehour,*projectovertimerate,*projectdaily_weekly,*defaultratevalue;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;

@end

