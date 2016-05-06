//
//  TaskListViewController.h
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <sqlite3.h>
#import "AppDelegate.h"


@interface TaskListViewController : UIViewController<UITextFieldDelegate,CustomIOS7AlertViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>{
}
@property (strong, nonatomic) NSMutableArray *countryArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopLayoutConstraint;

@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;

@property (nonatomic, strong) UIBarButtonItem *deleteButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,retain) CustomIOS7AlertView *alertViewNewPro,*countryAlertView;
@property (nonatomic, retain) IBOutlet UIView *demoView;
@property (nonatomic, retain) UITextView *addProjectTxt;
@property (nonatomic, retain) UILabel *selectclientLbl,*projectlocatioLbl,*settingLbl,*clientSettingLbl,*ratehourlyLbl,*taxLbl,*overtimeHourLbl,*overtimerateLbl,*dailyhoursLbl,*weeklyLbl,*vatLbl;
@property (nonatomic, retain) UITextField *clientTxt,*projectLocationTxt,*ratehourlyTxt,*taxTxt,*overtimehourTxt,*overtimerateTxt,*vatTxt,*projectnameTxt,*cityTxt,*StateTxt,*ZipTxt,*countryTxt,*calculateOverTimeTxt,*alertviewTxt,*normalRateTxt;

@property(nonatomic,retain)UIButton *weeklycalBtn,*dailycalBtn,*ownsettingBtn,*clientsettingBtn,*projectlocationBtn;
@property (nonatomic) sqlite3 *ScanDB;
@property(nonatomic,retain)NSString *usesettingStr,*calculateovertimeStr,*clientNameselected;
@property(nonatomic,retain)NSMutableArray *mainNameArray;
@property(nonatomic,retain) IBOutlet UITableView *tableview;
@property(nonatomic,retain) UIPickerView *overtimepicker,*clientPickerview,*ratePickerview,*calculateOvertimePickerview;
@property(nonatomic,retain)  UIToolbar *overtimeratetoolbar,*clientToolbar,*rateToolbar,*caloverToolbar;
@property(nonatomic,retain)NSMutableArray *overtimerateArray,*rateArray,*calovertimeArray;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView,*countryscrollview;
@property(nonatomic,retain)  UIAlertView *alert;
@property(nonatomic,retain)IBOutlet UIImageView *bgImage;
@property(nonatomic,readwrite) int clientID;
@property(nonatomic,retain)NSString * overtimeRateStr,*clientrateStr,*clienttaxStr,*clientvatStr,*clientcaloverTimeStr,*clienttimehourStr,*clientovertimeRateStr,*defaultratevalue;
@property(nonatomic,retain) CustomIOS7AlertView *overtimealertView;

@end
