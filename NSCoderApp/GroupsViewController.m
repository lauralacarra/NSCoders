//
//  GroupsViewController.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "GroupsViewController.h"
#import "Backbeam.h"
#import "GroupViewController.h"

@interface GroupsViewController ()

@property (nonatomic, strong) NSArray *groups;

@end

@implementation GroupsViewController

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
    
    BBQuery *query = [Backbeam queryForEntity:@"group"];
    [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    [query fetch:100 offset:0 success:^(NSArray* groups, NSInteger total, BOOL fromCache) {
        
        self.groups = groups;
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
    return self.groups.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BBObject *group = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = [group stringForField:@"name"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BBObject *group = [self.groups objectAtIndex:indexPath.row];
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an Object
    [prefs setObject:[group identifier] forKey:@"groupKey"];
    
    if (self.delegate) {
        [self.delegate groupChosen:group];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
