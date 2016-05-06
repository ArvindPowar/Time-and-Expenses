//
//  ExpensesViewController.h
//  TaskTracker
//
//  Created by arvind on 3/18/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <sqlite3.h>
#import "ExpensesListVO.h"
@interface ExpensesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CustomIOS7AlertViewDelegate,UITextViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *cancelButton,*addButton;
@property (nonatomic, strong) UIButton *takepictureBtn;
@property (nonatomic, strong) UITextField *dateTxt,*expenceTypeTxt,*amountTxt,*commentTxt;
@property (nonatomic, strong) UILabel *dateLbl,*expencesLbl,*amountLbl,*commentLbl;
@property(nonatomic,retain) UIView *overlayView,*imageallView;
@property(nonatomic,retain)NSMutableArray *menuNameArray,*imageArray,*tempimageArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,readwrite) BOOL isMenuVisible,isupdatevalue;
@property (nonatomic, strong) UIButton *settingBtn,*cancelBtn;
@property(nonatomic,retain)  UITableView *tableviewExpenses;
@property(nonatomic,retain) NSMutableArray *expensesListArray,*expenseTypeArray;
@property(nonatomic,retain)UITextView* commentTxtview;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *deleteButton;
@property(nonatomic,retain) UIScrollView *overlyScrollview,*expenseAlertScrollview;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepicker;
@property(nonatomic,retain) IBOutlet UIToolbar *dateToolbar;
@property(nonatomic,retain) CustomIOS7AlertView *imgUloadalertView,*expensAlertView;
@property(nonatomic,retain) UIImageView *receiptPicture;
@property (nonatomic) sqlite3 *ScanDB;
@property(nonatomic,retain)NSString *savedImagePath,*expensesNameStr;
@property(nonatomic,retain) UIAlertView *alertSave;
@property(nonatomic,readwrite) int clientid,projectid,receipid;
@property(nonatomic,retain)ExpensesListVO * ExpvOData;
@end
