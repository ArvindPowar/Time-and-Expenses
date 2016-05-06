//
//  DefaultRateSettingViewController.h
//  TaskTracker
//
//  Created by arvind on 4/7/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "AppDelegate.h"

@interface DefaultRateSettingViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CustomIOS7AlertViewDelegate>
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *defaultListSetting;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UITextField *settingtypeTxt,*rateTypeTxt,*taxTxt,*vatTxt,*calculateOvertimeTxt,*overtimeTxt,*overtimeRateTxt,*alertviewTxt,*normalRateTxt;

@property(nonatomic,retain) UIPickerView *overtimepicker,*ratePickerview,*calculateOvertimePickerview,*settingtypepickerview;
@property(nonatomic,retain)  UIToolbar *overtimeratetoolbar,*rateToolbar,*caloverToolbar,*settingtypetoolbar;
@property(nonatomic,retain)NSMutableArray *overtimerateArray,*rateArray,*calovertimeArray,*settingtypeArray;
@property(nonatomic,retain) CustomIOS7AlertView *overtimealertView;
@property(nonatomic,retain)NSString * overtimeRateStr;
@property(nonatomic,retain)  UIAlertView *alert;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UIImageView *bgImage;

@end
