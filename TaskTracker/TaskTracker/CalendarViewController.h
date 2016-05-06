//
//  CalendarViewController.h
//  TaskTracker
//
//  Created by arvind on 3/18/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController<VRGCalendarViewDelegate>
@property(nonatomic,retain)NSMutableArray *calendardateArrat;
@property (nonatomic, strong) UIBarButtonItem *backButton;

@end
