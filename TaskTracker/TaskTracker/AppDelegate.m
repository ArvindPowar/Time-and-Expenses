//
//  AppDelegate.m
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "DashboardHomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navController,timerMotion,passwordalertView,passwordTxt;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    DashboardHomeViewController *viewController;
    
    viewController = [[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"loggedin"]!=nil){

        if([prefs stringForKey:@"applockpassword"]!=nil){
        int timevalue=[[prefs stringForKey:@"applocktime"] intValue];
        timerMotion = [NSTimer scheduledTimerWithTimeInterval: timevalue target:self selector:@selector(locktheapp) userInfo:nil repeats: YES];
    }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[self   motionDetectmethod];
    [timerMotion invalidate];
    timerMotion=nil;

}

-(void)motionDetectmethod{
    [timerMotion invalidate];
    timerMotion=nil;
    timerMotion = [NSTimer scheduledTimerWithTimeInterval: 10.0 target:self selector:@selector(locktheapp) userInfo:nil repeats: YES];

}
- (void)roundupdownAction
{
    // Here we need to pass a full frame
    passwordalertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [passwordalertView setContainerView:[self roundupdownAlert]];
    // Modify the parameters
    [passwordalertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [passwordalertView setUseMotionEffects:true];
    // And launch the dialog
    [passwordalertView show];
}
-(UIView *)roundupdownAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,150)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Time & Expense" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    
    passwordTxt=[[UITextField alloc]initWithFrame:CGRectMake(2,50,296,48)];
    [passwordTxt setFont:[UIFont boldSystemFontOfSize:15]];
    passwordTxt.delegate = self;
    passwordTxt.textAlignment = UITextAlignmentCenter;
    passwordTxt.textColor=[UIColor whiteColor];
    passwordTxt.layer.cornerRadius=8.0f;
    passwordTxt.layer.masksToBounds=YES;
    passwordTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordTxt.layer.borderWidth= 1.0f;
    [passwordTxt setBackgroundColor:[UIColor clearColor]];
        passwordTxt.placeholder=@"Enter your password";
    [demoView addSubview:passwordTxt];

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,100,300,50)];
    [cancelBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(submitAction)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
    
}

-(void)submitAction{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([passwordTxt.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please enter password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];

    }else{
        
        if([[prefs stringForKey:@"applockpassword"] isEqualToString:passwordTxt.text]){
            [passwordalertView close];
            [prefs setObject:@"Success" forKey:@"applockon"];
            [prefs synchronize];

        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please enter correct password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
 
        }

    }
}

-(void)doneWithNumberPad{
    [passwordTxt resignFirstResponder];
}
-(void)locktheapp{
    [timerMotion invalidate];
    timerMotion=nil;
    NSLog(@"Lock the app");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"nopassword" forKey:@"applockon"];
    [prefs synchronize];

    [self roundupdownAction];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
