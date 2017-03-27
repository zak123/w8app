//
//  SettingsViewController.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/8/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHolder.h"


@interface SettingsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *restaurantNameInput;
@property (strong, nonatomic) IBOutlet UITextView *textMessageInput;
@property (strong, nonatomic) IBOutlet UIPickerView *timeAllowancePicker;
@property (strong, nonatomic) NSString *currentPickedTime;


@end
