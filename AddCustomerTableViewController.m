//
//  AddCustomerTableViewController.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "AddCustomerTableViewController.h"
#import "CoreDataManager.h"

@implementation AddCustomerTableViewController

-(void) viewDidLoad {
    NSLog(@"AddViewLoaded");
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    
    
    
    [self textFieldShouldReturn:sender];
    NSLog(@"Name: %@\n Phone: %@\n Party Size: %@\n", self.nameInput.text, self.phoneNumberInput.text, self.partySizeInput.text);
    
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
        
        
        
        
        Customer *customer = [[CoreDataManager sharedManager] newCustomerObejct];

        customer.customerName = self.nameInput.text;
        customer.phoneNumber = self.phoneNumberInput.text;
        customer.partySize = self.partySizeInput.text;
        customer.timeStamp = [[NSDate alloc] init];

        
        [coreDataManager saveContext];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

@end
