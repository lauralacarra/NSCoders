//
//  UIViewController+Helper.h
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 01/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

- (void)presentViewControllerWhenAuthenticated:(UIViewController*)viewController;

- (void)addDismissNavigationControllerBarButtonItem;

- (void)dismissNavigationController:(id)sender;

@end
