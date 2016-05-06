//
//  CreatePorjectViewController.h
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"

@interface CreatePorjectViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CustomIOS7AlertViewDelegate>
@property(nonatomic,retain) IBOutlet UITextField *projectNameText;
@property(nonatomic,retain) IBOutlet UITextField *clienNameText,*startText;
@property(nonatomic,retain) IBOutlet UIButton *createProBtn,*weeklycalBtn,*dailycalBtn,*settingBtn;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property(nonatomic,retain) UILabel *clientnameLbl,*clientaddressLbl,*settingLbl,*rateHourlyLbl,*taxLbl,*vatLbl,*overtimehoursLbl,*overtimerateLbl,*dilyhourLbl,*weeklyLbl;
@property(nonatomic,retain) IBOutlet UITextField *clientnameTxt,*clientaddressTxt,*rateHourlyTxt,*taxTxt,*vatTxt,*overtimehoursTxt,*overtimerateTxt,*cityTxt,*StateTxt,*ZipTxt,*countryTxt,*calculateOverTimeTxt,*alertviewTxt,*normalRateTxt;
@property (nonatomic) sqlite3 *ScanDB;
@property(nonatomic,retain)NSString *usesettingStr,*calculateovertimeStr;
@property(nonatomic,retain)NSMutableArray *mainNameArray;
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) UIPickerView *overtimepicker,*ratePickerview,*calculateOvertimePickerview;
@property(nonatomic,retain)  UIToolbar *overtimeratetoolbar,*rateToolbar,*caloverToolbar;
@property(nonatomic,retain)NSMutableArray *overtimerateArray,*rateArray,*calovertimeArray,*valuesArray;
@property(nonatomic,retain)  UIAlertView *alert;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView,*countryscrollview;
@property(nonatomic,retain)IBOutlet UIImageView *bgImage;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)NSString * overtimeRateStr;
@property(nonatomic,retain) CustomIOS7AlertView *overtimealertView,*countryAlertView;
@property (strong, nonatomic) NSMutableArray *countryArray;


@end
