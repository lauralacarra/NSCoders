//
//  DetailThemeiPadController.h
//  ocean
//
//  Created by Tope on 12/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MasterViewController.h"
#import "ADVPopoverProgressBar.h"
#import "KSCustomPopoverBackgroundView.h"
#import "PopoverDemoController.h"

@interface DetailThemeiPadController : UIViewController<UIPopoverControllerDelegate, MasterViewControllerDelegate, PopoverDemoControllerDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, strong) IBOutlet UIToolbar* toolbar;

@property (nonatomic, strong) IBOutlet UIView* shadowView;

@property (nonatomic, strong) IBOutlet UISlider* slider;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *showPopoverButton;

@property (nonatomic, strong) ADVPopoverProgressBar *progressBar;

@property (nonatomic, strong) UIPopoverController *popoverController;
@property (strong, nonatomic) IBOutlet UIView *viewTestImg;

-(IBAction)valueChanged:(id)sender;

-(CALayer *)createShadowWithFrame:(CGRect)frame;

-(UIBarButtonItem*)createBarButtonWithImageName:(NSString *)imageName andSelectedImage:(NSString*)selectedImageName;

-(UIBarButtonItem*)createBarButtonWithImageName:(NSString *)imageName selectedImage:(NSString*)selectedImageName andSelector:(SEL)selector;

- (IBAction)showAlert:(id)sender;

- (IBAction)togglePopover:(id)sender;
@end
