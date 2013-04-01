//
//  AppDelegate.m
//  NSCoderApp
//
//  Created by Daniel Vela on 18/02/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupViewController.h"
#import "Backbeam.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Backbeam setProject:@"nscoder" sharedKey:@"a6f611a349544a5f0f49f2ecca1dac1a536f5b43" secretKey:@"4efa6b97dc0cd2dae11fccb156607d40db3117894bd8f172a64540b137251c8c79f141fd212478bb" environment:@"dev"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GroupViewController *group = [[GroupViewController alloc] init];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:group];
    self.window.rootViewController = self.navigationController;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
