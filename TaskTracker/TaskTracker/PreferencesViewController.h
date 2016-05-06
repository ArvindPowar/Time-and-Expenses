//
//  PreferencesViewController.h
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"

@interface PreferencesViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CustomIOS7AlertViewDelegate>
@property(nonatomic,retain) UILabel *clientproLbl,*emailreportLbl,*emailinvoiceLbl,*lockappLbl,*locatonLbl,*starttimerLbl;
@property(nonatomic,retain) UITextField *emailreportTXT,*emailinvoiceTXT;
@property(nonatomic,retain) UIButton *allclientproBtn,*lockBtn,*geofencingBtn,*starttimerBtn;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property (nonatomic, strong) UIButton *settingBtn;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,retain)NSMutableArray *menuNameArray,*defaultreportformatArray;
@property(nonatomic,retain) UIButton *menuNameButton,*alertnameBtn;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain) UIScrollView *overlyScrollview;
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *preferencesListArray;
@property(nonatomic,retain)  UIAlertView *alert;
@property (nonatomic, retain)  UISwitch *lockapponoffSwitch;
@property(nonatomic,retain) CustomIOS7AlertView *defaultreportformatAV;
@end
