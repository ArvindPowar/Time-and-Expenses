//
//  NewTaskViewController.m
//  TaskTracker
//
//  Created by arvind on 3/14/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "NewTaskViewController.h"
#import "UIColor+Expanded.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController


- (void)viewWillAppear:(BOOL)animated
{
    [self.view setAlpha:0];
    [UIView animateWithDuration:0.2
                          delay:0.25
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         [self.view setAlpha:1.0];
                     }completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self setSimulateLatency:YES]; //Uncomment to delay the return of autocomplete suggestions.
    //[self setTestWithAutoCompleteObjectsInsteadOfStrings:YES]; //Uncomment to return autocomplete objects instead of strings to the textfield.
    
    //[self.autocompleteDataSource setSimulateLatency:YES];
    //[self.autocompleteDataSource setTestWithAutoCompleteObjectsInsteadOfStrings:YES];
    
    /*
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowWithNotification:) name:UIKeyboardDidShowNotification object:nil];
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideWithNotification:) name:UIKeyboardDidHideNotification object:nil];
     */
}



/*
 - (void)keyboardDidShowWithNotification:(NSNotification *)aNotification
 {
 [UIView animateWithDuration:0.3
 delay:0
 options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
 animations:^{
 CGPoint adjust;
 switch (self.interfaceOrientation) {
 case UIInterfaceOrientationLandscapeLeft:
 adjust = CGPointMake(-110, 0);
 break;
 case UIInterfaceOrientationLandscapeRight:
 adjust = CGPointMake(110, 0);
 break;
 default:
 adjust = CGPointMake(0, -60);
 break;
 }
 CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
 [self.view setCenter:newCenter];
 [self.author setAlpha:0];
 [self.demoTitle setAlpha:0];
 [self.typeSwitch setAlpha:0];
 
 }
 completion:nil];
 }
 
 
 - (void)keyboardDidHideWithNotification:(NSNotification *)aNotification
 {
 [UIView animateWithDuration:0.3
 delay:0
 options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
 animations:^{
 CGPoint adjust;
 switch (self.interfaceOrientation) {
 case UIInterfaceOrientationLandscapeLeft:
 adjust = CGPointMake(110, 0);
 break;
 case UIInterfaceOrientationLandscapeRight:
 adjust = CGPointMake(-110, 0);
 break;
 default:
 adjust = CGPointMake(0, 60);
 break;
 }
 CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
 [self.view setCenter:newCenter];
 [self.author setAlpha:1];
 [self.demoTitle setAlpha:1];
 [self.typeSwitch setAlpha:1];
 }
 completion:nil];
 
 
 [self.autocompleteTextField setAutoCompleteTableViewHidden:NO];
 }
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
