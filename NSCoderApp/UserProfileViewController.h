//
//  UserProfileViewController.h
//  NSCoderApp
//
//  Created by Laura Lacarra on 28/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//



#import "EventsViewController.h"
#import <UIKit/UIKit.h>
#import "Backbeam.h"

@interface UserProfileViewController : UITableViewController

@property (nonatomic, strong) BBObject *user;

@end
