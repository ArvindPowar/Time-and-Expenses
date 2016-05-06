//
//  InvoiceViewController.h
//  TaskTracker
//
//  Created by arvind on 3/28/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceViewController : UIViewController
@property(nonatomic,readwrite) BOOL isMenuVisible,islistviewVisible;
@property (nonatomic, strong) UIButton *settingBtn,*listofweekBtn;
@property(nonatomic,retain)  UITableView *tableviewExpenses;
@property(nonatomic,retain) NSMutableArray *expensesListArray;
@property(nonatomic,retain) UIView *overlayView,*listView;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton,*numberofwekBtn,*lastwekBtn,*listofwekBtn;
@property(nonatomic,retain)NSArray *arrayData;
@property(nonatomic,retain) UIScrollView *overlyScrollview;


@end
