//
//  LoginViewController.m
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "LoginViewController.h"
#import "DashboardHomeViewController.h"
#import "ProjectListViewController.h"
#import "CreatePorjectViewController.h"
#import "QuickViewController.h"
#import "PreferencesViewController.h"
#import "ReportInvoiceViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIColor+Expanded.h"
#import "RegisterViewController.h"
#import "Reachability.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userNameText,userPasswordText,rigsterBtn,backBtn,window,activityIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [activityIndicator stopAnimating];

    self.view.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBarHidden=YES;
    

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0,screenRect.size.height / 2.0);
    CGFloat ywidth = screenRect.size.width;
    CGFloat yheightss =screenRect.size.height*0.40;

    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];

    
    UIImageView *LogoImage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20, screenRect.size.height*0.10, screenRect.size.width*0.60, screenRect.size.height*0.30)];
    [LogoImage setImage:[UIImage imageNamed:@"homescreen_logo.PNG"]];
    [self.view addSubview:LogoImage];

    UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.04];

    userNameText=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.42, ywidth, screenRect.size.height*0.06)];
    userPasswordText=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.48, ywidth, screenRect.size.height*0.06)];
    [userNameText setFont:customFontd];
    [userPasswordText setFont:customFontd];
    
    userNameText.delegate = self;
    userNameText.returnKeyType = UIReturnKeyNext;
    userNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userNameText.textAlignment = UITextAlignmentLeft;
    userNameText.textColor=[UIColor whiteColor];
    userNameText.layer.cornerRadius=1.0f;
    userNameText.layer.masksToBounds=YES;
    userNameText.layer.borderColor=[[UIColor whiteColor]CGColor];
    userNameText.layer.borderWidth= 1.2f;
    //[userNameText setBackgroundColor:[UIColor whiteColor]];
    UIColor *color = [UIColor grayColor];
    userNameText.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    //color = [color colorWithAlphaComponent:0.2f];
    userNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Username" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self.view addSubview:userNameText];
    
    userPasswordText.delegate = self;
    userPasswordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Password" attributes:@{NSForegroundColorAttributeName: color}];
    userPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userPasswordText.textAlignment = UITextAlignmentLeft;
    userPasswordText.returnKeyType = UIReturnKeyDone;
    userPasswordText.layer.cornerRadius=1.0f;
    userPasswordText.layer.masksToBounds=YES;
    userPasswordText.layer.borderColor=[[UIColor whiteColor]CGColor];
    userPasswordText.layer.borderWidth= 1.2f;
    userPasswordText.textColor=[UIColor whiteColor];
    userPasswordText.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    //[userPasswordText setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:userPasswordText];
    
    userNameText.text=@"svpokar34@gmail.com";
    userPasswordText.text=@"sandip";

    rigsterBtn=[[UIButton alloc]initWithFrame:CGRectMake(50,screenRect.size.height*0.59,( screenRect.size.width)-100,screenRect.size.height*0.06)];
    [rigsterBtn.titleLabel setFont:customFontd];
    [rigsterBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [rigsterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigsterBtn.layer.cornerRadius = 6.0f;
    [[rigsterBtn layer] setBorderWidth:1.2f];
    [[rigsterBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    rigsterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImage *buttonImage1 = [UIImage imageNamed:@"invoicelistitem.PNG"];
    [rigsterBtn setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [rigsterBtn addTarget:self action:@selector(goToCreatePorjetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigsterBtn];
    
    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(50,screenRect.size.height*0.67, ( screenRect.size.width)-100,screenRect.size.height*0.06)];
    [backBtn.titleLabel setFont:customFontd];
    [backBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 6.0f;
    [[backBtn layer] setBorderWidth:1.2f];
    [[backBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImage *buttonImage = [UIImage imageNamed:@"invoicelistitem.PNG"];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(SignInaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"loggedin"]!=nil){
        DashboardHomeViewController *homview=[[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
        [self.navigationController pushViewController:homview animated:YES];
        
    }

}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}

-(IBAction)SignInaction{
    RegisterViewController *registerview=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerview animated:YES];

}
-(void)viewWillAppear:(BOOL)animated{
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameText) {
        [self.userPasswordText becomeFirstResponder];
    }
    else if (textField == self.userPasswordText) {
        [self.userPasswordText resignFirstResponder];
    }
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goToCreatePorjetAction{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"EZSplit" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        
        if ([userNameText.text isEqualToString:@""] || [userPasswordText.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EZSplit"
                                                            message:@"Please fill in username and password."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            
            NSURL *url;
            NSMutableString *httpBodyString;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"emailid=%@&password=%@",userNameText.text,userPasswordText.text]];
            
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://mobiwebsoft.com/timeandexpense/servicess/loginuser.php?"];
            
            url=[[NSURL alloc] initWithString:urlString];
            NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
            
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
            
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                // your data or an error will be ready here
                if (error)
                {
                    [activityIndicator stopAnimating];
                    NSLog(@"Failed to submit request");
                }
                else
                {
                    [activityIndicator stopAnimating];
                    NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                                  length:[data length] encoding: NSUTF8StringEncoding];
                    
                    NSError *error;
                    if ([content isEqualToString:@"no"]) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"EZSplit" message:@"username and/or Password is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                        
                    }else{
                        
                        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data
                                                                               options:NSJSONReadingMutableContainers
                                                                                 error:&error];
                        NSDictionary *activityArray=[[userDict objectForKey:@"userdetail"] objectForKey:@"user"];
                        
                        
                        NSString *userid = [[NSString alloc]init];
                        NSString *fristname = [[NSString alloc]init];
                        NSString *lastname = [[NSString alloc]init];
                        NSString *email = [[NSString alloc]init];

                        if ([activityArray objectForKey:@"userid"] != [NSNull null])
                            userid=[activityArray objectForKey:@"userid"];
                        fristname=[activityArray objectForKey:@"firstname"];
                        lastname=[activityArray objectForKey:@"lastname"];
                        email=[activityArray objectForKey:@"emailid"];

                        
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        [prefs setObject:userid forKey:@"loggedin"];
                        [prefs setObject:fristname forKey:@"firstname"];
                        [prefs setObject:lastname forKey:@"lastname"];
                        [prefs setObject:email forKey:@"email"];
                        [prefs setObject:userPasswordText.text forKey:@"applockpassword"];

                        [prefs synchronize];
                        
                        DashboardHomeViewController *homview=[[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
                        [self.navigationController pushViewController:homview animated:YES];
                    }
                    
                }
            }];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
