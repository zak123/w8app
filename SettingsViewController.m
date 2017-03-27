//
//  SettingsViewController.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/8/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "SettingsViewController.h"
#import "Customer.h"
#import "CoreDataManager.h"

@interface SettingsViewController () <UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
    


@end

@implementation SettingsViewController{
    NSArray *timeAllowancePickerData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DataHolder *dataHolder = [DataHolder sharedInstance];
    [dataHolder loadData];
    
    _currentPickedTime = dataHolder.timeLeft;
    
    


    
    self.restaurantNameInput.text = dataHolder.restaurantName;
    self.textMessageInput.text = dataHolder.textMessage;
    
     timeAllowancePickerData = @[@"8", @"10", @"15", @"20", @"25", @"30", @"45", @"60"];
    
    // Connect data
    self.timeAllowancePicker.dataSource = self;
    self.timeAllowancePicker.delegate = self;
    
    

}

-(void)viewDidAppear:(BOOL)animated {
    NSInteger selectedRow = [timeAllowancePickerData indexOfObject:[DataHolder sharedInstance].timeLeft];
    [self.timeAllowancePicker selectRow:selectedRow inComponent:0 animated:NO];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return timeAllowancePickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return timeAllowancePickerData[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.currentPickedTime = timeAllowancePickerData[row];
    NSLog(@"%@", timeAllowancePickerData[row]);
}

- (IBAction)donePressed:(id)sender {
    
    NSLog(@"%@", self.currentPickedTime);
    
    [DataHolder sharedInstance].textMessage = _textMessageInput.text;
    [DataHolder sharedInstance].restaurantName = _restaurantNameInput.text;
    [DataHolder sharedInstance].timeLeft = _currentPickedTime;
    [self saveData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)tapGesturePressed:(id)sender {
    [self.restaurantNameInput resignFirstResponder];
    [self.textMessageInput resignFirstResponder];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteAllPressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset?"
                                                    message:@"Do you really want to reset your list?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
    [self alertView:alert clickedButtonAtIndex:0];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [coreDataManager deleteAllObjects];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)saveData {
    [[DataHolder sharedInstance] saveData];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
