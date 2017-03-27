//
//  EditViewController.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/7/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController () <UITextFieldDelegate>

@end

@implementation EditViewController


-(void) viewDidLoad {
    NSLog(@"EditViewLoaded");
    
    self.nameInput.text = self.editDetailItem.customerName;
    self.phoneNumberInput.text = self.editDetailItem.phoneNumber;
    self.partySizeInput.text = self.editDetailItem.partySize;
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    NSLog(@"BWEUFHWEOIFJ");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    
    
    
    [self textFieldShouldReturn:sender];
    [self.delegate sendCustomerName:self.nameInput.text andPhoneNumber:self.phoneNumberInput.text andPartySize:self.partySizeInput.text];
    
    [self saveNewTask];
    
    
}

- (IBAction)tapGesturePressed:(id)sender {
    [self.nameInput resignFirstResponder];
    [self.phoneNumberInput resignFirstResponder];
    [self.partySizeInput resignFirstResponder];
}

- (void)saveNewTask {
    if (self.nameInput.text.length > 0) {
        //task and description not nil and add object
        
        
        
        

    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self.delegate enteredName:self.nameInput.text andEnteredPhone:self.phoneNumberInput.text andEnteredPartySize:self.partySizeInput.text];
    [self dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

@end
