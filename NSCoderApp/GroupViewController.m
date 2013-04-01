//
//  GroupViewController.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "GroupViewController.h"
#import "EventViewController.h"
#import "GroupsViewController.h"

@interface GroupViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation GroupViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadEvents) forControlEvents:UIControlEventValueChanged];
    
    if (self.group) {
        [self.refreshControl beginRefreshing];
        [self loadEvents];
    }
    
    UIBarButtonItem *change = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleBordered target:self action:@selector(changeGroup)];
    self.navigationItem.leftBarButtonItem = change;

}

- (void)changeGroup {
    GroupsViewController *groups = [[GroupsViewController alloc] init];
    groups.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:groups];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)loadEvents {
    BBQuery *query = [Backbeam queryForEntity:@"event"];
    [query setQuery:@"where group is ?" withParams:@[self.group]];
    [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    [query fetch:100 offset:0 success:^(NSArray* events, NSInteger total, BOOL fromCache) {
        
        self.events = events;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"error %@", error);
    }];
    
    self.title = [self.group stringForField:@"name"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.group) {
        [self changeGroup];
    }
}

- (void)groupChosen:(BBObject *)group {
    self.group = group;
    [self.refreshControl beginRefreshing];
    [self loadEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BBObject *event = [self.events objectAtIndex:indexPath.row];
    cell.textLabel.text = [event stringForField:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBObject *event = [self.events objectAtIndex:indexPath.row];
    EventViewController *vc = [[EventViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.event = event;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
