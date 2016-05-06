//
//  LoginViewController.h
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UITextField *userNameText;
@property(nonatomic,retain) IBOutlet UITextField *userPasswordText;
@property(nonatomic,retain) IBOutlet UIButton *rigsterBtn,*backBtn;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
