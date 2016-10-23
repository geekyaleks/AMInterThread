//
//  ViewController.m
//  AMInterThreadComm
//
//  Created by Aleksandar Matijaca on 2016-10-23.
//  Copyright © 2016 Aleksandar Matijaca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITextView *serverResponseTextView;
@property (nonatomic, strong) IBOutlet UITextField *commandTextField;
@property (nonatomic, strong) NSString *displayText;

@end

@implementation ViewController


- (IBAction)clearServerResponsePressed:(id)sender {
    
    self.serverResponseTextView.text = @"";
    self.displayText = @"";
    
}


- (IBAction)sendCommandPressed:(id)sender {

    // get command text
    NSString *command = self.commandTextField.text;
    
    // prepare for talking to this port name
    CFStringRef port_name = CFSTR("com.polyorb.app.myapp");
    CFMessagePortRef rcPort = CFMessagePortCreateRemote(kCFAllocatorDefault, port_name);
    
    // prepare data for sending
    SInt32 messageIdentifier = 1;
    CFDataRef messageData = (__bridge CFDataRef)[command dataUsingEncoding:NSUTF8StringEncoding];
    
    // response will have the server response back to us.
    CFDataRef response = NULL;
    
    // actually send data to server
    SInt32 status = CFMessagePortSendRequest(rcPort, messageIdentifier, messageData, 1000, 1000, kCFRunLoopDefaultMode, &response);
    NSLog(@"status is %i", status);
    
    // drop keyboard so we can see the display...
    [self.commandTextField resignFirstResponder];
    
    // get response from thread
    NSData* data2 = (__bridge NSData*) response;
    
    // convert into something displayable
    NSString *serverResponse =  [[[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding] stringByAppendingString:@"\n" ];

    NSLog(@"server response is %@", serverResponse);
    
    // display the response on the textview.
    self.displayText = [self.displayText stringByAppendingString:serverResponse];
    self.serverResponseTextView.text = self.displayText;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.displayText = [[NSString alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
