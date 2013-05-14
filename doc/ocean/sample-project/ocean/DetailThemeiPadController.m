//
//  DetailThemeiPadController.m
//  ocean
//
//  Created by Tope on 12/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailThemeiPadController.h"
#import "AppDelegate.h"
#import "STSegmentedControl.h"
#import "RCSwitchOnOff.h"
#import "PopoverDemoController.h"
#import "CustomPopoverBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import "BlockAlertView.h"

@implementation DetailThemeiPadController
@synthesize navigationItem;
@synthesize viewTestImg;

@synthesize toolbar, shadowView, progressBar, slider, scrollView, showPopoverButton, popoverController;


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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
    CALayer* shadowLayer = [self createShadowWithFrame:CGRectMake(0, 0, 768, 5)];
    
    [shadowView.layer addSublayer:shadowLayer];
    
    [self.view addSubview:shadowView];
    
    
    [slider setFrame:CGRectMake(109, 320, 327, 24)];
    
    
    self.progressBar = [[ADVPopoverProgressBar alloc] initWithFrame:CGRectMake(109, 400, 327, 24) andProgressBarColor:ADVProgressBarBlue];
    [progressBar setProgress:0.5];
    
    [scrollView addSubview:progressBar];
    
    RCSwitchOnOff* onSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(179, 270, 74, 40)];
    [onSwitch setOn:YES];
    
    [scrollView addSubview:onSwitch];
    
    RCSwitchOnOff* offSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(276, 270, 74, 40)];
    [offSwitch setOn:NO];
    
    [scrollView addSubview:offSwitch];
    
    
    NSArray *objects = [NSArray arrayWithObjects:@"Yes", @"No", nil];
	STSegmentedControl *segment = [[STSegmentedControl alloc] initWithItems:objects];
	segment.frame = CGRectMake(210, 470, 120, 45);
	segment.selectedSegmentIndex = 1;
	segment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[scrollView addSubview:segment];
    
    
    UIBarButtonItem *helpItem = [self createBarButtonWithImageName:@"bar-icon-help.png" selectedImage:@"bar-icon-help-white.png" andSelector:@selector(showAlert:)];    
    UIBarButtonItem *speechItem = [self createBarButtonWithImageName:@"bar-icon-speech.png" andSelectedImage:@"bar-icon-speech-white.png"];
    UIBarButtonItem *calItem = [self createBarButtonWithImageName:@"bar-icon-cal.png" andSelectedImage:@"bar-icon-cal-white.png"];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:helpItem, speechItem, calItem, nil];
    
    [super viewDidLoad];
}

- (IBAction)showAlert:(id)sender
{
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Alert Title" message:@"This is an alert message"];
    
    [alert setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [alert addButtonWithTitle:@"OK" block:^{
        [self showAlert:nil];
    }];
    [alert show];
}

-(IBAction)valueChanged:(id)sender
{
    if([sender isKindOfClass:[UISlider class]])
    {
        UISlider *s = (UISlider*)sender;
        
        if(s.value >= 0.0 && s.value <= 1.0)
        {
            [progressBar setProgress:s.value];
        }
    }
}


-(CALayer *)createShadowWithFrame:(CGRect)frame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    
    
    UIColor* lightColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UIColor* darkColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    gradient.colors = [NSArray arrayWithObjects:(id)darkColor.CGColor, (id)lightColor.CGColor, nil];
    
    return gradient;
}

- (void)viewDidUnload
{
    [self setViewTestImg:nil];
    [self setNavigationItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)popoverDemoControllerDidFinish:(PopoverDemoController *)controller
{
    [self.popoverController dismissPopoverAnimated:YES];
    self.popoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPopover"]) 
    {
        [self togglePopover:nil];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *p = [(UIStoryboardPopoverSegue *)segue popoverController];
        p.popoverBackgroundViewClass = [KSCustomPopoverBackgroundView class];
        self.popoverController = p;
        
        popoverController.delegate = self;
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
}



- (void)splitViewController: (UISplitViewController *)splitViewController 
     willHideViewController:(UIViewController *)viewController 
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)popoverController
{
    barButtonItem.title = @"Master";
    barButtonItem.tintColor = [UIColor blueColor];
    NSMutableArray *items = [self.navigationItem.leftBarButtonItems mutableCopy]; 
    [items insertObject:barButtonItem atIndex:0];
    self.navigationItem.leftBarButtonItems = items; 

}


- (void)splitViewController:(UISplitViewController *)splitController 
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [self.navigationItem.leftBarButtonItems mutableCopy]; 
    [items removeObject:barButtonItem];
    self.navigationItem.leftBarButtonItems = items; 
    //masterPopoverController = nil;
}



-(UIBarButtonItem*)createBarButtonWithImageName:(NSString *)imageName andSelectedImage:(NSString*)selectedImageName
{
    UIImage* buttonImage = [UIImage imageNamed:imageName];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}

-(UIBarButtonItem*)createBarButtonWithImageName:(NSString *)imageName selectedImage:(NSString*)selectedImageName andSelector:(SEL)selector
{
    UIImage* buttonImage = [UIImage imageNamed:imageName];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}

@end
