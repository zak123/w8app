//
//  TwilioCommunicator.m
//  w8app
//
//  Created by Zachary Mallicoat on 4/7/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "TwilioCommunicator.h"

@implementation TwilioCommunicator

- (void)sendTextMessage:(NSString *)phoneNumber withMessage:(NSString *)textMessage forCustomer:(NSString *)customer withDeadline:(NSString *)deadline{
    
    NSLog(@"Sending request.");
    
    // Common constants
    NSString *kUnParsedMessage = [DataHolder sharedInstance].textMessage;
    NSString *kRestaurantName = [DataHolder sharedInstance].restaurantName;
    
    NSString *kTwilioSID = @"AC20552c31897f56a2514ec3129b4d0c3a";
    NSString *kTwilioSecret = @"9052e40dbc1af9db23709b65a58ca2a8";
    NSString *kFromNumber = @"+16043301888";
    NSString *kToNumber = phoneNumber;
    NSString *kMessage = [self getParsedMessage:kUnParsedMessage customerName:customer restaurantName:kRestaurantName withTimeLeft:deadline];
    
    // Build request
    NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", kTwilioSID, kTwilioSecret, kTwilioSID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    // Set up the body
    NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", kFromNumber, kToNumber, kMessage];
    NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSError *error;
    NSURLResponse *response;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Handle the received data
    if (error) {
        NSLog(@"Error: %@", error);
        UIAlertView *errorAlert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message:@"Error sending message, check internet connection"
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [errorAlert show];
        
    }
    

    
    else {
        NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"Request sent. %@", receivedString);
        
        if ([self getTagValue:receivedString tagName:@"Message"].length == 0){
        UIAlertView *successAlert =[[UIAlertView alloc ] initWithTitle:@"Notification Sent"
                                                               message:[NSString stringWithFormat:@"Message successfully sent to %@", phoneNumber]
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles: nil];
            
            [successAlert show];
        }
        
        else{
        UIAlertView *notValidAlert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                               message:[self getTagValue:receivedString tagName:@"Message"]
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
        [notValidAlert show];
    }
    
    
    }
}

-(NSString *)getParsedMessage:(NSString *)message customerName:(NSString *)customer restaurantName:(NSString *)restaurant withTimeLeft:(NSString *)time{
    message = [message stringByReplacingOccurrencesOfString:@"<customer>" withString:customer];
    
    message = [message stringByReplacingOccurrencesOfString:@"<restaurant>" withString:restaurant];
    
    message = [message stringByReplacingOccurrencesOfString:@"<time>" withString:time];
    
    
    return message;
    
    
}

-(NSString *)getTagValue:(NSString *)xmlStr tagName:(NSString *)tagName
{
    NSString *ret = @"";
    @try{
        NSScanner *scanner = [[NSScanner alloc] initWithString:xmlStr];
        [scanner scanUpToString:[NSString stringWithFormat:@"<%@>",tagName] intoString:nil];
        [scanner scanString:[NSString stringWithFormat:@"<%@>",tagName] intoString:nil];
        [scanner scanUpToString:[NSString stringWithFormat:@"</%@>",tagName] intoString:&ret];
    }
    @catch(NSException *ex)
    {}  
    return ret;  
}


@end
