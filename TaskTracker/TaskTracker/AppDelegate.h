//
//  AppDelegate.h
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property(nonatomic,retain)NSMutableArray *allclientArray,*allprojectArray,*expenseListArray;
@property(nonatomic,retain)NSMutableArray *projectpauseArray,*projectbreakArray,*projecttaskArray;
@property(nonatomic,retain) NSString *SettingStr;
@property(nonatomic,retain) NSTimer *timerMotion;
-(void)motionDetectmethod;
-(void)roundupdownAction;
@property(nonatomic,retain) CustomIOS7AlertView *passwordalertView;
@property(nonatomic,retain) UITextField *passwordTxt;
@property(nonatomic,readwrite)  NSNumber * projectTaskid;

@end

