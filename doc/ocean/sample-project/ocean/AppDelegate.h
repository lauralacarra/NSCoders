//
//  AppDelegate.h
//  ocean
//
//  Created by Tope on 14/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)customizeiPadTheme;

-(void)customizeiPhoneTheme;

-(void)iPadInit;

-(void)configureiPhoneTabBar;

-(void)configureTabBarItemWithImageName:(NSString*)imageName andText:(NSString *)itemText forViewController:(UIViewController *)viewController;

@end
