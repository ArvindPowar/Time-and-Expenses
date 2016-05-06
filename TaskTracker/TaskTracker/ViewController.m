//
//  ViewController.m
//  TaskTracker
//
//  Created by arvind on 3/12/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UIColor+Expanded.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize signBtn,loginBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self.view setBackgroundColor:[UIColor clearColor]];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    [self.view addSubview:bgImage];

    
    loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(60,screenRect.size.height*0.45, screenRect.size.width-120,40)];
    [loginBtn.titleLabel setFont:[UIFont fontWithName:@"dinneuzeitgrotesk-light" size:20]];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0f;
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    signBtn=[[UIButton alloc]initWithFrame:CGRectMake(60,screenRect.size.height*0.55, screenRect.size.width-120,40)];
    [signBtn.titleLabel setFont:[UIFont fontWithName:@"dinneuzeitgrotesk-light" size:20]];
    [signBtn setTitle:@"Sign up" forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signBtn.layer.cornerRadius = 6.0f;
    signBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [signBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
    [signBtn addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signBtn];


}

-(IBAction)loginAction{
    LoginViewController *loginview=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginview animated:YES];

}
-(IBAction)signAction{
    RegisterViewController *signview=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:signview animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
