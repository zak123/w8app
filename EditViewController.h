//
//  EditViewController.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/7/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import "DetailViewController.h"

@protocol senddataProtocol <NSObject>
-(void)sendCustomerName:(NSString *)customerName andPhoneNumber:(NSString *)phoneNumber andPartySize:(NSString *)partySize;
@end

@interface EditViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Customer *editDetailItem;

@property (nonatomic) id <senddataProtocol> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameInput;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberInput;
@property (strong, nonatomic) IBOutlet UITextField *partySizeInput;

@end
