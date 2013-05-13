//
//  CommentEditViewController.m
//  NSCoderApp
//
//  Created by Daniel Vela on 5/13/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "CommentEditViewController.h"

@interface CommentEditViewController ()

@property (nonatomic, strong) UITextView* input;
@end

@implementation CommentEditViewController
@synthesize input;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setCommentInput];
    [self createConstraints];
    self.title = @"Comment";
    [self.input becomeFirstResponder];

    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createConstraints {
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(input);
    NSArray* constraint1 = [NSLayoutConstraint
                            constraintsWithVisualFormat:
                            @"H:|-[input]-|"
                            options:0
                            metrics:nil
                            views:viewDictionary];
    NSArray* constraint2 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:|-[input(150)]"
                            options:0
                            metrics:nil
                            views:viewDictionary];

    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
}

- (void)setCommentInput {
    self.input = [[UITextView alloc] init];
    [self.input setEditable:YES];
    [self.input setShowsHorizontalScrollIndicator:NO];
    [self.input setShowsVerticalScrollIndicator:YES];
    [self.input setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.input.font = [UIFont systemFontOfSize:18.0];
    self.input.backgroundColor = [UIColor clearColor];
    self.input.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.input];
}

- (void)done:(id)sender {
    if ([self.input.text isEqualToString:@""] == NO) {
        BBObject* comment = [Backbeam emptyObjectForEntity:@"comment"];
        [comment setString:self.input.text forField:@"text"];
        [comment setDate:[NSDate date] forField:@"date"];
        [comment setObject:self.event forField:@"event"];
        [comment setObject:[Backbeam currentUser] forField:@"user"];

        [comment save:^(BBObject * object) {
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(BBObject * object, NSError* error) {
            NSLog(@"Error creating comment: %@", [error localizedDescription]);
        }];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
