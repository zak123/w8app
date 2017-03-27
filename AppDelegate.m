//
//  AppDelegate.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/6/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "CoreDataManager.h"
#import "DataHolder.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    coreDataManager;
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [coreDataManager save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[DataHolder sharedInstance] saveData];
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[DataHolder sharedInstance] loadData];
    
}

@end