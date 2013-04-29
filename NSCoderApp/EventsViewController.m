//
//  EventsViewController.m
//  NSCoderApp
//
//  Created by Laura Lacarra on 28/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//


#import "EventsViewController.h"
#import "Backbeam.h"
#import "EventViewController.h"

@interface EventsViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"List", @"Map"]];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl sizeToFit];
    CGRect frame = self.segmentedControl.frame;
    frame.size.width += 100;
    self.segmentedControl.frame = frame;
    [self.segmentedControl addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.mapView];
    self.mapView.hidden = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    BBQuery *query = [Backbeam queryForEntity:@"event"];
    [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    [query fetch:100 offset:0 success:^(NSArray* events, NSInteger total, BOOL fromCache) {
        
        self.events = events;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
}

- (void)changeView:(id)sender {
    BOOL first = self.segmentedControl.selectedSegmentIndex == 0;
    self.tableView.hidden = !first;
    self.mapView.hidden = first;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BBObject *event = [self.events objectAtIndex:indexPath.row];
    cell.textLabel.text = [event stringForField:@"name"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BBObject *event = [self.events objectAtIndex:indexPath.row];
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an Object
    [prefs setObject:[event identifier] forKey:@"eventKey"];
    
  
    EventViewController* evc = [[EventViewController alloc ] init];
    evc.event = event;
    [self.navigationController pushViewController:evc animated:YES];
}


@end