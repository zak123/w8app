//
//  AddCustomerTableViewController.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

//@protocol ControllerDelegate
//
//-(void)enteredName:(NSString *)name andEnteredPhone:(NSString *)phone andEnteredPartySize:(NSString *)partySize;
//
//@end

@interface AddCustomerTableViewController : UITableViewController <UITextFieldDelegate>






@property (strong, nonatomic) IBOutlet UITextField *nameInput;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberInput;
@property (strong, nonatomic) IBOutlet UITextField *partySizeInput;
//@property (nonatomic) id <ControllerDelegate> delegate;

@end
