//
//  MasterViewController.h
//  ocean
//
//  Created by Tope on 09/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol MasterViewControllerDelegate;

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* masterTableView;

@property (nonatomic, strong) NSArray* models;

@property (nonatomic, unsafe_unretained) id<MasterViewControllerDelegate> delegate;

-(CALayer *)createShadowWithFrame:(CGRect)frame;

@end


@protocol MasterViewControllerDelegate <NSObject>


@end