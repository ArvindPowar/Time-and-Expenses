//
//  NewTaskViewController.h
//  TaskTracker
//
//  Created by arvind on 3/14/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *demoTitle;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSwitch;
@property (strong, nonatomic) NSArray *viewControllers;

@end
