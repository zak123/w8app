//
//  DataHolder.m
//  Tip Calculator
//
//  Created by Zachary Mallicoat on 3/20/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "DataHolder.h"

NSString * const kRestaurantName = @"kName";
NSString * const kTextMessage = @"kMessage";
NSString * const kTimeLeft = @"kTime";

@implementation DataHolder

- (id) init
{
    self = [super init];
    if (self)
    {
        _restaurantName = nil;
        _textMessage = nil;
        _timeLeft = nil;
        
    }
    return self;
}

+ (DataHolder *)sharedInstance
{
    static DataHolder *_sharedInstance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      _sharedInstance = [[self alloc] init];
                      
                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                      
                      [defaults registerDefaults:@{ kRestaurantName : @"w8list Restaurant", kTextMessage : @"Hello <customer>, your table is ready at <restaurant>. You have until <time> to keep your spot.", kTimeLeft : @"8"}];
                      
                      [defaults synchronize];
                      
                      [_sharedInstance loadData];
                  });
    
    return _sharedInstance;
}

//in this example you are saving data to NSUserDefault's
//you could save it also to a file or to some more complex
//data structure: depends on what you need, really

-(void)saveData
{
    
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSString stringWithString:self.restaurantName] forKey:kRestaurantName];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSString stringWithString:self.textMessage] forKey:kTextMessage];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSString stringWithString:self.timeLeft] forKey:kTimeLeft];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)loadData
{
    
    self.restaurantName = (NSString *)[[NSUserDefaults standardUserDefaults]
                                    objectForKey:kRestaurantName];
    
    self.textMessage = (NSString *)[[NSUserDefaults standardUserDefaults]
                                        objectForKey:kTextMessage];
    
    self.timeLeft = (NSString *)[[NSUserDefaults standardUserDefaults]
                                    objectForKey:kTimeLeft];

    
}

@end