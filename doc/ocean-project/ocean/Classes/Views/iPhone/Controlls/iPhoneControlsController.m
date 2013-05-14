//
//  iPhoneControlsController.m
//  ocean
//
//  Created by Tope on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "iPhoneControlsController.h"
#import "STSegmentedControl.h"
#import "RCSwitchOnOff.h"
#import "PopoverDemoController.h"
#import "CustomPopoverBackgroundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation iPhoneControlsController
@synthesize nativePB;

@synthesize progressBar, slider, scrollView, textInput;


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
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
    CALayer* shadowLayer = [self createShadowWithFrame:CGRectMake(0, 0, 320, 5)];
    
    [self.view.layer addSublayer:shadowLayer];

    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, 300, 24)];
    [slider setMaximumValue:1.0];
    [slider setMinimumValue:0.0];
    [slider setValue:0.5f];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:slider];
    
    
    self.progressBar = [[ADVPopoverProgressBar alloc] initWithFrame:CGRectMake(10, 50, 300, 24) andProgressBarColor:ADVProgressBarBlue];     
    [progressBar setProgress:0.5f];   
    [scrollView addSubview:progressBar];
    
    RCSwitchOnOff* onSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(80, 150, 74, 40)];
    [onSwitch setOn:YES];
    
    [scrollView addSubview:onSwitch];
    
    RCSwitchOnOff* offSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(170, 150, 74, 40)];
    [offSwitch setOn:NO];
    
    [scrollView addSubview:offSwitch];
    
    
    NSArray *objects = [NSArray arrayWithObjects:@"Yes", @"No", nil];
	STSegmentedControl *segment = [[STSegmentedControl alloc] initWithItems:objects];
	segment.frame = CGRectMake(100, 200, 120, 45);
	segment.selectedSegmentIndex = 1;
	segment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[scrollView addSubview:segment];
    
    [textInput addTarget:self action:@selector(doneTyping:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [textInput setReturnKeyType:UIReturnKeyDone];
    textInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textInput.leftViewMode = UITextFieldViewModeAlways;
    
    [super viewDidLoad];
}


-(IBAction)valueChanged:(id)sender
{
    if([sender isKindOfClass:[UISlider class]])
    {
        UISlider *s = (UISlider*)sender;
        
        if(s.value >= 0.0 && s.value <= 1.0)
        {
            [progressBar setProgress:s.value];
            [self.nativePB setProgress:s.value];
        }
    }
}

-(IBAction)doneTyping:(UITextField*)sender
{
    [sender resignFirstResponder];
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
    [self setNativePB:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
