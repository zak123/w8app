//
//  DetailViewController.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import "CoreDataManager.h"
#import "TwilioCommunicator.h"
#import "EditViewController.h"
#import "MBProgressHUD.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Customer *detailItem;
@property (nonatomic) BOOL isCheckedIn;

@end

