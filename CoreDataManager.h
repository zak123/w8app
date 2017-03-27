//
//  CoreDataManager.h
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

#define coreDataManager [CoreDataManager sharedManager]

@interface CoreDataManager : NSObject

+ (instancetype)sharedManager;

- (void)save;

-(NSString *) setSectionName:(NSInteger)section;

- (NSError *)saveContext;

-(void) deleteObject:(Customer *)customer;
- (void)deleteAllObjects;


- (NSInteger)sectionsCount;
-(Customer*)newCustomerObejct;

- (NSInteger)numberOfRowsForSection:(NSInteger)section;
- (Customer *)objectAtIndexPath:(NSIndexPath *)path;


@end