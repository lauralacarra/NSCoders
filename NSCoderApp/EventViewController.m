//
//  EventViewController.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@property (nonatomic, strong) NSArray *comments;

@end

@implementation EventViewController
@synthesize date;
@synthesize name;
@synthesize time;
@synthesize description;
@synthesize assistSelection;

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
    [self setTableViewHeaderContent];

  
    self.title = @"Evento";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    // [self refreshComments:NO];
    [self.refreshControl beginRefreshing];
    [self refresh];


}

#pragma mark - Table Header customization

- (void)setTableViewHeaderContent {
  self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:
                                    CGRectMake(0.0, 0.0, 320.0, 200.0)];
  [self setDateLabel];
  [self setNameLabel];
  [self setTimeLabel];
  [self setDescriptionLabel];
  [self setAssistSelectionControl];

  [self createConstraints];
}

- (void)createConstraints {
  NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(date,
                                                                name,
                                                                time,
                                                                description,
                                                                assistSelection);
  NSArray* constraint1 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                                          @"H:|-[date(75)]-[name(>=180)]-|"
                                              options:0
                                              metrics:nil
                                                views:viewDictionary];
  NSArray* constraint2 = [NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-[date(75)]"
                                              options:0
                                              metrics:nil
                                                views:viewDictionary];

  NSArray* constraint3 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-[date(75)]-[time]-|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  NSArray* constraint4 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-[date(75)]-[assistSelection]-|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  NSArray* constraint5 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-[name(25)]-[time(25)]-[assistSelection(35)]-[description(>=30)]-|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  NSArray* constraint6 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-[description]-|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  [self.tableView addConstraints:constraint1];
  [self.tableView addConstraints:constraint2];
  [self.tableView addConstraints:constraint3];
  [self.tableView addConstraints:constraint4];
  [self.tableView addConstraints:constraint5];
  [self.tableView addConstraints:constraint6];
}

- (void)setDateLabel {
  self.date = [[UILabel alloc] init];
  [self.date setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.date.text = [self formatDayMonth:[self.event dateForField:@"date"]];
  self.date.numberOfLines = 2;
  self.date.font = [UIFont boldSystemFontOfSize:30.0];
  self.date.backgroundColor = [UIColor clearColor];
  self.date.textAlignment = NSTextAlignmentCenter;
  [self.tableView.tableHeaderView addSubview:self.date];
}

- (NSString*)formatDayMonth:(NSDate*)dateParam {
  NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
  formatter.dateStyle = kCFDateFormatterNoStyle;
  formatter.timeStyle = kCFDateFormatterNoStyle;
  [formatter setDateFormat:@"d MMM"];
  return [formatter stringFromDate:dateParam];
}

- (NSString*)formatTime:(NSDate*)dateParam {
  NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
  formatter.dateStyle = kCFDateFormatterNoStyle;
  formatter.timeStyle = kCFDateFormatterNoStyle;
  [formatter setDateFormat:@"HH:mm"];
  return [formatter stringFromDate:dateParam];
}

- (void)setNameLabel {
  self.name = [[UILabel alloc] init];
  [self.name setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.name.text = [self.event stringForField:@"name"];
  self.name.numberOfLines = 1;
  self.name.font = [UIFont boldSystemFontOfSize:22.0];
  self.name.backgroundColor = [UIColor clearColor];
  self.name.textColor = [UIColor darkGrayColor];
  self.name.textAlignment = NSTextAlignmentLeft;
  [self.tableView.tableHeaderView addSubview:self.name];
}

- (void)setTimeLabel {
  self.time = [[UILabel alloc] init];
  [self.time setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.time.text = [self formatTime:[self.event dateForField:@"date"]];
  self.time.numberOfLines = 1;
  self.time.font = [UIFont boldSystemFontOfSize:17.0];
  self.time.backgroundColor = [UIColor clearColor];
  self.time.textColor = [UIColor grayColor];
  self.time.textAlignment = NSTextAlignmentLeft;
  [self.tableView.tableHeaderView addSubview:self.time];
}

- (void)setAssistSelectionControl {
  self.assistSelection = [[UISegmentedControl alloc]
                           initWithItems:
                           @[@"Voy",
                             @"No voy",
                             @"Quizá",]];
  [self.assistSelection addTarget:self
                           action:@selector(assistChanged)
                 forControlEvents:UIControlEventValueChanged];
  [self.assistSelection setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.tableView.tableHeaderView addSubview:self.assistSelection];
}

- (void)setDescriptionLabel {
  self.description = [[UILabel alloc] init];
  [self.description setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.description.text = [self.event stringForField:@"description"];
  self.description.numberOfLines = 0;
  self.description.font = [UIFont boldSystemFontOfSize:17.0];
  self.description.backgroundColor = [UIColor clearColor];
  self.description.textColor = [UIColor darkGrayColor];
  self.description.textAlignment = NSTextAlignmentLeft;
  [self.tableView.tableHeaderView addSubview:self.description];
}

#pragma mark - comments

- (void)refresh {
    [self refreshComments:YES];
    [self refreshEventData:YES];
}

- (void)refreshComments:(BOOL)avoidCache {
    BBQuery *query = [Backbeam queryForEntity:@"comment"];
    [query setQuery:@"where event is ?" withParams:@[self.event]];
    if (!avoidCache) {
        [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    }
    [query fetch:100 offset:0 success:^(NSArray* comments, NSInteger total, BOOL fromCache) {
        
        self.comments = comments;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
        [self.refreshControl endRefreshing];
    }];
}

- (void)refreshEventData:(BOOL)avoidCache {
  [self.event refresh:
   ^(BBObject *object){
     self.event = object;
     self.name.text = [self.event stringForField:@"name"];
     self.date.text = [self formatDayMonth:[self.event dateForField:@"date"]];
     self.time.text = [self formatTime:[self.event dateForField:@"date"]];
     self.description.text = [self.event stringForField:@"description"];
     [self.refreshControl endRefreshing];
   }
              failure:
   ^(BBObject *object, NSError* error) {
     NSLog(@"error %@", error);
     [self.refreshControl endRefreshing];
   }
   ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return @"Comments";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
      [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
      switch (indexPath.row) {
        case 0:
          cell.textLabel.text = @"Lugar de reunión";

          break;
        case 1:
          cell.textLabel.text = @"Asistentes";

          break;
        default:
          cell.textLabel.text = [NSString stringWithFormat:
                                 @"cell %d", indexPath.row];
          break;
      }
    } else {
        BBObject *comment = [self.comments objectAtIndex:indexPath.row];
        cell.textLabel.text = [comment stringForField:@"text"];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

#pragma mark - Assist selection

- (void)assistChanged {

}

@end
