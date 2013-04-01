//
//  GroupsViewController.h
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Backbeam.h"

@protocol GroupsChooserDelegate <NSObject>

- (void)groupChosen:(BBObject*)group;

@end;

@interface GroupsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, weak) id<GroupsChooserDelegate> delegate;

@end
