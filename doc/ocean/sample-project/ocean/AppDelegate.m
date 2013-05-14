//
//  AppDelegate.m
//  ocean
//
//  Created by Tope on 14/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (idiom == UIUserInterfaceIdiomPad) 
    {
        [self customizeiPadTheme];
        
        [self iPadInit];
    }
    else 
    {
        [self customizeiPhoneTheme];
        
        [self configureiPhoneTabBar];
    }

    // Override point for customization after application launch.
    return YES;
}

-(void)customizeiPhoneTheme
{
    [[UIApplication sharedApplication] 
     setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    
    UIImage *navBarImage = [UIImage imageNamed:@"menubar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *barButton = [[UIImage imageNamed:@"menubar-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 4)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal 
                                                    barMetrics:UIBarMetricsDefault];
    
    
    UIImage *minImage = [UIImage imageNamed:@"ipad-slider-fill"];
    UIImage *maxImage = [UIImage imageNamed:@"ipad-slider-track.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"ipad-slider-handle.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar-active.png"]];

}

-(void)customizeiPadTheme
{
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-menubar-right.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault]; 
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], 
      UITextAttributeTextColor, 
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8], 
      UITextAttributeTextShadowColor, 
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], 
      UITextAttributeTextShadowOffset, 
      nil]];

    
    UIImage *minImage = [UIImage imageNamed:@"ipad-slider-fill"];
    UIImage *maxImage = [UIImage imageNamed:@"ipad-slider-track.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"ipad-slider-handle.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    
    UIImage *barItemImage = [[UIImage imageNamed:@"ipad-menubar-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:barItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
      
}


-(void)iPadInit
{
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController; 
    
    splitViewController.delegate = [splitViewController.viewControllers lastObject];
    
    
    id<MasterViewControllerDelegate> delegate = [splitViewController.viewControllers lastObject];
    UINavigationController* nav = [splitViewController.viewControllers objectAtIndex:0];
    
    MasterViewController* master = [nav.viewControllers objectAtIndex:0];
    
    master.delegate = delegate;
    
}


-(void)configureiPhoneTabBar
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
	
    UIViewController *controller1 = [[tabBarController viewControllers] objectAtIndex:0];
    [self configureTabBarItemWithImageName:@"tab-icon1.png" andText:@"Elements" forViewController:controller1];
    
    
    UIViewController *controller2 = [[tabBarController viewControllers] objectAtIndex:1];
    [self configureTabBarItemWithImageName:@"tab-icon2.png" andText:@"Elements" forViewController:controller2];
    
    
    UIViewController *controller3 = [[tabBarController viewControllers] objectAtIndex:2];
    [self configureTabBarItemWithImageName:@"tab-icon3.png" andText:@"Other" forViewController:controller3];
    
    
    UIViewController *controller4 = [[tabBarController viewControllers] objectAtIndex:3];
    [self configureTabBarItemWithImageName:@"tab-icon4.png" andText:@"Other" forViewController:controller4];
    
}

-(void)configureTabBarItemWithImageName:(NSString*)imageName andText:(NSString *)itemText forViewController:(UIViewController *)viewController
{
    UIImage* icon1 = [UIImage imageNamed:imageName];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:itemText image:icon1 tag:0];
    [item1 setFinishedSelectedImage:icon1 withFinishedUnselectedImage:icon1];
    
    [viewController setTabBarItem:item1];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
