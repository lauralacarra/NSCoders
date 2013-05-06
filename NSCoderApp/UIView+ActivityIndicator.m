//
//  NSObject+UIView_ActivityIndicator.m
//
//  Created by Alberto Gimeno Brieba on 27/06/12.
//  Copyright (c) 2012 Level Apps S.L. All rights reserved.
//

#import "UIView+ActivityIndicator.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ActivityIndicator)

- (void)showActivityIndicator {
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style {
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    UIView* view = [[UIView alloc] initWithFrame:frame];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = [UIColor darkGrayColor];
    view.layer.opacity = 0.5;
    view.tag = 1001;
    [self addSubview:view];
    
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    indicator.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    indicator.tag = 1002;
    indicator.center = view.center;
    [indicator startAnimating];
    [self addSubview:indicator];
}

- (void)hideActivityIndicator {
    [[self viewWithTag:1001] removeFromSuperview];
    [[self viewWithTag:1002] removeFromSuperview];
}

@end
