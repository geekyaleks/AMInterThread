//
//  AppDelegate.m
//  AMInterThreadComm
//
//  Created by Aleksandar Matijaca on 2016-10-23.
//  Copyright © 2016 Aleksandar Matijaca. All rights reserved.
//

#import "AppDelegate.h"
#import "ServerOperation.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) ServerOperation *server;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // create operations queue, and launch a Server...
    self.queue = [[NSOperationQueue alloc] init];
    [self.queue setName:@"my_test_queue"];
    self.server = [[ServerOperation alloc] init];
    [self.queue addOperation:self.server];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
