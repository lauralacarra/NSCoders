//
//  AssitanceListTableViewController.m
//  NSCoderApp
//
//  Created by Daniel Vela on 4/22/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "AssitanceListTableViewController.h"

@interface AssitanceListTableViewController ()

@property (nonatomic, strong) NSArray *assitances;

@end

@implementation AssitanceListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Assitances";

  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self
                          action:@selector(refresh)
                forControlEvents:UIControlEventValueChanged];
  [self.refreshControl beginRefreshing];
  [self refresh];
}

- (void)refresh {
  [self refreshAssitances:YES];
}

- (void)refreshAssitances:(BOOL)avoidCache {
  BBQuery *query = [Backbeam queryForEntity:@"assistance"];
  [query setQuery:@"where events is ? join users" withParams:@[self.event]];
  if (!avoidCache) {
    [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
  }
  [query fetch:100 offset:0 success:^(NSArray* assitances, NSInteger total, BOOL fromCache) {
    self.assitances = assitances;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
  } failure:^(NSError *error) {
    NSLog(@"error %@", error);
    [self.refreshControl endRefreshing];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.assitances count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
  }

  // TODO Improve cell visual format

  BBObject* assitance = self.assitances[indexPath.row];
  BBObject* user = [assitance objectForField:@"users"];
  NSString* name = [user stringForField:@"nickname"];
  cell.textLabel.text = name;
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
