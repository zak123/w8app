//
//  TwilioCommunicator.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/7/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataHolder.h"

@interface TwilioCommunicator : NSObject

- (void)sendTextMessage:(NSString *)phoneNumber withMessage:(NSString *)textMessage forCustomer:(NSString *)customer withDeadline:(NSString *)deadline;
@end


