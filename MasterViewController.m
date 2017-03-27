//
//  MasterViewController.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Customer.h"
#import "CoreDataManager.h"




@interface MasterViewController ()
@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControl;

@end

@implementation MasterViewController {
    NSString *_refreshedTime;
    NSDate *objectTimestamp;
    NSString *formattedTime;
    UIColor *cellBackgroundColor;
    UIColor *cellTextColor;
    TwilioCommunicator *_communicator;
    int minutes;
    int hours;

    

    
    
}

#pragma mark - Table View -

- (void)viewDidLoad {
    [self refreshLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [coreDataManager sectionsCount];
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    return [coreDataManager setSectionName:section];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [coreDataManager numberOfRowsForSection:section];
}

- (MCSwipeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction)didRefresh:(id)sender {
    
    [self.tableView reloadData];
    [sender endRefreshing];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        
        BOOL lastRow = FALSE;
        if ([tableView numberOfRowsInSection:[indexPath section]] == 1 ) {
            lastRow = TRUE;
        }
        
        [self.tableView beginUpdates];
        
        
        [coreDataManager deleteObject:[coreDataManager objectAtIndexPath:indexPath]];
        [coreDataManager saveContext];
        
        if (lastRow) {
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
        } else {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        }
        
        [self.tableView endUpdates];
        
    }
    
}

//- (void)deleteAllCellsForNewDay{
//    NSDate *currentTime = [NSDate date];
//    NSDateFormatter *formattedCurrentTime = [[NSDateFormatter alloc] init];
//    [formattedCurrentTime setDateFormat:@"HH:mm"];
//    NSString *newTimeString = [formattedCurrentTime stringFromDate:currentTime];
//    if ([newTimeString isEqualToString:@"04:00"]){
//        [myArray removeAllObjects];
//        [tableView reloadData];
//    }
//}

- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)refreshLabel
{
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView reloadData];
    });
    [self performSelector:@selector(refreshLabel) withObject:nil afterDelay:60];
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

- (void)configureCell:(MCSwipeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Customer *object = [coreDataManager objectAtIndexPath:indexPath];
    
    objectTimestamp = object.timeStamp;
    
    UIView *checkView = [self viewWithImageName:@"check"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];

    cell.firstTrigger = 0.2;
    
    [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Checkmark\" cell");
        
        if ([object.checkedIn isEqualToNumber:@0]) {
        object.checkedIn = [NSNumber numberWithBool:YES];
        }
        else {
        object.checkedIn = [NSNumber numberWithBool:NO];
        }
        [coreDataManager saveContext];
        [self.tableView reloadData];
        NSLog(@"%@", object.checkedIn);
        
    }];
    

    
    
    
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:object.timeStamp];
    
    float tempDate = diff;
    int result = ceil(tempDate);
    if ([object.checkedIn isEqualToNumber:@0]) {
    [self setUrgency:result];
    cell.backgroundColor = cellBackgroundColor;
    cell.textLabel.textColor = cellTextColor;
    cell.detailTextLabel.textColor = cellTextColor;
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }

    [self returnFormattedString:result];
    
    if (object.partySize.length == 0) {
        cell.textLabel.text = object.customerName;
    }
    else {
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", object.customerName, object.partySize];
    }
    
    

    cell.detailTextLabel.text = formattedTime;
    
}

-(NSString *)returnFormattedString:(int)result {
    

    
    if (result > 60) {
        minutes = result / 60;
        formattedTime = [NSString stringWithFormat:@"%d minutes", minutes];
    }
    if (minutes > 60 ) {
        hours = minutes / 60;
        formattedTime = [NSString stringWithFormat:@"%d hours", hours];
    }
    if (result < 60) {
        formattedTime = [NSString stringWithFormat:@"%d seconds", result];
    }
    return formattedTime;
}

-(UIColor *)setUrgency:(int)result{
    
    
    if (result <= 5 * 60) {
        cellTextColor = [UIColor blackColor];
        cellBackgroundColor = [UIColor colorWithRed:0 green:0.839 blue:0.898 alpha:1]; /*#00d6e5*/

    }
    else if (result > 5 * 60 && result <= 15 * 60){
        cellTextColor = [UIColor whiteColor];
        cellBackgroundColor = [UIColor colorWithRed:0.012 green:0.671 blue:0.867 alpha:1]; /*#03abdd*/
    }
    else if (result > 15 * 60 && result <= 30 * 60){
        cellTextColor = [UIColor whiteColor];
        cellBackgroundColor = [UIColor colorWithRed:0.024 green:0.502 blue:0.835 alpha:1]; /*#0680d5*/
    }
    else if (result > 30 * 60 && result <= 45 * 60) {
        cellTextColor = [UIColor whiteColor];
        cellBackgroundColor = [UIColor colorWithRed:0.035 green:0.333 blue:0.808 alpha:1]; /*#0955ce*/
    }
    else if (result > 45 * 60 && result <= 60 * 60) {
        cellTextColor = [UIColor whiteColor];
        cellBackgroundColor = [UIColor colorWithRed:0.047 green:0.165 blue:0.776 alpha:1]; /*#0c2ac6*/
    }
    else if (result > 60 * 60) {
        cellTextColor = [UIColor whiteColor];
        cellBackgroundColor = [UIColor colorWithRed:0.059 green:0 blue:0.749 alpha:1]; /*#0f00bf*/
    }
    return cellBackgroundColor;
}

#pragma mark - Segues -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([[segue identifier] isEqualToString:@"showDetail"]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            [[segue destinationViewController] setDetailItem:[coreDataManager objectAtIndexPath:indexPath]];
        }
}

@end
