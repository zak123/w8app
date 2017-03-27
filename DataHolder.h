//
//  DataHolder.h
//  Tip Calculator
//
//  Created by Zachary Mallicoat on 3/20/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHolder : NSObject

+ (DataHolder *)sharedInstance;

@property (nonatomic) NSString *restaurantName;
@property (nonatomic) NSString *textMessage;
@property (nonatomic) NSString *timeLeft;

-(void) saveData;
-(void) loadData;

@end