//
//  DefaultRateSettingViewController.m
//  TaskTracker
//
//  Created by arvind on 4/7/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "DefaultRateSettingViewController.h"
#include <math.h>
@interface DefaultRateSettingViewController ()

@end

@implementation DefaultRateSettingViewController
@synthesize tableview,defaultListSetting,editButton,cancelButton,addButton,rateTypeTxt,taxTxt,vatTxt,calculateOvertimeTxt,overtimeTxt,overtimeRateTxt,ratePickerview,calculateOvertimePickerview,overtimeratetoolbar,rateToolbar,caloverToolbar,overtimerateArray,rateArray,calovertimeArray,overtimepicker,settingtypeTxt,settingtypepickerview,settingtypetoolbar,settingtypeArray,overtimealertView,alertviewTxt,overtimeRateStr,alert,appDelegate,scrollView,bgImage,normalRateTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [bgImage setImage:[UIImage imageNamed:@"background.PNG"]];
    //[self.view addSubview:bgImage];
    appDelegate=[[UIApplication sharedApplication] delegate];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Default rate settings"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font =[UIFont fontWithName:@"BrandonText-Bold" size:22];
    self.navigationItem.titleView = titleLabel;
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAction)];
    self.editButton.tintColor = [UIColor whiteColor];
    self.addButton.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:self.editButton];
    [self.navigationItem setRightBarButtonItem:self.addButton];
    
    overtimerateArray=[[NSMutableArray alloc]initWithObjects:@"1.5 X",@"2.5 X",@"3.5 X",@"4.5 X",@"5.5 X",@"Custom X",@"%", nil];
    rateArray=[[NSMutableArray alloc]initWithObjects:@"Hourly Rate",@"Daily Rate",@"Project", nil];
    calovertimeArray=[[NSMutableArray alloc]initWithObjects:@"Daily",@"Weekly", nil];

    defaultListSetting=[[NSMutableArray alloc]initWithObjects:@"Rate Type",@"Tax Rate",@"Vat",@"Calculate Overtime ",@"Over time",@"Overtime rate",@"Default Rate Value", nil];
    settingtypeArray=[[NSMutableArray alloc]initWithObjects:@"Projet Setting",@"Client Setting", nil];
    scrollView.contentSize = CGSizeMake(screenRect.size.width,screenRect.size.height+230);
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height+300)];
    self.tableview.separatorColor = [UIColor clearColor];
    [tableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    [self.scrollView addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.scrollEnabled = NO;
}

-(void)viewDidAppear:(BOOL)animated{
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveAction{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:@"Setting" forKey:@"ClientSetting"];

        [prefs setObject:rateTypeTxt.text forKey:@"ProjectRateType"];
        [prefs setObject:taxTxt.text forKey:@"ProjectTax"];
        [prefs setObject:vatTxt.text forKey:@"ProjectVat"];
        [prefs setObject:calculateOvertimeTxt.text forKey:@"ProjectCalOverTime"];
        [prefs setObject:overtimeTxt.text forKey:@"ProjectOverTime"];
        [prefs setObject:overtimeRateTxt.text forKey:@"ProjectOverTimeRate"];
        [prefs setObject:normalRateTxt.text forKey:@"defaultratevalue"];

        [prefs synchronize];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time & Expenses"
                                                    message:@"Save successfully."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}
-(void)doneWithNumberPad{
    [normalRateTxt resignFirstResponder];
    [vatTxt resignFirstResponder];
    [taxTxt resignFirstResponder];
    [alertviewTxt resignFirstResponder];
    [overtimeTxt resignFirstResponder];
    settingtypepickerview.hidden=YES;
    settingtypetoolbar.hidden=YES;
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
    

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [vatTxt resignFirstResponder];
    [taxTxt resignFirstResponder];
    [overtimeTxt resignFirstResponder];
    if(textField==settingtypeTxt)
    {
        [settingtypeTxt setText:[NSString stringWithFormat:@"%@",[settingtypeArray objectAtIndex:0]]];

        settingtypepickerview.hidden=YES;
        settingtypetoolbar.hidden=YES;
        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        
        settingtypepickerview = [[UIPickerView alloc] init];
        [settingtypepickerview setDataSource: self];
        [settingtypepickerview setDelegate: self];
        settingtypepickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [settingtypepickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,210)];
        settingtypepickerview.showsSelectionIndicator = YES;
        [settingtypepickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: settingtypepickerview];
        settingtypepickerview.hidden=NO;
        settingtypetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [settingtypetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        settingtypetoolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:settingtypetoolbar];
        
        settingtypetoolbar.hidden=NO;
        [settingtypeTxt resignFirstResponder];
        
        return NO;
    }else if(textField==overtimeRateTxt)
    {
        [overtimeRateTxt setText:[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:0]]];

        settingtypepickerview.hidden=YES;
        settingtypetoolbar.hidden=YES;
        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        overtimepicker = [[UIPickerView alloc] init];
        [overtimepicker setDataSource: self];
        [overtimepicker setDelegate: self];
        overtimepicker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [overtimepicker setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        overtimepicker.showsSelectionIndicator = YES;
        [overtimepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: overtimepicker];
        overtimepicker.hidden=NO;
        overtimeratetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [overtimeratetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(dialogAction)];
        overtimeratetoolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:overtimeratetoolbar];
        
        overtimeratetoolbar.hidden=NO;
        [overtimeRateTxt resignFirstResponder];
        
        return NO;
    }else
        if(textField==rateTypeTxt)
    {
        [rateTypeTxt setText:[NSString stringWithFormat:@"%@",[rateArray objectAtIndex:0]]];

        settingtypepickerview.hidden=YES;
        settingtypetoolbar.hidden=YES;
        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        
        ratePickerview = [[UIPickerView alloc] init];
        [ratePickerview setDataSource: self];
        [ratePickerview setDelegate: self];
        ratePickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [ratePickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        ratePickerview.showsSelectionIndicator = YES;
        [ratePickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: ratePickerview];
        ratePickerview.hidden=NO;
        rateToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [rateToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        rateToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:rateToolbar];
        
        rateToolbar.hidden=NO;
        [rateTypeTxt resignFirstResponder];
        
        return NO;
    }else if(textField==calculateOvertimeTxt)
    {
        [calculateOvertimeTxt setText:[NSString stringWithFormat:@"%@",[calovertimeArray objectAtIndex:0]]];

        settingtypepickerview.hidden=YES;
        settingtypetoolbar.hidden=YES;
        overtimeratetoolbar.hidden=YES;
        overtimepicker.hidden=YES;
        ratePickerview.hidden=YES;
        rateToolbar.hidden=YES;
        calculateOvertimePickerview.hidden=YES;
        caloverToolbar.hidden=YES;
        
        calculateOvertimePickerview = [[UIPickerView alloc] init];
        [calculateOvertimePickerview setDataSource: self];
        [calculateOvertimePickerview setDelegate: self];
        calculateOvertimePickerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]];
        [calculateOvertimePickerview setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        calculateOvertimePickerview.showsSelectionIndicator = YES;
        [calculateOvertimePickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: calculateOvertimePickerview];
        calculateOvertimePickerview.hidden=NO;
        caloverToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [caloverToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        caloverToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:caloverToolbar];
        
        caloverToolbar.hidden=NO;
        [calculateOvertimeTxt resignFirstResponder];
        
        return NO;
    }
    
    
    settingtypepickerview.hidden=YES;
    settingtypetoolbar.hidden=YES;
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
    
    return YES;
}
-(IBAction)doneBtnPressed{
    settingtypepickerview.hidden=YES;
    settingtypetoolbar.hidden=YES;
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;
    
   
}

-(IBAction)dialogAction{
    settingtypepickerview.hidden=YES;
    settingtypetoolbar.hidden=YES;
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    ratePickerview.hidden=YES;
    rateToolbar.hidden=YES;
    calculateOvertimePickerview.hidden=YES;
    caloverToolbar.hidden=YES;

    if([overtimeRateStr isEqualToString:@"Custom X"]){
        [self overTimeDisplay];
    }else  if([overtimeRateStr isEqualToString:@"%"]){
        [self overTimeDisplay];
        
    }

}
- (void)overTimeDisplay
{
    overtimeratetoolbar.hidden=YES;
    overtimepicker.hidden=YES;
    // Here we need to pass a full frame
    overtimealertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [overtimealertView setContainerView:[self changePassAlert]];
    // Modify the parameters
    [overtimealertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [overtimealertView setUseMotionEffects:true];
    // And launch the dialog
    [overtimealertView show];
}
-(UIView *)changePassAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,150)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Enter custom over time value" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:15]];
    [demoView addSubview:topButton];
    
    alertviewTxt=[[UITextField alloc]initWithFrame:CGRectMake(2,50,296,48)];
    [alertviewTxt setFont:[UIFont boldSystemFontOfSize:15]];
    alertviewTxt.delegate = self;
    alertviewTxt.textAlignment = UITextAlignmentCenter;
    alertviewTxt.textColor=[UIColor whiteColor];
    alertviewTxt.layer.cornerRadius=8.0f;
    alertviewTxt.layer.masksToBounds=YES;
    alertviewTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    alertviewTxt.layer.borderWidth= 1.0f;
    [alertviewTxt setBackgroundColor:[UIColor clearColor]];
    [alertviewTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    alertviewTxt.inputAccessoryView = numberToolbar;
    if([overtimeRateStr isEqualToString:@"Custom X"]){
    alertviewTxt.placeholder=@"Enter your over time rate value";
    }else{
        alertviewTxt.placeholder=@"Enter your over time presentage value";
    }
    [demoView addSubview:alertviewTxt];

    UIButton *SettimeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,100,148,50)];
    [SettimeBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [SettimeBtn addTarget:self
                   action:@selector(submitBtnAction)
         forControlEvents:UIControlEventTouchUpInside];
    [SettimeBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:SettimeBtn];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(152,100,150,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:cancelBtn];
    return demoView;
    
}
-(void)closeAlert:(id)sender{
    [overtimealertView close];
}

-(void)submitBtnAction{
    [overtimealertView close];
    if ([alertviewTxt.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc]initWithTitle:@"Time & Expense" message:@"Please fill the value" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        [alert show];

    }else{
    if([overtimeRateStr isEqualToString:@"Custom X"]){
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if([alertviewTxt.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
            // newString consists only of the digits 0 through 9
            NSLog(@"valide");
        }        overtimeRateTxt.text=[NSString stringWithFormat:@"%@ X",alertviewTxt.text];

    }else{
        NSString * perStr=@"%";
       overtimeRateTxt.text=[NSString stringWithFormat:@"%@ %@",alertviewTxt.text,perStr];

    }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"No"]){
        [overtimealertView close];
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: overtimepicker]) {
        return [overtimerateArray count];
    }
    if ([pickerView isEqual: ratePickerview]) {
        return [rateArray count];
    }
    if ([pickerView isEqual: calculateOvertimePickerview]) {
        return [calovertimeArray count];
    }
    if ([pickerView isEqual: settingtypepickerview]) {
        return [settingtypeArray count];
    }

    return 0;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==overtimepicker)
    {
       overtimeRateStr=[[NSString alloc]init];
        overtimeRateStr=[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
            [overtimeRateTxt setText:[NSString stringWithFormat:@"%@",[overtimerateArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else  if (pickerView ==ratePickerview)
    {
        [rateTypeTxt setText:[NSString stringWithFormat:@"%@",[rateArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else  if (pickerView ==settingtypepickerview)
    {
        [settingtypeTxt setText:[NSString stringWithFormat:@"%@",[settingtypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else  if (pickerView ==calculateOvertimePickerview)
    {
        [calculateOvertimeTxt setText:[NSString stringWithFormat:@"%@",[calovertimeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    if (pickerView == overtimepicker)
    {
        rowItem = [overtimerateArray objectAtIndex: row];

    }
    if (pickerView == ratePickerview)
    {
        rowItem = [rateArray objectAtIndex: row];

    }if (pickerView == calculateOvertimePickerview)
    {
       rowItem = [calovertimeArray objectAtIndex: row];

    }
    if (pickerView == settingtypepickerview)
    {
        rowItem = [settingtypeArray objectAtIndex: row];

    }

    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == overtimepicker)
    {
        return [overtimerateArray objectAtIndex:row];
        
    }
    if (pickerView == ratePickerview)
    {
        return [rateArray objectAtIndex:row];
        
    }if (pickerView == calculateOvertimePickerview)
    {
        return [calovertimeArray objectAtIndex:row];
        
    }
    if (pickerView == settingtypepickerview)
    {
        return [settingtypeArray objectAtIndex:row];
        
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    
    return componentWidth;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return defaultListSetting.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor whiteColor];
    

    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(5,0,screenRect.size.width-80,screenRect.size.height*0.07)];
    [fieldLBls setText:[defaultListSetting objectAtIndex:indexPath.section]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    fieldLBls.textColor=[UIColor whiteColor];
    UIFont *customFontd = [UIFont fontWithName:@"dinneuzeitgrotesk-light" size:screenRect.size.width*0.04];
    [fieldLBls setFont:customFontd];
    [cell.contentView addSubview:fieldLBls];
     if(indexPath.section==0){
        rateTypeTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [rateTypeTxt setFont:customFontd];
        rateTypeTxt.delegate = self;
        rateTypeTxt.textAlignment = UITextAlignmentRight;
        rateTypeTxt.textColor=[UIColor whiteColor];
        rateTypeTxt.layer.cornerRadius=8.0f;
        rateTypeTxt.layer.masksToBounds=YES;
        rateTypeTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        rateTypeTxt.layer.borderWidth= 1.0f;
        [rateTypeTxt setBackgroundColor:[UIColor clearColor]];
        rateTypeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Rate Type" attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(rateTypeTxt.bounds.size.width, 0, 5, 20)];
        rateTypeTxt.rightView = paddingView;
        rateTypeTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:rateTypeTxt];
    }else if(indexPath.section==1){
        taxTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [taxTxt setFont:customFontd];
        taxTxt.delegate = self;
        taxTxt.textAlignment = UITextAlignmentRight;
        taxTxt.textColor=[UIColor whiteColor];
        taxTxt.layer.cornerRadius=8.0f;
        taxTxt.layer.masksToBounds=YES;
        taxTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        taxTxt.layer.borderWidth= 1.0f;
        [taxTxt setBackgroundColor:[UIColor clearColor]];
        [taxTxt setKeyboardType:UIKeyboardTypeDecimalPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        taxTxt.inputAccessoryView = numberToolbar;
        
        taxTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Tax" attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(taxTxt.bounds.size.width, 0, 2, 20)];
        taxTxt.rightView = paddingView;
        taxTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:taxTxt];
    }else if(indexPath.section==2){
        vatTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,5, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [vatTxt setFont:customFontd];
        vatTxt.delegate = self;
        vatTxt.textAlignment = UITextAlignmentRight;
        vatTxt.textColor=[UIColor whiteColor];
        vatTxt.layer.cornerRadius=8.0f;
        vatTxt.layer.masksToBounds=YES;
        vatTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        vatTxt.layer.borderWidth= 1.0f;
        [vatTxt setBackgroundColor:[UIColor clearColor]];
        [vatTxt setKeyboardType:UIKeyboardTypeDecimalPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        vatTxt.inputAccessoryView = numberToolbar;
        
        vatTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Vat" attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(vatTxt.bounds.size.width, 0, 2, 20)];
        vatTxt.rightView = paddingView;
        vatTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:vatTxt];
    }else if(indexPath.section==3){
        calculateOvertimeTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,5, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [calculateOvertimeTxt setFont:customFontd];
        calculateOvertimeTxt.delegate = self;
        calculateOvertimeTxt.textAlignment = UITextAlignmentRight;
        calculateOvertimeTxt.textColor=[UIColor whiteColor];
        calculateOvertimeTxt.layer.cornerRadius=8.0f;
        calculateOvertimeTxt.layer.masksToBounds=YES;
        calculateOvertimeTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        calculateOvertimeTxt.layer.borderWidth= 1.0f;
        [calculateOvertimeTxt setBackgroundColor:[UIColor clearColor]];
        calculateOvertimeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Calculate OverTime" attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(calculateOvertimeTxt.bounds.size.width, 0, 5, 20)];
        calculateOvertimeTxt.rightView = paddingView;
        calculateOvertimeTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:calculateOvertimeTxt];
        
    }else if(indexPath.section==4){
        overtimeTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [overtimeTxt setFont:customFontd];
        overtimeTxt.delegate = self;
        overtimeTxt.textAlignment = UITextAlignmentRight;
        overtimeTxt.textColor=[UIColor whiteColor];
        overtimeTxt.layer.cornerRadius=8.0f;
        overtimeTxt.layer.masksToBounds=YES;
        overtimeTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        overtimeTxt.layer.borderWidth= 1.0f;
        [overtimeTxt setBackgroundColor:[UIColor clearColor]];
        [overtimeTxt setKeyboardType:UIKeyboardTypeDecimalPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        overtimeTxt.inputAccessoryView = numberToolbar;

        overtimeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Over time hours   " attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(overtimeTxt.bounds.size.width, 0, 5, 20)];
        overtimeTxt.rightView = paddingView;
        overtimeTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:overtimeTxt];
        
    }else if(indexPath.section==5){
        overtimeRateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [overtimeRateTxt setFont:customFontd];
        overtimeRateTxt.delegate = self;
        overtimeRateTxt.textAlignment = UITextAlignmentRight;
        overtimeRateTxt.textColor=[UIColor whiteColor];
        overtimeRateTxt.layer.cornerRadius=8.0f;
        overtimeRateTxt.layer.masksToBounds=YES;
        overtimeRateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        overtimeRateTxt.layer.borderWidth= 1.0f;
        [overtimeRateTxt setBackgroundColor:[UIColor clearColor]];
        overtimeRateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Over time rate   " attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(overtimeRateTxt.bounds.size.width, 0, 5, 20)];
        overtimeRateTxt.rightView = paddingView;
        overtimeRateTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:overtimeRateTxt];
        
    }else if(indexPath.row==6){
        if(normalRateTxt==nil)
            normalRateTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,2, screenRect.size.width*0.58, screenRect.size.height*0.06)];
        [normalRateTxt setFont:customFontd];
        normalRateTxt.delegate = self;
        normalRateTxt.textAlignment = UITextAlignmentRight;
        normalRateTxt.layer.cornerRadius=8.0f;
        normalRateTxt.layer.masksToBounds=YES;
        normalRateTxt.tag=600+indexPath.section;
        normalRateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        normalRateTxt.layer.borderWidth= 1.0f;
        normalRateTxt.textColor=[UIColor whiteColor];
        [normalRateTxt setBackgroundColor:[UIColor clearColor]];
        [normalRateTxt setKeyboardType:UIKeyboardTypeDecimalPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        normalRateTxt.inputAccessoryView = numberToolbar;
        
        normalRateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Default rate value" attributes:@{NSForegroundColorAttributeName: color}];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(normalRateTxt.bounds.size.width, 0, 5, 20)];
        normalRateTxt.rightView = paddingView;
        normalRateTxt.rightViewMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:normalRateTxt];
        
    }
    
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=screenRect.size.height*0.07;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
    }}

- (void)didReceiveMemoryWarning {
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
