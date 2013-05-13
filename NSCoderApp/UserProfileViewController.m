//
//  UserProfileViewController.m
//  NSCoderApp
//
//  Created by Laura Lacarra on 28/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "UserProfileViewController.h"
#import "ImagePickerOptionsViewController.h"
#import "SignupViewController.h"
#import "AppDelegate.h"

@interface UserProfileViewController()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *description;
- (void)showActionSheet:(id)sender; //Declare method to show action sheet
@end

@implementation UserProfileViewController

@synthesize name;
@synthesize description;
@synthesize imgPicker;
@synthesize image;
@synthesize selectedImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"111-user"];
        self.tabBarItem.title = @"User Profile";
    }
    
    //inicializamos la imágenes

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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 350, 200)];
    self.tableView.tableHeaderView = view;
    
    [self setImage];
    [self setName];
    [self setConstraints];
   
    


    
 
}

- (void) setImage{
     self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0, 200, 200.0)];
    [image setImage:[UIImage imageNamed:@"NSCoder"]];
    [image setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [image addGestureRecognizer:singleTap];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.tableView.tableHeaderView addSubview:image];

}
     
     - (void) setName{
         self.name = [[UILabel alloc] init];
         [self.name setTranslatesAutoresizingMaskIntoConstraints:NO];
         self.name.text = @"Aún no está terminado";
         self.name.numberOfLines = 1;
         self.name.font = [UIFont boldSystemFontOfSize:22.0];
         self.name.backgroundColor = [UIColor clearColor];
         self.name.textColor = [UIColor darkGrayColor];
         self.name.textAlignment = NSTextAlignmentLeft;
         [self.tableView.tableHeaderView addSubview:self.name];
     }

- (void) setConstraints {
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(image,
                                                                  name);
    NSArray* constraint1 = [NSLayoutConstraint
                            constraintsWithVisualFormat:
                            @"H:|-[image]-[name]-|"
                            options:0
                            metrics:nil
                            views:viewDictionary];

    
    [self.tableView addConstraints:constraint1];
    

}

-(void)singleTapping:(UIGestureRecognizer *)recognizer
{
    [self showActionSheet];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Cancel"]) {
       // NSLog(@" pressed --> Cancel");
    }
    if ([buttonTitle isEqualToString:@"Library"]) {
        
        [self showImagePicker];
        
    }
    if ([buttonTitle isEqualToString:@"Camera"]) {
        [self showImagePickerCamera];
    }
}


- (void)showImagePicker
  {
      UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
      ipc.delegate = self;
      [self presentViewController:ipc animated:YES completion:nil];
   
  }

- (void)showActionSheet{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library", @"Camera", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:[[appDelegate tabController] tabBar]];

}

- (void)showImagePickerCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self presentModalViewController:self.imgPicker animated:YES];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    selectedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
}









@end