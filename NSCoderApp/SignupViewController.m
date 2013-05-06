//
//  SignupViewController.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 25/03/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "SignupViewController.h"
#import "Backbeam.h"
#import "UIView+ActivityIndicator.h"

@interface SignupViewController ()

@property (nonatomic, strong) UITextField *nicknameField;

@end

@implementation SignupViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Signup";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.nicknameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 140, 24)];
    self.nicknameField.textColor = [UIColor darkGrayColor];
    self.nicknameField.placeholder = NSLocalizedString(@"Your nickname", @"");
    self.nicknameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nicknameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nicknameField.returnKeyType = UIReturnKeyNext;
    self.nicknameField.adjustsFontSizeToFitWidth = YES;
    self.nicknameField.clearButtonMode = UITextFieldViewModeNever;
    self.nicknameField.keyboardType = UIKeyboardTypeAlphabet;
//    self.nicknameField.inputAccessoryView = inputToolbar;
    self.nicknameField.textAlignment = NSTextAlignmentRight;
    self.nicknameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    UIBarButtonItem *signup = [[UIBarButtonItem alloc] initWithTitle:@"Signup" style:UIBarButtonItemStyleDone target:self action:@selector(signup:)];
    self.navigationItem.rightBarButtonItem = signup;
}

- (void)signup:(id)sender {
    [self.navigationController.view showActivityIndicator];
    BBQuery *query = [Backbeam queryForEntity:@"user"];
    [query setQuery:@"where nickname = ?" withParams:@[self.nicknameField.text]];
    
    [query fetch:1 offset:0 success:^(NSArray *arr, NSInteger totalCount, BOOL fromCache) {
        
        NSLog(@"results %d", totalCount);
        if (totalCount != 0) {
            NSLog(@"nickname already in use");
            [self.navigationController.view hideActivityIndicator];
            return;
        }
        
        BBObject *user = [Backbeam emptyObjectForEntity:@"user"];
        [user setString:self.nicknameField.text forField:@"nickname"];
        [user save:^(BBObject *user) {
            [self.navigationController.view hideActivityIndicator];
            
            if (self.nextViewController) {
                self.nextViewController.navigationItem.hidesBackButton = YES;
                [self.navigationController pushViewController:self.nextViewController animated:YES];
            } else {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                // TODO: execute block here?
            }
            
        } failure:^(BBObject *user, NSError *error) {
            [self.navigationController.view hideActivityIndicator];
            NSLog(@"error %@", error);
        }];
        
    } failure:^(NSError *error) {
        [self.navigationController.view hideActivityIndicator];
        NSLog(@"error %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = @"Nickname";
    cell.accessoryView = self.nicknameField;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
