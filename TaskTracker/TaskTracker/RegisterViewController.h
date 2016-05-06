//
//  RegisterViewController.h
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITextField *firatNameText,*lastnameTxt,*emailTxt,*passwordTxt;
@property(nonatomic,retain) IBOutlet UIButton *rigsterBtn,*backBtn;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
