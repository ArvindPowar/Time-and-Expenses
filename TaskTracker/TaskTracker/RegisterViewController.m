//
//  RegisterViewController.m
//  TaskTracker
//
//  Created by arvind on 3/15/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "RegisterViewController.h"
#import "DashboardHomeViewController.h"
#import "ProjectListViewController.h"
#import "CreatePorjectViewController.h"
#import "QuickViewController.h"
#import "PreferencesViewController.h"
#import "ReportInvoiceViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIColor+Expanded.h"
#import "Reachability.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize firatNameText,lastnameTxt,emailTxt,passwordTxt,rigsterBtn,backBtn,window,activityIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBarHidden=YES;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat ywidth = screenRect.size.width;
    [activityIndicator stopAnimating];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0,screenRect.size.height / 2.0);

    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];
    
    UIImageView *LogoImage=[[UIImageView alloc]initWithFrame:CGRectMake(70, screenRect.size.height*0.10, screenRect.size.width-140, screenRect.size.height*0.30)];
    [LogoImage setImage:[UIImage imageNamed:@"homescreen_logo.PNG"]];
    [self.view addSubview:LogoImage];
    UIFont *customFontd = [UIFont fontWithName:@"brandongrotesque-regular" size:screenRect.size.width*0.04];


    firatNameText=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.40, ywidth, screenRect.size.height*0.06)];
    lastnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.46, ywidth, screenRect.size.height*0.06)];
    [firatNameText setFont:customFontd];
    [lastnameTxt setFont:customFontd];
    
    firatNameText.delegate = self;
    firatNameText.returnKeyType = UIReturnKeyNext;
    firatNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    firatNameText.textAlignment = UITextAlignmentLeft;
    firatNameText.textColor=[UIColor whiteColor];
    firatNameText.layer.cornerRadius=1.0f;
    firatNameText.layer.masksToBounds=YES;
    firatNameText.layer.borderColor=[[UIColor whiteColor]CGColor];
    firatNameText.layer.borderWidth= 1.2f;
    firatNameText.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    UIColor *color = [UIColor grayColor];
    firatNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  First Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self.view addSubview:firatNameText];
    
    lastnameTxt.delegate = self;
    lastnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    lastnameTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lastnameTxt.textAlignment = UITextAlignmentLeft;
    lastnameTxt.returnKeyType = UIReturnKeyNext;
    lastnameTxt.layer.cornerRadius=1.0f;
    lastnameTxt.layer.masksToBounds=YES;
    lastnameTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    lastnameTxt.layer.borderWidth= 1.2f;
    lastnameTxt.textColor=[UIColor whiteColor];
    lastnameTxt.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    [self.view addSubview:lastnameTxt];
    
    emailTxt=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.513, ywidth,  screenRect.size.height*0.06)];
    [emailTxt setFont:customFontd];
    emailTxt.delegate = self;
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Email" attributes:@{NSForegroundColorAttributeName: color}];
    emailTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailTxt.textAlignment = UITextAlignmentLeft;
    emailTxt.returnKeyType = UIReturnKeyNext;
    emailTxt.layer.cornerRadius=1.0f;
    emailTxt.layer.masksToBounds=YES;
    emailTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    emailTxt.layer.borderWidth= 1.2f;
    [emailTxt setKeyboardType:UIKeyboardTypeEmailAddress];
    emailTxt.textColor=[UIColor whiteColor];
    emailTxt.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    [self.view addSubview:emailTxt];

    passwordTxt=[[UITextField alloc]initWithFrame:CGRectMake(0, screenRect.size.height*0.568, ywidth,  screenRect.size.height*0.06)];
    [passwordTxt setFont:customFontd];
    passwordTxt.delegate = self;
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Password" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTxt.textAlignment = UITextAlignmentLeft;
    passwordTxt.returnKeyType = UIReturnKeyDone;
    passwordTxt.layer.cornerRadius=1.0f;
    passwordTxt.layer.masksToBounds=YES;
    passwordTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordTxt.layer.borderWidth= 1.2f;
    passwordTxt.textColor=[UIColor whiteColor];
    passwordTxt.background=[UIImage imageNamed:@"invoicelistitem.PNG"];
    [self.view addSubview:passwordTxt];

    
    rigsterBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.18,screenRect.size.height*0.67, screenRect.size.width*0.66,screenRect.size.height*0.06)];
    [rigsterBtn.titleLabel setFont:customFontd];
    [rigsterBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [rigsterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigsterBtn.layer.cornerRadius = 6.0f;
    [[rigsterBtn layer] setBorderWidth:1.2f];
    [[rigsterBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    rigsterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImage *buttonImage1 = [UIImage imageNamed:@"invoicelistitem.PNG"];
    [rigsterBtn setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [rigsterBtn addTarget:self action:@selector(goToCreatePorjetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigsterBtn];
    
    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.18,screenRect.size.height*0.74, screenRect.size.width*0.66,screenRect.size.height*0.06)];
    [backBtn.titleLabel setFont:customFontd];
    [backBtn setTitle:@"CANCEL" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 6.0f;
    [[backBtn layer] setBorderWidth:1.2f];
    [[backBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backBtn setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backaction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)goToCreatePorjetAction{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"EZSplit" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        
        if ([firatNameText.text isEqualToString:@""] || [lastnameTxt.text isEqualToString:@""]|| [passwordTxt.text isEqualToString:@""] ){
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
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"firstname=%@&lastname=%@&emailid=%@&password=%@",firatNameText.text,lastnameTxt.text,emailTxt.text,passwordTxt.text]];
            
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://mobiwebsoft.com/timeandexpense/servicess/registerUserDetails.php?"];
            
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
                        
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        [prefs setObject:content forKey:@"loggedin"];
                        [prefs setObject:firatNameText.text forKey:@"firstname"];
                        [prefs setObject:lastnameTxt.text forKey:@"lastname"];
                        [prefs setObject:emailTxt.text forKey:@"email"];
                        [prefs setObject:passwordTxt.text forKey:@"applockpassword"];
                        [prefs synchronize];
                        
                        DashboardHomeViewController *homview=[[DashboardHomeViewController alloc] initWithNibName:@"DashboardHomeViewController" bundle:nil];
                        [self.navigationController pushViewController:homview animated:YES];
                    }
                    
                }
            }];
        }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    if (textField==emailTxt) {
        [self animateTextField:textField up:YES];
    }
    if (textField==passwordTxt) {
        [self animateTextField:textField up:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.firatNameText) {
        [self.lastnameTxt becomeFirstResponder];
    }
    else if (textField == self.lastnameTxt) {
        [self.emailTxt becomeFirstResponder];

    }else if (textField == self.emailTxt) {
        [self.passwordTxt becomeFirstResponder];
    }else if (textField == self.passwordTxt) {
        [self.passwordTxt resignFirstResponder];
        
    }
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==emailTxt) {
        [self animateTextField:textField up:NO];
    }
    if (textField==passwordTxt) {
        [self animateTextField:textField up:NO];
    }
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
