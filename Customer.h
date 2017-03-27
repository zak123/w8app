//
//  Customer.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/7/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Customer : NSManagedObject

@property (nonatomic, retain) NSNumber * checkedIn;
@property (nonatomic, retain) NSString * customerName;
@property (nonatomic, retain) NSNumber * noShow;
@property (nonatomic, retain) NSString * partySize;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSDate * timeStamp;

@end
