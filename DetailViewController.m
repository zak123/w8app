//
//  DetailViewController.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"


@interface DetailViewController () <senddataProtocol>

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *partySizeLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkInButton;



@end

@implementation DetailViewController {
    TwilioCommunicator *_communicator;
    NSString *setName;
    MBProgressHUD *_hud;
    NSString *minutesToAdd;

}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}
-(void)sendCustomerName:(NSString *)customerName andPhoneNumber:(NSString *)phoneNumber andPartySize:(NSString *)partySize {
    self.phoneLabel.text = phoneNumber;
    self.partySizeLabel.text = partySize;
    setName = customerName;
    [self setTitle:setName];
    
    self.detailItem.customerName = customerName;
    self.detailItem.phoneNumber = phoneNumber;
    self.detailItem.partySize = partySize;
    
    
    [coreDataManager saveContext];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];


}

- (IBAction)notifyButtonPressed:(id)sender {
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"Loading";
    [_hud show:YES];
    
    NSDate *now = [NSDate date];
    
    
    NSString *deadline = [self parseDeadline:now];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        [_communicator sendTextMessage:self.detailItem.phoneNumber withMessage:[DataHolder sharedInstance].textMessage forCustomer:self.detailItem.customerName withDeadline:deadline];
        
        
        
        [_hud hide:YES];




    });
    

    
}

-(NSString *)parseDeadline:(NSDate *)date{
    
    NSDate *newDate = [date dateByAddingTimeInterval:60 * [minutesToAdd intValue]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    NSString *newTimeString = [outputFormatter stringFromDate:newDate];
    return newTimeString;
    
}

- (IBAction)checkInButtonPressed:(id)sender {
    
    if ([self.detailItem.checkedIn isEqualToNumber:@0]) {
        self.detailItem.checkedIn = [NSNumber numberWithBool:YES];
    }
    else {
        self.detailItem.checkedIn = [NSNumber numberWithBool:NO];
    }
    [coreDataManager saveContext];

    [self.navigationController popViewControllerAnimated:YES];

}




- (void)configureView {
    // Update the user interface for the detail item.
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataHolder *dataHolder = [DataHolder sharedInstance];
    [dataHolder loadData];
    
    
    
    minutesToAdd = dataHolder.timeLeft;
    if ([self.detailItem.customerName isEqualToString:@"danny"] || [self.detailItem.customerName isEqualToString:@"Danny"]) {
        [self.checkInButton setImage:[UIImage imageNamed:@"danny"] forState:UIControlStateNormal];
    }
    
    _communicator = [[TwilioCommunicator alloc]init];
    
    if ([self.detailItem.checkedIn isEqualToNumber:@1]) {
        
        [self.checkInButton setImage:[UIImage imageNamed:@"bigUncheckin"] forState:UIControlStateNormal];
        
        
    }
    

            self.phoneLabel.text = self.detailItem.phoneNumber;

            self.partySizeLabel.text = self.detailItem.partySize;
        
        
    


    // Do any additional setup after loading the view, typically from a nib.
    setName = self.detailItem.customerName;
    [self setTitle:setName];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showEdit"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        EditViewController *editVC = (EditViewController *)navigationController.topViewController;
        
        
        editVC.editDetailItem = self.detailItem;
        editVC.delegate = self;
    }
}

@end
