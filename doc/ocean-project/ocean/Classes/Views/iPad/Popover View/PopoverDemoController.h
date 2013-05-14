//
//  PopoverDemoController.h
//  ocean
//
//  Created by Tope on 18/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PopoverDemoControllerDelegate;


@interface PopoverDemoController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    NSMutableArray *listOfItems;
    NSMutableArray *copyListOfItems;
    IBOutlet UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
}

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet id <PopoverDemoControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)done:(id)sender;

@end


@protocol PopoverDemoControllerDelegate
- (void)popoverDemoControllerDidFinish:(PopoverDemoController *)controller;
@end