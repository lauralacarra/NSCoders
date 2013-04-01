//
//  EventViewController.h
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Backbeam.h"

@interface EventViewController : UITableViewController

@property (nonatomic, strong) BBObject *event;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *description;
@property (nonatomic, strong) UISegmentedControl *assistSelection;

@end
