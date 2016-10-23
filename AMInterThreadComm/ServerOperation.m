//
//  ServerOperation.m
//  AMInterThreadComm
//
//  Created by Aleksandar Matijaca on 2016-10-23.
//  Copyright © 2016 Aleksandar Matijaca. All rights reserved.
//

#import "ServerOperation.h"

@interface ServerOperation()


@end


@implementation ServerOperation

- (void)main {
   
    NSLog(@"Starting Server Main");
    [self create_port];
    
}

CFDataRef callback(CFMessagePortRef local, SInt32 msgid, CFDataRef data, void *info)
{
    
    // get the command value...
    NSData* data2 = (__bridge NSData*) data;
    NSString *myCommand =  [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSLog(@"command sent to me is: %@", myCommand);
    NSLog(@"my message id is: %i",msgid);
    
    // respond back with time and a little bit of text
    NSDate *todaysDate = [NSDate new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm:ss  "];
    NSString *strDateTime = [formatter stringFromDate:todaysDate];
    NSString *command = [[@"SERVER says the time is : " stringByAppendingString:strDateTime] stringByAppendingString:myCommand];
    
    // prepare data for sending back....
    NSData *serverSays = [command dataUsingEncoding:NSUTF8StringEncoding];
    return (CFDataRef)CFBridgingRetain(serverSays);
    
}

- (void) create_port
{
    // prepare a port
    CFStringRef port_name = CFSTR("com.polyorb.app.myapp");
    
    // create our answer port - callback is the name of the function that will be called when we get a "request" from a client.
    CFMessagePortRef serverPort = CFMessagePortCreateLocal(kCFAllocatorDefault, port_name, &callback, NULL, NULL);
    
    // launch a separate thread via which we answer requests...
    CFMessagePortSetDispatchQueue(serverPort, dispatch_get_main_queue());
}

@end
