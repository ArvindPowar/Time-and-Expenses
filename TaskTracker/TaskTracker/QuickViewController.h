//
//  QuickViewController.h
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)  UITableView *tableviewquickview;
@property(nonatomic,retain) NSMutableArray *quickArray1,*quickArray2,*quickArray3;
@property(nonatomic,retain) UISegmentedControl *mainSegment;
@property (nonatomic, strong) UIBarButtonItem *reportBtn;

@end
