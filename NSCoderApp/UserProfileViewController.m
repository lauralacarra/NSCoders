//
//  UserProfileViewController.m
//  NSCoderApp
//
//  Created by Laura Lacarra on 28/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "UserProfileViewController.h"
//#import "ImagePickerOptionsViewController.h"
#import "SignupViewController.h"
#import "AppDelegate.h"

@interface UserProfileViewController()


@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *description;
- (void)showActionSheet:(id)sender; //Declare method to show action sheet
@end

@implementation UserProfileViewController

@synthesize name;
@synthesize description;
@synthesize imgPicker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"111-user"];
        self.tabBarItem.title = @"User Profile";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTableViewHeaderContent];
    
    BBObject *user = [Backbeam currentUser];
    
    if (user) {
        NSLog(@"already registered %@", [user stringForField:@"nickname"]);
    } else {
        UIBarButtonItem *login = [[UIBarButtonItem alloc] initWithTitle:@"login" style:UIBarButtonItemStyleDone target:self action:@selector(login:)];
        self.navigationItem.rightBarButtonItem = login;
    }
    
    self.title = @"User Profile";
   
    

}

- (void)setTableViewHeaderContent {
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(0.0, 0.0, 320.0, 200.0);
    [imageButton setImage:[UIImage imageNamed:@"NSCoder"] forState:UIControlStateNormal];
    imageButton.adjustsImageWhenHighlighted = NO;
    [imageButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView =  imageButton;
    
 
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Cancel"]) {
       // NSLog(@" pressed --> Cancel");
    }
    if ([buttonTitle isEqualToString:@"Library"]) {
        
        
    }
    if ([buttonTitle isEqualToString:@"Camera"]) {
     //   NSLog(@"Other camera");
    }
    
}


- (void)showActionSheet{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library", @"Camera", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:[[appDelegate tabController] tabBar]];

}






@end