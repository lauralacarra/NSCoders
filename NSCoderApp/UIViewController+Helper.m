//
//  UIViewController+Helper.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 01/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "Backbeam.h"
#import "SignupViewController.h"

@implementation UIViewController (Helper)

- (void)presentViewControllerWhenAuthenticated:(UIViewController*)viewController {
    UINavigationController* nc = nil;
    
    BBObject* user = [Backbeam currentUser];
    if (!user) {
        SignupViewController* signup = [[SignupViewController alloc] init];
        signup.nextViewController = viewController;
        nc = [[UINavigationController alloc] initWithRootViewController:signup];
    } else {
        nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)addDismissNavigationControllerBarButtonItem {
    UIBarButtonItem* close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissNavigationController:)];
    self.navigationItem.rightBarButtonItem = close;
}

- (void)dismissNavigationController:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
