//
//  SettingViewController.h
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CustomIOS7AlertViewDelegate>
@property(nonatomic,retain) UIButton *reportinvoiceBtn,*dataimportBtn,*supportcomtyBtn,*facebookBtn,*websiteBtn,*emailBtn,*alldataclientproBtn;
@property (nonatomic, strong) UIButton *settingBtn;
@property(nonatomic,readwrite) BOOL isMenuVisible,isstartweekday,isroundupdown,isdateformat;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,retain)NSMutableArray *menuNameArray,*dayofWeeksArray;
@property(nonatomic,retain) UIButton *menuNameButton,*numberofwekBtn,*lastwekBtn,*listofwekBtn,*alertnameBtn;
@property(nonatomic,retain)  UITableView *tableviewSetting;
@property(nonatomic,retain) NSMutableArray *expensesListSetting;
@property(nonatomic,retain) UIScrollView *overlyScrollview,*alertscrollview;
@property(nonatomic,retain) CustomIOS7AlertView *daysofWeekaralertView,*roundupdownAlertview;
@property(nonatomic,retain)  UIAlertView *alert;

@end
