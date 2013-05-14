//
//  PopoverDemoController.m
//  ocean
//
//  Created by Tope on 18/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PopoverDemoController.h"
#import "PopoverSegment.h"

@implementation PopoverDemoController

@synthesize delegate;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320, 320);
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Title";
    
    self.contentSizeForViewInPopover = CGSizeMake(320, 320);
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    
    [self.navigationItem setRightBarButtonItem:editItem];
    
    self.navigationController.toolbarHidden = NO;
    NSArray *segmentedItems = [NSArray arrayWithObjects:@"Bookmarks", @"Recents", @"Contacts", nil];
    PopoverSegment *ctrl = [[PopoverSegment alloc] init];
    ctrl.titles = segmentedItems;
    ctrl.frame = CGRectMake(0.0f, 5.0f, 310.0f, 30.0f);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:ctrl];
    
    NSArray *theToolbarItems = [NSArray arrayWithObjects:item, nil];
    [self setToolbarItems:theToolbarItems];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //Initialize the array.
    listOfItems = [[NSMutableArray alloc] init];
    
    NSArray *countriesToLiveInArray = [NSArray arrayWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland", nil];
    NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObject:countriesToLiveInArray forKey:@"Countries"];
    
    NSArray *countriesLivedInArray = [NSArray arrayWithObjects:@"India", @"U.S.A", nil];
    NSDictionary *countriesLivedInDict = [NSDictionary dictionaryWithObject:countriesLivedInArray forKey:@"Countries"];
    
    [listOfItems addObject:countriesToLiveInDict];
    [listOfItems addObject:countriesLivedInDict];
    
    //Initialize the copy array.
    copyListOfItems = [[NSMutableArray alloc] init];
    
    //Set the title
    self.navigationItem.title = @"Countries";
    
    //Add the search bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    searching = NO;
    letUserSelectRow = YES;
}


- (IBAction)done:(id)sender
{
    [self.delegate popoverDemoControllerDidFinish:self];
}

#pragma mark - UISearchBar delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    
    searching = YES;
    letUserSelectRow = NO;
    self.tableView.scrollEnabled = NO;
    
    //Add the done button.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self action:@selector(doneSearching_Clicked:)];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        
        searching = YES;
        letUserSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
    }
    
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    [self searchTableView];
}

- (void) searchTableView {
    
    NSString *searchText = searchBar.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in listOfItems)
    {
        NSArray *array = [dictionary objectForKey:@"Countries"];
        [searchArray addObjectsFromArray:array];
    }
    
    for (NSString *sTemp in searchArray)
    {
        NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0)
            [copyListOfItems addObject:sTemp];
    }
    
    searchArray = nil;
}

- (void) doneSearching_Clicked:(id)sender {
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    [self.navigationItem setRightBarButtonItem:editItem];
    
    self.tableView.scrollEnabled = YES;
    
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (searching)
        return 1;
    else
        return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching)
        return [copyListOfItems count];
    else {
        
        //Number of rows it should expect should be based on the section
        NSDictionary *dictionary = [listOfItems objectAtIndex:section];
        NSArray *array = [dictionary objectForKey:@"Countries"];
        return [array count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(searching)
        return @"";
    
    if(section == 0)
        return @"Countries to visit";
    else
        return @"Countries visited";
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(searching)
        cell.textLabel.text = [copyListOfItems objectAtIndex:indexPath.row];
    else {
        
        //First get the dictionary object
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Countries"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *selectedCountry = nil;
    
    if(searching)
        selectedCountry = [copyListOfItems objectAtIndex:indexPath.row];
    else {
        
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Countries"];
        selectedCountry = [array objectAtIndex:indexPath.row];
    }
    NSLog(@"selected: %@", selectedCountry);
}

@end
