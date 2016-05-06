//
//  MainViewController.m
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "LoginViewController.h"
@interface MainViewController ()<SWRevealViewControllerDelegate>

@end

@implementation MainViewController
@synthesize viewController = _viewController;
@synthesize appDelegate,searchString,postupload,categoryString,index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - SWRevealViewDelegate

#define LogDelegates 0
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    if (searchString==nil) {
        searchString=[[NSString alloc]init];
    }
    if (categoryString ==nil) {
        categoryString=[[NSString alloc]init];
    }
    UINavigationController *frontNavigationController;
   /* RearViewController *rearViewController = [[RearViewController alloc] init];
    HomeViewController *mainFeeds=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    mainFeeds.searchString=[[NSString alloc]init];
    mainFeeds.searchString=searchString;
    mainFeeds.categoryStr=[[NSString alloc]init];
    mainFeeds.categoryStr=categoryString;
    
    MerchantListViewController *merchant;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        merchant=[[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController~ipad" bundle:nil];
    }else{
    merchant=[[MerchantListViewController alloc]initWithNibName:@"MerchantListViewController" bundle:nil];
    }
    TourismWebsiteViewController *tour;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    tour=[[TourismWebsiteViewController alloc] initWithNibName:@"TourismWebsiteViewController" bundle:nil];
    }else{
        tour=[[TourismWebsiteViewController alloc] initWithNibName:@"TourismWebsiteViewController~ipad" bundle:nil];
   
    }
    CompanyWebsiteViewController *company;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    company=[[CompanyWebsiteViewController alloc] initWithNibName:@"CompanyWebsiteViewController" bundle:nil];
    }else{
        company=[[CompanyWebsiteViewController alloc] initWithNibName:@"CompanyWebsiteViewController~ipad" bundle:nil];

    }
    LoginViewController *login;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }else{
        login=[[LoginViewController alloc] initWithNibName:@"LoginViewController~ipad" bundle:nil];

    }
    NewFeedViewController *newfeeds;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

   newfeeds =[[NewFeedViewController alloc]initWithNibName:@"NewFeedViewController" bundle:nil];
    }else{
        newfeeds =[[NewFeedViewController alloc]initWithNibName:@"NewFeedViewController" bundle:nil];

    }
    if(appDelegate.index==0)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:mainFeeds];
    else if(appDelegate.index==1)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:tour];
    
    else if(appDelegate.index==2)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:merchant];
    else if(appDelegate.index==3){
        
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:login];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs removeObjectForKey:@"loggedin"];
        [prefs synchronize];
    }else if(appDelegate.index==4){
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:newfeeds];
 
    }
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    self.viewController = revealController;
	
	 [[[UIApplication sharedApplication] delegate] window].rootViewController = self.viewController;*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
